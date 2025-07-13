<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.sql.*,util.DBUtil" %>
<%
    String email = (String) session.getAttribute("clientEmail");
    if (email == null) {
        response.sendRedirect("clientlogin.jsp");
        return;
    }
%>
<html>
<head>
    <title>Client Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Welcome, <%= email %>!</h2>
        <a href="clientlogin.jsp" class="btn btn-danger">Logout</a>
    </div>

    <!-- Upload Requirement -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-primary text-white">📤 Upload Project Requirement</div>
        <div class="card-body">
            <form action="../uploadAppointment" method="post" enctype="multipart/form-data" class="d-flex gap-2">
                <input type="file" name="requirementFile" class="form-control" required>
                <button type="submit" class="btn btn-success">Upload</button>
            </form>
        </div>
    </div>

    <!-- Download Decrypted File -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-secondary text-white">📥 Download Last Uploaded File</div>
        <div class="card-body">
            <form action="../downloadDecrypted" method="get">
                <button type="submit" class="btn btn-outline-primary">Download</button>
            </form>
        </div>
    </div>

    <!-- Bills -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-warning">💳 Your Bills</div>
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Appointment ID</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection con = DBUtil.getConnection();
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM bills WHERE client_email = ?");
                    ps.setString(1, email);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getInt("appointment_id") %></td>
                        <td>₹<%= rs.getDouble("amount") %></td>
                        <td><%= rs.getString("status") %></td>
                        <td>
                            <% if (!"Paid".equals(rs.getString("status"))) { %>
                                <form action="../paybill" method="post" class="d-inline">
                                    <input type="hidden" name="billId" value="<%= rs.getInt("id") %>">
                                    <button class="btn btn-sm btn-warning">Mark as Paid</button>
                                </form>
                            <% } else { %>
                                <span class="badge bg-success">Paid</span>
                            <% } %>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Completed Deliveries + Feedback -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-info text-white">📦 Completed Deliveries & Feedback</div>
        <div class="card-body">
            <%
                PreparedStatement dp = DBUtil.getConnection().prepareStatement(
                    "SELECT * FROM deliveries WHERE client_email = ?"
                );
                dp.setString(1, email);
                ResultSet drs = dp.executeQuery();
                while (drs.next()) {
                    int appointmentId = drs.getInt("appointment_id");
                    String fileName = new java.io.File(drs.getString("file_path")).getName();
            %>
                <div class="mb-4 border-bottom pb-3">
                    <p>
                        <strong>Appointment ID:</strong> <%= appointmentId %> <br>
                        <a href="../delivered/<%= fileName %>" class="btn btn-outline-secondary btn-sm mt-1">Download File</a>
                    </p>
                    <form action="../submitFeedback" method="post" class="row g-2">
                        <input type="hidden" name="appointmentId" value="<%= appointmentId %>">
                        <input type="hidden" name="clientEmail" value="<%= email %>">
                        <div class="col-md-2">
                            <input type="number" name="rating" min="1" max="5" class="form-control" placeholder="Rating (1–5)" required>
                        </div>
                        <div class="col-md-7">
                            <input type="text" name="comment" class="form-control" placeholder="Your feedback" required>
                        </div>
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-primary w-100">Submit Feedback</button>
                        </div>
                    </form>
                </div>
            <%
                }
            %>
        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
