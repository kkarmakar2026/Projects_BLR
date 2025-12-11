<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.lang.Integer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard - Quiz Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body { padding-top: 100px; }
        
        /* Stats Cards */
        .dashboard-card {
            background-color: #1b263b;
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.4);
            border-color: rgba(0, 212, 255, 0.3);
        }
        .stat-icon { font-size: 2.5rem; opacity: 0.8; }
        
        /* Quick Action Tiles */
        .action-tile {
            text-decoration: none; color: #e0e1dd; background-color: #1b263b;
            padding: 20px; border-radius: 12px; border: 1px solid rgba(255, 255, 255, 0.05);
            display: flex; align-items: center; justify-content: space-between; transition: 0.2s;
        }
        .action-tile:hover { 
            background-color: #25324b; 
            color: #00d4ff; 
            border-color: #00d4ff; 
            box-shadow: 0 0 15px rgba(0, 212, 255, 0.1);
        }
        
        /* Link Helpers */
        a.card-link { text-decoration: none; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top" style="background-color: rgba(13, 27, 42, 0.95); border-bottom: 1px solid rgba(0, 212, 255, 0.1);">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" height="45" class="me-2 rounded-circle">
        <span class="fw-bold text-white">ADMIN PANEL</span>
    </a>
    <div class="collapse navbar-collapse" id="adminNavbar">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
        <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
        <li class="nav-item ms-3"><a class="btn btn-sm btn-outline-danger rounded-pill px-3" href="${pageContext.request.contextPath}/admin/logout">Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container pb-5">
    
    <div class="row mb-4 align-items-end">
        <div class="col">
            <h6 class="text-secondary text-uppercase mb-1">Overview</h6>
            <h2 class="fw-bold text-white">Dashboard Statistics</h2>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <%
            Integer totalQuizzes = (Integer) request.getAttribute("totalQuizzes");
            Integer totalUsers = (Integer) request.getAttribute("totalUsers");
            int tQuizzes = (totalQuizzes != null) ? totalQuizzes : 0;
            int tUsers = (totalUsers != null) ? totalUsers : 0;
        %>
        
        <div class="col-md-6">
            <a href="${pageContext.request.contextPath}/admin/quizzes/manage" class="card-link">
                <div class="card dashboard-card h-100 p-3">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <h6 class="text-secondary mb-2">Total Quizzes</h6>
                            <h2 class="display-6 fw-bold text-white mb-0"><%= tQuizzes %></h2>
                        </div>
                        <div class="stat-icon" style="color: #00d4ff;"> <i class="bi bi-ui-checks-grid"></i> </div>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-6">
            <a href="${pageContext.request.contextPath}/admin/users" class="card-link">
                <div class="card dashboard-card h-100 p-3">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <h6 class="text-secondary mb-2">Registered Users</h6>
                            <h2 class="display-6 fw-bold text-white mb-0"><%= tUsers %></h2>
                        </div>
                        <div class="stat-icon text-success"> <i class="bi bi-people-fill"></i> </div>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <h4 class="text-white mb-4 fw-bold">Quick Actions</h4>
    <div class="row g-3">
        
        <div class="col-md-6">
            <a href="${pageContext.request.contextPath}/admin/quiz/builder" class="action-tile">
                <div class="d-flex align-items-center gap-3">
                    <i class="bi bi-plus-circle-fill fs-4 text-primary"></i>
                    <span class="fw-semibold">Create Quiz</span>
                </div>
                <i class="bi bi-chevron-right text-secondary small"></i>
            </a>
        </div>

        <div class="col-md-6">
            <a href="${pageContext.request.contextPath}/admin/change-password" class="action-tile">
                <div class="d-flex align-items-center gap-3">
                    <i class="bi bi-shield-lock-fill fs-4 text-danger"></i>
                    <span class="fw-semibold">Password</span>
                </div>
                <i class="bi bi-chevron-right text-secondary small"></i>
            </a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>