<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Client Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow">
                <div class="card-header bg-success text-white">
                    <h4 class="mb-0">Client Registration</h4>
                </div>
                <div class="card-body">
                    <form action="../clientreg" method="post">
                        <div class="mb-3">
                            <label>Username</label>
                            <input name="username" type="text" class="form-control" placeholder="Enter your name" required>
                        </div>
                        <div class="mb-3">
                            <label>Email</label>
                            <input name="email" type="email" class="form-control" placeholder="Enter your email" required>
                        </div>
                        <div class="mb-3">
                            <label>Phone</label>
                            <input name="phonenumber" type="text" class="form-control" placeholder="Enter phone number" required>
                        </div>
                        <div class="mb-3">
                            <label>Password</label>
                            <input name="password" type="password" class="form-control" placeholder="Choose a password" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Register</button>
                    </form>
                </div>
                <div class="card-footer text-muted text-center small">
                    Already have an account? <a href="clientlogin.jsp">Log in here</a>.
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
