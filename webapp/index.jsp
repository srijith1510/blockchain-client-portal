<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Blockchain Client Assistance Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">🛡️ Blockchain Portal</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="text-center mb-4">
        <h1 class="display-5">Welcome to the Blockchain Client Assistance System</h1>
        <p class="lead">Secure File Upload, Client Management & Feedback Tracking</p>
    </div>

    <div class="row justify-content-center g-4">
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <h4 class="card-title">Client Access</h4>
                    <p class="card-text">Upload project requirements, view bills, and track deliveries.</p>
                    <a href="jsp/clientlogin.jsp" class="btn btn-primary w-100">Client Login</a><br><br>
                    <a href="jsp/clientregister.jsp" class="btn btn-outline-secondary w-100">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <h4 class="card-title">Admin Access</h4>
                    <p class="card-text">Manage appointments, generate bills, and view client feedback.</p>
                    <a href="jsp/adminlogin.jsp" class="btn btn-danger w-100">Admin Login</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <h4 class="card-title">Service Team</h4>
                    <p class="card-text">Access paid client records and upload completed project files.</p>
                    <a href="jsp/servicelogin.jsp" class="btn btn-info w-100">Service Login</a>
                </div>
            </div>
        </div>
    </div>

    <div class="text-center mt-5">
        <small class="text-muted">© 2025 Blockchain Portal | Designed for academic project use.</small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
