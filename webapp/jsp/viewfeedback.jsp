<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, util.DBUtil" %>
<html>
<head>
    <title>Client Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="mb-4">📊 Client Feedback</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Appointment ID</th>
                <th>Client Email</th>
                <th>Rating</th>
                <th>Comment</th>
                <th>Submitted At</th>
            </tr>
        </thead>
        <tbody>
        <%
            Connection con = DBUtil.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM feedback");

            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("appointment_id") %></td>
                <td><%= rs.getString("client_email") %></td>
                <td><%= rs.getInt("rating") %></td>
                <td><%= rs.getString("comment") %></td>
                <td><%= rs.getTimestamp("submitted_at") %></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <a href="adminmain.jsp" class="btn btn-secondary">← Back to Admin Dashboard</a>
</div>
</body>
</html>
