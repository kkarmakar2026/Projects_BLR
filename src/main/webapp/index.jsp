<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quiz Portal - Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    
    <style>
        /* --- NAVBAR STYLES --- */
        .custom-header {
            background: linear-gradient(135deg, #0d1b2a 0%, #1b263b 100%);
            color: white;
            padding: 1rem 2rem; /* Padding for left/right spacing */
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(0, 212, 255, 0.1);
        }

        .custom-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%; /* CHANGED: Full width to push logo to corner */
            margin: 0;   /* CHANGED: Removed auto margin */
        }

        .brand-logo {
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
            color: white;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .navbar-logo {
            height: 40px; /* Maintained size */
            width: auto;
        }

        /* --- MENU STYLES --- */
        .custom-nav-menu {
            display: flex;
            list-style: none;
            gap: 2rem;
            align-items: center;
            margin: 0;
            padding: 0;
        }

        .custom-nav-menu li { position: relative; }

        .custom-nav-link {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background 0.3s;
            display: block;
            font-size: 1rem;
        }

        .custom-nav-link:hover {
            background: rgba(0, 212, 255, 0.1);
            color: #00d4ff;
        }

        /* --- DROPDOWN LOGIC --- */
        .custom-dropdown { position: relative; }
        
        .custom-dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background: #1b263b;
            min-width: 200px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            border-radius: 5px;
            border: 1px solid rgba(255,255,255,0.1);
            margin-top: 0.5rem;
            z-index: 1001;
        }

        .custom-dropdown-content a {
            color: #e0e0e0;
            padding: 12px 16px;
            display: block;
            text-decoration: none;
        }

        .custom-dropdown-content a:hover {
            background: rgba(0, 212, 255, 0.1);
            color: #00d4ff;
        }

        .custom-dropdown:hover .custom-dropdown-content { display: block; }

        /* --- MOBILE TOGGLE --- */
        .custom-menu-toggle {
            display: none;
            background: none;
            border: none;
            cursor: pointer;
            padding: 0.5rem;
        }

        .hamburger span {
            display: block;
            width: 25px;
            height: 3px;
            background: white;
            margin: 5px 0;
            transition: all 0.3s;
        }

        .mobile-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.7);
            z-index: 998;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .mobile-overlay.active { opacity: 1; }

        /* --- RESPONSIVE --- */
        @media (max-width: 768px) {
            .custom-menu-toggle { display: block; }

            .custom-nav-menu {
                position: fixed;
                right: -100%;
                top: 0;
                height: 100vh;
                width: 280px;
                background: #0d1b2a;
                flex-direction: column;
                padding: 5rem 2rem 2rem;
                gap: 0;
                align-items: flex-start;
                transition: right 0.3s ease;
                overflow-y: auto;
                z-index: 1000;
                border-left: 1px solid rgba(0, 212, 255, 0.2);
            }

            .custom-nav-menu.active { right: 0; }

            .custom-nav-menu li {
                width: 100%;
                border-bottom: 1px solid rgba(255,255,255,0.05);
            }

            .custom-nav-link { width: 100%; padding: 1rem; }

            .custom-dropdown-content {
                position: static;
                display: none;
                background: rgba(0,0,0,0.2);
                box-shadow: none;
                margin: 0;
                width: 100%;
            }
            
            .custom-dropdown.active .custom-dropdown-content { display: block; }
            .mobile-overlay { display: block; pointer-events: none; }
            .mobile-overlay.active { pointer-events: auto; }
        }

        /* --- BUTTON STYLES (Restored) --- */
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
    </style>
</head>
<body style="background-color: #0d1b2a; color: white;">

<div class="mobile-overlay" id="overlay"></div>

<header class="custom-header">
    <nav class="custom-nav">
        <a href="${pageContext.request.contextPath}/" class="brand-logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Quiz Portal" class="navbar-logo">
            <span style="letter-spacing: 1px;">QUIZ PORTAL</span>
        </a>
        
        <button class="custom-menu-toggle" id="menuBtn">
            <div class="hamburger">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </button>

        <ul class="custom-nav-menu" id="menu">
            <li>
                <a class="custom-nav-link" href="${pageContext.request.contextPath}/quizzes">
                    Browse Quizzes
                </a>
            </li>
            
            <% if (request.getSession().getAttribute("USER_ID") == null) { %>
                <li>
                    <a class="custom-nav-link" href="${pageContext.request.contextPath}/login">Login</a>
                </li>
                <li>
                    <a class="custom-nav-link" href="${pageContext.request.contextPath}/register">Sign Up</a>
                </li>
            <% } else { %>
                <li>
                    <a class="custom-nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
            <% } %>
            
            <li class="custom-dropdown" id="adminDropdown">
                <a class="custom-nav-link dropdown-toggle" href="#">Admin Access</a>
                <div class="custom-dropdown-content">
                    <% if (request.getSession().getAttribute("ADMIN_ID") == null) { %>
                        <a href="${pageContext.request.contextPath}/admin/login">Admin Login</a>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                        <a href="${pageContext.request.contextPath}/admin/logout">Logout</a>
                    <% } %>
                </div>
            </li>
        </ul>
    </nav>
</header>

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

<script>
    const menuBtn = document.getElementById('menuBtn');
    const menu = document.getElementById('menu');
    const overlay = document.getElementById('overlay');
    const adminDropdown = document.getElementById('adminDropdown');

    menuBtn.addEventListener('click', () => {
        menu.classList.toggle('active');
        overlay.classList.toggle('active');
    });

    overlay.addEventListener('click', () => {
        menu.classList.remove('active');
        overlay.classList.remove('active');
    });

    if (window.innerWidth <= 768) {
        adminDropdown.addEventListener('click', (e) => {
            if (e.target.closest('.custom-nav-link') && !e.target.closest('.custom-dropdown-content')) {
                e.preventDefault();
                adminDropdown.classList.toggle('active');
            }
        });
    }

    window.addEventListener('resize', () => {
        if (window.innerWidth > 768) {
            menu.classList.remove('active');
            overlay.classList.remove('active');
            adminDropdown.classList.remove('active');
        }
    });
</script>

</body>
</html>