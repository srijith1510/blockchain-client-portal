
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, util.DBUtil" %>
<%
    String email = (String) session.getAttribute("adminEmail");
    if (email == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Welcome Admin: <%= email %></h2>
        <a href="adminlogin.jsp" class="btn btn-danger">Logout</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0">📂 Appointments List (Generate/Delete Bill)</h5>
        </div>
        <div class="card-body">
            <table class="table table-striped align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Appointment ID</th>
                        <th>Client Email</th>
                        <th>File Path</th>
                        <th>Upload Time</th>
                        <th style="min-width: 380px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection con = DBUtil.getConnection();
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery("SELECT * FROM appointments");

                        while (rs.next()) {
                            int appointmentId = rs.getInt("id");
                            String clientEmail = rs.getString("client_email");
                            String filePath = rs.getString("file_path");
                            Timestamp uploadTime = rs.getTimestamp("upload_time");
                    %>
                    <tr>
                        <td><%= appointmentId %></td>
                        <td><%= clientEmail %></td>
                        <td><%= filePath %></td>
                        <td><%= uploadTime %></td>
                        <td>
                            <form action="../generatebill" method="post" class="mb-2">
                                <div class="row g-2 align-items-center">
                                    <input type="hidden" name="appointmentId" value="<%= appointmentId %>">
                                    <input type="hidden" name="clientEmail" value="<%= clientEmail %>">
                                    <div class="col">
                                        <input type="number" name="amount" placeholder="Amount ₹" step="0.01" class="form-control" required>
                                    </div>
                                    <div class="col-auto">
                                        <button type="submit" class="btn btn-primary btn-sm">Generate Bill</button>
                                    </div>
                                </div>
                            </form>
                            <form action="../deletebill" method="post" onsubmit="return confirm('Are you sure you want to delete the bill for this appointment?');">
                                <input type="hidden" name="appointmentId" value="<%= appointmentId %>">
                                <input type="hidden" name="clientEmail" value="<%= clientEmail %>">
                                <button type="submit" class="btn btn-danger btn-sm">Delete Bill</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-4">
        <a href="viewfeedback.jsp" class="btn btn-outline-secondary">📊 View Client Feedback</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>