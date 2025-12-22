<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.lang.Integer" %>
<%
    // Fetching admin name from session - Ensure your LoginServlet sets this!
    String adminName = (String) session.getAttribute("ADMIN_NAME");
    if(adminName == null) adminName = "Admin";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard - Quiz Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        /* --- GLOBAL THEME --- */
        body {
            background-color: #0d1b2a;
            color: #e0e1dd;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
            margin: 0;
        }

        /* --- SIDEBAR STYLES --- */
        .sidebar {
            height: 100vh;
            width: 220px; 
            position: fixed;
            top: 0; left: 0;
            background-color: #1b263b;
            border-right: 1px solid rgba(255, 255, 255, 0.05);
            padding-top: 20px;
            z-index: 1040;
            overflow-y: auto;
            transition: transform 0.3s ease-in-out;
        }

        .sidebar-header {
            text-align: center;
            padding: 0 15px 20px 15px;
            border-bottom: 1px solid rgba(255,255,255,0.05);
            margin-bottom: 20px;
        }
        
        .sidebar-logo { max-height: 70px; object-fit: contain; }
        .brand-text { color: #fff; font-weight: 800; letter-spacing: 1px; font-size: 1.1rem; margin-top: 10px; }

        .nav-link {
            color: #a0a0a0; padding: 12px 20px; font-size: 0.9rem;
            display: flex; align-items: center; transition: 0.2s;
            border-left: 3px solid transparent; text-decoration: none;
        }

        .nav-link:hover, .nav-link.active {
            color: #ffffff; background-color: rgba(0, 212, 255, 0.05);
            border-left-color: #00d4ff;
        }
        
        .nav-link i { margin-right: 10px; font-size: 1.1rem; width: 20px; text-align: center; }

        .main-content {
            margin-left: 220px;
            padding: 30px;
            min-height: 100vh;
            transition: margin-left 0.3s ease-in-out;
        }

        /* --- DASHBOARD HEADER --- */
        .dashboard-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 30px; padding-bottom: 15px; border-bottom: 1px solid rgba(255,255,255,0.05);
        }

        .mobile-toggle-btn {
            display: none; background: transparent; border: none;
            color: #00d4ff; font-size: 1.8rem; margin-right: 15px;
        }

        /* --- NEW: ADMIN WELCOME SECTION --- */
        .admin-profile-section {
            display: flex;
            align-items: center;
            gap: 15px;
            cursor: pointer;
            position: relative;
        }

        .admin-text-info {
            display: flex;
            flex-direction: column;
            text-align: right;
            line-height: 1.2;
        }

        .admin-welcome { font-size: 0.75rem; color: #a0a0a0; text-transform: uppercase; }
        .admin-name { font-size: 0.95rem; font-weight: bold; color: white; }

        .admin-avatar {
            width: 45px; height: 45px; border-radius: 50%; object-fit: cover;
            border: 2px solid #00d4ff; background-color: #fff; padding: 2px;
        }

        .admin-dropdown {
            display: none; position: absolute; top: 55px; right: 0;
            background-color: #1b263b; border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 10px; min-width: 180px; z-index: 1050; padding: 5px 0;
        }
        .admin-dropdown.show { display: block; animation: fadeIn 0.2s; }
        .admin-dropdown a { display: flex; align-items: center; padding: 12px 20px; color: #e0e1dd; text-decoration: none; }
        .admin-dropdown a:hover { background-color: rgba(0, 212, 255, 0.1); color: #00d4ff; }

        /* --- CARDS --- */
        .dashboard-card {
            background-color: #1b263b; border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 15px; transition: transform 0.3s ease;
        }
        .dashboard-card:hover { transform: translateY(-5px); border-color: #00d4ff; }
        .stat-icon { font-size: 2.5rem; opacity: 0.8; }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        @media (max-width: 991.98px) {
            .sidebar { transform: translateX(-100%); }
            .sidebar.show { transform: translateX(0); }
            .main-content { margin-left: 0; }
            .mobile-toggle-btn { display: block; }
            .admin-text-info { display: none; } /* Hide text on small mobile to save space */
        }
    </style>
</head>
<body>

<div class="sidebar-overlay" id="sidebarOverlay"></div>

<nav class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="text-decoration-none">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Quiz Portal" class="sidebar-logo">
            <div class="brand-text">QUIZ PORTAL</div>
        </a>
    </div>

    <div class="d-flex flex-column">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active">
            <i class="bi bi-speedometer2"></i> Dashboard
        </a>
        <a class="nav-link" data-bs-toggle="collapse" href="#quizMenu">
            <i class="bi bi-ui-checks-grid"></i> Quiz Manager
            <i class="bi bi-chevron-down ms-auto" style="font-size: 0.7rem;"></i>
        </a>
        <div class="collapse collapse-menu" id="quizMenu">
            <a href="${pageContext.request.contextPath}/admin/quizzes/manage" class="nav-link sub-link">Manage Quizzes</a>
            <a href="${pageContext.request.contextPath}/admin/quiz/builder" class="nav-link sub-link">
                <span class="text-info"><i class="bi bi-plus-lg me-1"></i> Create Quiz</span>
            </a>
        </div>
        <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">
            <i class="bi bi-people"></i> Users
        </a>
    </div>
</nav>

<main class="main-content">
    <div class="dashboard-header">
        <div class="header-left">
            <button class="mobile-toggle-btn" id="mobileToggle"><i class="bi bi-list"></i></button>
            <div>
                <h6 class="text-secondary text-uppercase mb-0" style="font-size: 0.8rem;">Overview</h6>
                <h2 class="fw-bold text-white mb-0">Admin Dashboard</h2>
            </div>
        </div>

        <div class="admin-profile-section" id="adminProfileBtn">
            <div class="admin-text-info">
                <span class="admin-welcome">Welcome,</span>
                <span class="admin-name"><%= adminName %></span>
            </div>
            <img src="${pageContext.request.contextPath}/assets/images/adminlogo.png" alt="Admin" class="admin-avatar">
            
            <div class="admin-dropdown" id="adminDropdown">
                <a href="${pageContext.request.contextPath}/admin/change-password"><i class="bi bi-shield-lock me-2"></i> Password</a>
                <a href="${pageContext.request.contextPath}/admin/logout" style="color: #ff6b6b;"><i class="bi bi-box-arrow-right me-2"></i> Logout</a>
            </div>
        </div>
    </div>

    <div class="container-fluid px-0">
        <div class="row g-4 mb-5">
            <%
                Integer tQ = (Integer) request.getAttribute("totalQuizzes");
                Integer tU = (Integer) request.getAttribute("totalUsers");
            %>
            <div class="col-md-6 col-lg-4">
                <div class="card dashboard-card h-100 p-3">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <h6 class="text-secondary mb-2">Total Quizzes</h6>
                            <h2 class="display-5 fw-bold text-white mb-0"><%= (tQ != null) ? tQ : 0 %></h2>
                        </div>
                        <div class="stat-icon text-info"><i class="bi bi-stack"></i></div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card dashboard-card h-100 p-3">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <h6 class="text-secondary mb-2">Total Students</h6>
                            <h2 class="display-5 fw-bold text-white mb-0"><%= (tU != null) ? tU : 0 %></h2>
                        </div>
                        <div class="stat-icon text-success"><i class="bi bi-people-fill"></i></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const mobileToggle = document.getElementById('mobileToggle');
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('sidebarOverlay');
    const adminBtn = document.getElementById('adminProfileBtn');
    const adminMenu = document.getElementById('adminDropdown');

    mobileToggle.addEventListener('click', () => { sidebar.classList.toggle('show'); overlay.classList.toggle('active'); });
    overlay.addEventListener('click', () => { sidebar.classList.remove('show'); overlay.classList.remove('active'); });

    adminBtn.addEventListener('click', (e) => { e.stopPropagation(); adminMenu.classList.toggle('show'); });
    document.addEventListener('click', () => { adminMenu.classList.remove('show'); });
</script>
</body>
</html>