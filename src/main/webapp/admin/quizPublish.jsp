<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.lang.Integer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Publish Quiz - Quiz Portal</title>
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

        .success-card {
            background-color: #1b263b;
            border: 1px solid rgba(0, 212, 255, 0.2);
            border-radius: 20px;
            box-shadow: 0 0 40px rgba(0, 212, 255, 0.1);
            max-width: 500px;
            width: 100%;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        /* Decorative top bar */
        .success-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, #00d4ff, #ff9100);
        }

        .icon-circle {
            width: 100px;
            height: 100px;
            background-color: rgba(40, 167, 69, 0.1);
            border: 2px solid #28a745;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px auto;
            color: #28a745;
            font-size: 3rem;
        }

        .id-badge {
            background-color: #0d1b2a;
            border: 1px dashed #6c757d;
            border-radius: 10px;
            padding: 15px;
            margin: 20px 0;
            display: inline-block;
            min-width: 200px;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="card success-card p-5">
        
        <div class="icon-circle mb-4">
            <i class="bi bi-check-lg"></i>
        </div>

        <h2 class="fw-bold text-white mb-2">Quiz Created!</h2>
        <p class="text-secondary">Your quiz has been successfully saved as a Draft.</p>

        <%
            // Retrieve quizId set by servlet
            Integer quizId = (Integer) request.getAttribute("quizId");
            // Fallback for visual testing if null
            if (quizId == null) quizId = 0; 
        %>

        <div class="id-badge">
            <div class="text-secondary text-uppercase small" style="letter-spacing: 1px;">Generated Quiz ID</div>
            <div class="display-4 fw-bold text-white">#<%= quizId %></div>
        </div>

        <p class="text-secondary small mb-4">
            Do you want to make this quiz live for students now?
        </p>

        <form method="post" action="publish">
            <input type="hidden" name="quizId" value="<%= quizId %>" />
            
            <div class="d-grid gap-3">
                <button type="submit" class="btn btn-primary-custom py-3 fw-bold fs-5">
                    <i class="bi bi-rocket-takeoff-fill me-2"></i> Publish Now
                </button>
                
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary border-0 text-white-50">
                    <i class="bi bi-hdd-stack me-2"></i> Keep as Draft & Return to Dashboard
                </a>
            </div>
        </form>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>