<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Profile - Quiz Portal</title>
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
            background-color: #0d1b2a; 
        }

        .profile-card {
            background-color: #1b263b;
            border: 1px solid rgba(0, 212, 255, 0.1);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            max-width: 500px;
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
            color: #00d4ff; /* Cyan */
            background: rgba(0, 212, 255, 0.1);
            width: 90px;
            height: 90px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 auto;
            border: 2px solid rgba(0, 212, 255, 0.2);
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="card profile-card p-4">
        
        <div class="text-center mb-4">
            <div class="section-icon mb-3 shadow-lg">
                <i class="bi bi-person-bounding-box"></i>
            </div>
            <h3 class="fw-bold text-white">Update Profile</h3>
            <p class="text-secondary small">Manage your personal details below.</p>
        </div>

        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null && !msg.isEmpty()) {
        %>
            <div class="alert alert-success d-flex align-items-center mb-4" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <div><%= msg %></div>
            </div>
        <%
            }
        %>

        <form method="post" action="profile">
            
            <div class="mb-3">
                <label class="form-label text-secondary small text-uppercase fw-bold">Full Name</label>
                <div class="input-group">
                    <span class="input-group-text bg-dark border-secondary text-secondary">
                        <i class="bi bi-person-fill"></i>
                    </span>
                    <input type="text" 
                           name="name" 
                           class="form-control form-control-dark" 
                           placeholder="Enter your full name" 
                           required />
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label text-secondary small text-uppercase fw-bold">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text bg-dark border-secondary text-secondary">
                        <i class="bi bi-envelope-fill"></i>
                    </span>
                    <input type="email" 
                           name="email" 
                           class="form-control form-control-dark" 
                           placeholder="name@example.com" 
                           required />
                </div>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary-custom">
                    Save Changes
                </button>
                
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm text-secondary mt-2">
                    <i class="bi bi-arrow-left"></i> Cancel & Return to Dashboard
                </a>
            </div>
        </form>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>