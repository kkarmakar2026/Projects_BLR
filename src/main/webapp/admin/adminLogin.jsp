<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Login - Quiz Portal</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        /* Specific styles for the login page */
        body {
            /* Ensures the background covers the whole screen */
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-card {
            background-color: #1b263b; /* Matches your theme's card color */
            border: 1px solid rgba(0, 212, 255, 0.1);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            max-width: 400px;
            width: 100%;
        }

        .login-header {
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        /* Custom Input Styling for Dark Mode */
        .form-control-dark {
            background-color: #0d1b2a;
            border: 1px solid #2c3e50;
            color: #e0e1dd;
        }
        
        .form-control-dark:focus {
            background-color: #0d1b2a;
            border-color: #00d4ff; /* Your Cyan Color */
            color: #fff;
            box-shadow: 0 0 0 0.25rem rgba(0, 212, 255, 0.25);
        }
        
        .form-control-dark::placeholder {
            color: #6c757d;
        }

        .input-group-text {
            background-color: #0d1b2a;
            border-color: #2c3e50;
            color: #6c757d;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="card login-card p-4">
        
        <div class="text-center mb-4">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" 
                 alt="Logo" 
                 class="rounded-circle shadow-sm mb-3" 
                 style="width: 80px; height: 80px; object-fit: cover; border: 2px solid #00d4ff;">
            <h3 class="fw-bold text-white">Admin Portal</h3>
            <p class="text-secondary small">Please enter your credentials</p>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) {
        %>
            <div class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <div class="small"><%= error %></div>
            </div>
        <%
            }
        %>

        <form method="post" action="${pageContext.request.contextPath}/admin/login">
            
            <div class="mb-3">
                <label class="form-label text-secondary small">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                    <input type="text" name="username" class="form-control form-control-dark" placeholder="admin" required />
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label text-secondary small">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                    <input type="password" name="password" class="form-control form-control-dark" placeholder="••••••" required />
                </div>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary-custom">
                    Login to Dashboard
                </button>
                <a href="${pageContext.request.contextPath}/" class="btn btn-sm text-secondary mt-2">
                    <i class="bi bi-arrow-left"></i> Back to Home
                </a>
            </div>
        </form>
        
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>