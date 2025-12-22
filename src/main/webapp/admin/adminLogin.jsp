<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Login - Quiz Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        /* Shared Login Styles (Matched to User Login) */
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #0d1b2a;
        }

        .login-card {
            background-color: #1b263b;
            border: 1px solid rgba(0, 212, 255, 0.1);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            max-width: 400px;
            width: 100%;
        }

        /* Dark Input Styles */
        .form-control-dark {
            background-color: #0d1b2a;
            border: 1px solid #2c3e50;
            color: #e0e1dd;
            padding: 10px 15px;
        }

        .form-control-dark:focus {
            background-color: #0d1b2a;
            border-color: #00d4ff;
            color: #fff;
            box-shadow: 0 0 0 0.25rem rgba(0, 212, 255, 0.25);
        }

        .form-control-dark::placeholder {
            color: #6c757d;
        }

        .input-group-text {
            background-color: #0d1b2a;
            border-color: #2c3e50;
            color: #00d4ff; /* Cyan Icon */
        }
        
        /* Custom Button Style */
        .btn-primary-custom {
            background-color: #00d4ff;
            color: #0d1b2a;
            font-weight: bold;
            border: none;
            transition: 0.3s;
        }
        
        .btn-primary-custom:hover {
            background-color: #ff9100;
            color: white;
        }
        
        .link-custom {
            color: #00d4ff;
            text-decoration: none;
            font-weight: 500;
        }
        
        .link-custom:hover {
            color: #ff9100;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<nav class="navbar fixed-top">
    <div class="container-fluid ps-4 pt-3">
        <a class="text-decoration-none text-white d-flex align-items-center" href="${pageContext.request.contextPath}/">
            <i class="bi bi-arrow-left-circle me-2 fs-4 text-secondary"></i> 
            <span class="text-secondary fw-bold">Back to Home</span>
        </a>
    </div>
</nav>

<div class="container d-flex justify-content-center">
    <div class="card login-card p-4">
        
        <div class="text-center mb-4">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" 
                 alt="Logo" 
                 class="mb-3" 
                 style="height: 80px; width: auto; object-fit: contain;">
                 
            <h3 class="fw-bold text-white">Admin Portal</h3>
            <p class="text-secondary small">Restricted access. Please login.</p>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) {
        %>
            <div class="alert alert-danger d-flex align-items-center p-2 mb-3 small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <div><%= error %></div>
            </div>
        <%
            }
        %>

        <form method="post" action="${pageContext.request.contextPath}/admin/login">
            
            <div class="mb-3">
                <label class="form-label text-secondary small text-uppercase fw-bold">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                    <input type="text" name="username" class="form-control form-control-dark" placeholder="Enter admin username" required />
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label text-secondary small text-uppercase fw-bold">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                    <input type="password" name="password" class="form-control form-control-dark" placeholder="Enter password" required />
                </div>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary-custom py-2">
                    Login to Dashboard
                </button>
            </div>
        </form>
        
        </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>