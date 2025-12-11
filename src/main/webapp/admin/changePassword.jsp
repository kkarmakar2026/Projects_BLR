<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Change Password</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            /* Ensure background matches the main theme if style.css doesn't load immediately */
            background-color: #0d1b2a; 
        }

        .settings-card {
            background-color: #1b263b;
            border: 1px solid rgba(0, 212, 255, 0.1); /* Subtle Cyan border */
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            max-width: 450px;
            width: 100%;
        }

        /* Dark Input Styles */
        .form-control-dark {
            background-color: #0d1b2a;
            border: 1px solid #2c3e50;
            color: #e0e1dd;
            padding: 12px;
        }

        .form-control-dark:focus {
            background-color: #0d1b2a;
            border-color: #00d4ff;
            color: #fff;
            box-shadow: 0 0 0 0.25rem rgba(0, 212, 255, 0.25);
        }
        
        .section-icon {
            font-size: 3rem;
            color: #00d4ff;
            background: rgba(0, 212, 255, 0.1);
            width: 80px;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 auto;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="card settings-card p-4">
        
        <div class="text-center mb-4">
            <div class="section-icon mb-3 shadow-sm">
                <i class="bi bi-shield-lock-fill"></i>
            </div>
            <h3 class="fw-bold text-white">Security Settings</h3>
            <p class="text-secondary small">Update your password to keep your account safe.</p>
        </div>

        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null && !msg.isEmpty()) {
        %>
            <div class="alert alert-success d-flex align-items-center" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <div><%= msg %></div>
            </div>
        <%
            }
        %>
        
        <%
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) {
        %>
            <div class="alert alert-danger d-flex align-items-center" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <div><%= error %></div>
            </div>
        <%
            }
        %>

        <form method="post" action="change-password">
            
            <div class="mb-4">
                <label class="form-label text-secondary small text-uppercase fw-bold">New Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-dark border-secondary text-secondary">
                        <i class="bi bi-key-fill"></i>
                    </span>
                    <input type="password" 
                           name="newPassword" 
                           class="form-control form-control-dark" 
                           placeholder="Enter new password" 
                           required 
                           minlength="6"/>
                </div>
                <div class="form-text text-secondary opacity-75 small">
                    Make sure it's at least 6 characters long.
                </div>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary-custom">
                    Update Password
                </button>
                
                <a href="dashboard.jsp" class="btn btn-sm text-secondary mt-2">
                    <i class="bi bi-arrow-left"></i> Cancel & Return
                </a>
            </div>
        </form>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>