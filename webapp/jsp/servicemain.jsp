<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, util.DBUtil" %>
<%
    String email = (String) session.getAttribute("teamEmail");
    if (email == null) {
        response.sendRedirect("servicelogin.jsp");
        return;
    }
%>
<html>
<head>
    <title>Service Team Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Welcome, <%= email %></h2>
        <a href="servicelogin.jsp" class="btn btn-danger">Logout</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0">📦 Upload Completed Projects for Paid Clients</h5>
        </div>
        <div class="card-body">
            <table class="table table-striped align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Appointment ID</th>
                        <th>Client Email</th>
                        <th>Amount</th>
                        <th>Upload Completed File</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection con = DBUtil.getConnection();
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT b.appointment_id, b.client_email, b.amount FROM bills b " +
                        "WHERE b.status = 'Paid' AND NOT EXISTS (" +
                        "SELECT 1 FROM deliveries d WHERE d.appointment_id = b.appointment_id)"
                    );
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        int appId = rs.getInt("appointment_id");
                        String clientEmail = rs.getString("client_email");
                %>
                    <tr>
                        <td><%= appId %></td>
                        <td><%= clientEmail %></td>
                        <td>₹<%= rs.getDouble("amount") %></td>
                        <td>
                            <form action="../uploadDelivery" method="post" enctype="multipart/form-data" class="d-flex gap-2">
                                <input type="hidden" name="appointmentId" value="<%= appId %>">
                                <input type="hidden" name="clientEmail" value="<%= clientEmail %>">
                                <input type="file" name="deliveryFile" class="form-control" required>
                                <button type="submit" class="btn btn-success btn-sm">Upload</button>
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
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
