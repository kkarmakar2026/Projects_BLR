<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Create Account - Quiz Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body {
            /* Enables scrolling on small screens while centering on big screens */
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background-color: #0d1b2a;
            padding: 20px; /* Safety padding for mobile */
        }

        .register-card {
            background-color: #1b263b;
            border: 1px solid rgba(0, 212, 255, 0.1);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            max-width: 450px;
            width: 100%;
            /* Ensure card doesn't touch edges on very small phones */
            margin-top: 40px; 
            margin-bottom: 20px;
        }

        /* Compact Back Button */
        .back-nav {
            position: absolute;
            top: 15px;
            left: 20px;
            z-index: 10;
        }

        .back-link {
            color: #6c757d;
            text-decoration: none;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            transition: 0.3s;
        }

        .back-link:hover {
            color: #00d4ff;
        }

        /* Input Styling */
        .form-control-dark {
            background-color: #0d1b2a;
            border: 1px solid #2c3e50;
            color: #e0e1dd;
            padding: 10px 15px;
            font-size: 0.95rem;
        }

        .form-control-dark:focus {
            background-color: #0d1b2a;
            border-color: #00d4ff;
            color: #fff;
            box-shadow: 0 0 0 0.2rem rgba(0, 212, 255, 0.25);
        }

        .input-group-text {
            background-color: #0d1b2a;
            border-color: #2c3e50;
            color: #00d4ff;
        }

        .link-custom {
            color: #00d4ff;
            text-decoration: none;
        }
        .link-custom:hover { text-decoration: underline; }
        
        /* Button Style Restoration (Consistent with Login) */
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
    </style>
</head>
<body>

<div class="back-nav">
    <a href="${pageContext.request.contextPath}/" class="back-link">
        <i class="bi bi-arrow-left-circle me-2 fs-5"></i> Back
    </a>
</div>

<div class="card register-card p-4">
    
    <div class="text-center mb-3">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" 
             alt="Logo" 
             class="mb-2" 
             style="height: 80px; width: auto; object-fit: contain;">
             
        <h4 class="fw-bold text-white">Create Account</h4>
    </div>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null && !error.isEmpty()) {
    %>
        <div class="alert alert-danger p-2 mb-3 small text-center" role="alert">
            <%= error %>
        </div>
    <%
        }
    %>

    <form method="post" action="register">
        
        <div class="mb-2">
            <label class="form-label text-secondary small mb-1">Full Name</label>
            <div class="input-group input-group-sm">
                <span class="input-group-text"><i class="bi bi-person-badge-fill"></i></span>
                <input type="text" name="name" class="form-control form-control-dark" required />
            </div>
        </div>

        <div class="mb-2">
            <label class="form-label text-secondary small mb-1">Email</label>
            <div class="input-group input-group-sm">
                <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                <input type="email" name="email" class="form-control form-control-dark" required />
            </div>
        </div>

        <div class="mb-2">
            <label class="form-label text-secondary small mb-1">Username</label>
            <div class="input-group input-group-sm">
                <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                <input type="text" name="username" class="form-control form-control-dark" required />
            </div>
        </div>

        <div class="mb-4">
            <label class="form-label text-secondary small mb-1">Password</label>
            <div class="input-group input-group-sm">
                <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                <input type="password" name="password" class="form-control form-control-dark" required />
            </div>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-primary-custom py-2 btn-sm fs-6">
                Register Now
            </button>
        </div>
    </form>

    <div class="mt-3 text-center">
        <p class="text-secondary small mb-0">
            Have an account? 
            <a href="${pageContext.request.contextPath}/login" class="link-custom">Login</a>
        </p>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>