<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // --- 1. FETCH USER FULL NAME ---
    String fullName = (String) session.getAttribute("USER_NAME");
    
    if (fullName == null) {
        fullName = "Guest";
    }
    
    // Get first letter for Avatar
    String userInitial = (fullName.length() > 0) ? fullName.substring(0, 1).toUpperCase() : "G";
%>
<html>
<head>
    <title>Quiz Portal - Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    
    <style>
        /* --- GLOBAL DARK THEME --- */
        body {
            background-color: #0d1b2a;
            color: white;
            padding-top: 80px;
        }

        /* --- NAVBAR & LOGO --- */
        .navbar-brand img {
            height: 55px;
            width: auto;
            object-fit: contain;
        }

        /* --- TOGGLE BUTTON (LEFT ALIGN FIX) --- */
        /* Removes border and adjusts spacing so it sits nicely on the left */
        .navbar-toggler {
            border: none;
            padding: 0;
            margin-right: 15px; 
        }
        
        .navbar-toggler:focus {
            box-shadow: none;
        }

        /* --- OFFCANVAS (MOBILE MENU) --- */
        .offcanvas {
            background-color: #0d1b2a !important;
            border-left: 1px solid #00d4ff;
        }
        
        .btn-close-white {
            filter: invert(1) grayscale(100%) brightness(200%);
        }

        /* --- NAVIGATION LINKS --- */
        .nav-link {
            color: rgba(255,255,255,0.8);
            font-size: 1.1rem;
            transition: color 0.3s;
        }
        
        .nav-link:hover {
            color: #00d4ff;
        }

        /* --- USER AVATAR --- */
        .user-avatar-circle {
            width: 35px;
            height: 35px;
            background-color: #00d4ff; 
            color: #0d1b2a; 
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            border: 2px solid white;
            text-transform: uppercase;
        }

        /* --- BUTTONS --- */
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
        }

        .btn-accent-custom {
            background-color: #ff9100;
            color: #0d1b2a;
            font-weight: bold;
            border: none;
        }
        .btn-accent-custom:hover {
            background-color: #ffaa33;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top" style="background-color: rgba(13, 27, 42, 0.95); border-bottom: 1px solid rgba(0, 212, 255, 0.1);">
  <div class="container-fluid px-3 px-md-5">
    
    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#homeNavbar" aria-controls="homeNavbar">
      <i class="bi bi-list text-white fs-1"></i>
    </button>

    <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Quiz Portal" class="me-2">
        <span class="fw-bold text-white d-none d-sm-block">QUIZ PORTAL</span>
    </a>

    <div class="offcanvas offcanvas-end" tabindex="-1" id="homeNavbar" aria-labelledby="homeNavbarLabel">
      
      <div class="offcanvas-header border-bottom border-secondary">
        <h5 class="offcanvas-title fw-bold" style="color: #00d4ff;">MENU</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>

      <div class="offcanvas-body">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center">
          
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/quizzes">Browse Quizzes</a>
          </li>

          <% if (request.getSession().getAttribute("USER_ID") == null) { %>
              
              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a>
              </li>
              <li class="nav-item mt-3 mt-lg-0 ms-lg-2">
                <a class="btn btn-primary-custom rounded-pill px-4" href="${pageContext.request.contextPath}/register">Sign Up</a>
              </li>

          <% } else { %>
              
              <li class="nav-item d-flex align-items-center ms-lg-4 mt-3 mt-lg-0">
                  <div class="user-avatar-circle me-2">
                      <%= userInitial %>
                  </div>
                  <div class="d-flex flex-column lh-1 text-start">
                      <span style="font-size: 0.75rem; color: #aaa;">Welcome,</span>
                      <span style="color: #00d4ff; font-weight: bold;"><%= fullName %></span>
                  </div>
              </li>

              <li class="nav-item mt-3 mt-lg-0 ms-lg-3">
                <a class="btn btn-outline-danger rounded-pill px-3 w-100" href="${pageContext.request.contextPath}/logout">Logout</a>
              </li>

          <% } %>
          
          <li class="nav-item dropdown ms-lg-3 mt-3 mt-lg-0 border-top border-lg-0 border-secondary pt-3 pt-lg-0">
            <a class="nav-link dropdown-toggle text-warning" href="#" role="button" data-bs-toggle="dropdown">Admin</a>
            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark border-secondary">
              <% if (request.getSession().getAttribute("ADMIN_ID") == null) { %>
                  <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/login">Admin Login</a></li>
              <% } else { %>
                  <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                  <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin/logout">Logout</a></li>
              <% } %>
            </ul>
          </li>

        </ul>
      </div>
    </div>
  </div>
</nav>

<section class="hero-section d-flex align-items-center" style="min-height: 85vh;">
    <div class="container text-center">
        <h1 class="display-3 fw-bold hero-title mb-3" style="color: white;">Master the Art of <br><span style="color: #00d4ff;">Quizzing</span></h1>
        <p class="lead text-secondary mb-5">
            Challenge yourself with our curated collection of quizzes. <br>
            Track progress, compete with friends, and learn something new every day.
        </p>
        <div class="d-flex gap-3 justify-content-center flex-wrap">
            <a href="${pageContext.request.contextPath}/quizzes" class="btn btn-accent-custom btn-lg">
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