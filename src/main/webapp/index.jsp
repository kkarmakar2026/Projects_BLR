<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quiz Portal - Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    
    <style>
        /* Override Bootstrap dropdown hover color */
        .dropdown-item:hover, .dropdown-item:focus {
            background-color: #00d4ff !important; 
            color: #0d1b2a !important;
        }

        /* ---- FIX: Create Account Button Hover ---- */

        .btn-primary-custom {
            border: 2px solid #00d4ff;
            color: #00d4ff;
            background-color: transparent;
            font-weight: bold;
            transition: 0.3s ease-in-out;
        }

        .btn-primary-custom:hover {
            background-color: #00d4ff !important;
            color: #0d1b2a !important; 
            border-color: #00d4ff !important;
        }

    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top" style="background-color: rgba(13, 27, 42, 0.95); border-bottom: 1px solid rgba(0, 212, 255, 0.1);">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Quiz Portal" height="50" class="me-2 rounded-circle">
        <span class="fw-bold" style="letter-spacing: 1px; color: white;">QUIZ PORTAL</span>
    </a>

    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#quizNavbar">
      <i class="bi bi-list text-white fs-2"></i>
    </button>

    <div class="collapse navbar-collapse" id="quizNavbar">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
        <li class="nav-item"><a class="nav-link text-light" href="${pageContext.request.contextPath}/quizzes">Browse Quizzes</a></li>
        
        <% if (request.getSession().getAttribute("USER_ID") == null) { %>
            <li class="nav-item ms-lg-3">
                <a class="nav-link text-light" href="${pageContext.request.contextPath}/login">Login</a>
            </li>
            <li class="nav-item">
                <a class="btn btn-sm btn-outline-light rounded-pill px-3" href="${pageContext.request.contextPath}/register">Sign Up</a>
            </li>
        <% } else { %>
            <li class="nav-item ms-lg-3">
                <a class="btn btn-sm btn-outline-danger rounded-pill px-3" href="${pageContext.request.contextPath}/logout">Logout</a>
            </li>
        <% } %>
        
        <li class="nav-item dropdown ms-lg-3">
          <a class="nav-link dropdown-toggle text-warning" href="#" role="button" data-bs-toggle="dropdown">Admin</a>
          <ul class="dropdown-menu dropdown-menu-end bg-dark border-secondary">
            <% if (request.getSession().getAttribute("ADMIN_ID") == null) { %>
                <li><a class="dropdown-item text-light" href="${pageContext.request.contextPath}/admin/login">Admin Login</a></li>
            <% } else { %>
                <li><a class="dropdown-item text-light" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li><a class="dropdown-item text-light" href="${pageContext.request.contextPath}/admin/logout">Logout</a></li>
            <% } %>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

<section class="hero-section d-flex align-items-center" style="min-height: 90vh;">
    <div class="container text-center">
        <h1 class="display-3 fw-bold hero-title mb-3" style="color: white;">Master the Art of <br><span style="color: #00d4ff;">Quizzing</span></h1>
        <p class="lead text-secondary mb-5">
            Challenge yourself with our curated collection of quizzes. <br>
            Track progress, compete with friends, and learn something new every day.
        </p>
        <div class="d-flex gap-3 justify-content-center flex-wrap">
            <a href="${pageContext.request.contextPath}/quizzes" class="btn btn-accent-custom btn-lg" style="background-color: #ff9100; color: #0d1b2a; font-weight: bold;">
                <i class="bi bi-play-fill"></i> Start Quiz
            </a>

            <% if (request.getSession().getAttribute("USER_ID") == null) { %>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary-custom btn-lg">
                Create Account
            </a>
            <% } %>

        </div>
    </div>
</section>

<footer class="text-center py-4" style="background-color: #0d1b2a; color: #6c757d; border-top: 1px solid #1b263b;">
    <div class="container">
        <p class="mb-0 small">&copy; 2025 QuizPortal. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
