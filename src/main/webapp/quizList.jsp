<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizportal.model.Quiz" %>
<%
    // 1. Session Check
    if (session.getAttribute("USER_ID") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    // 2. Data Retrieval
    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
    String username = (String) session.getAttribute("USERNAME");
    if(username == null) username = "Student";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Available Quizzes - Quiz Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        /* --- GLOBAL THEME --- */
        body {
            background-color: #0d1b2a;
            color: white;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* --- NAVBAR STYLES --- */
        .custom-header {
            background: rgba(13, 27, 42, 0.95);
            border-bottom: 1px solid rgba(0, 212, 255, 0.1);
            padding: 0.8rem 2rem;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .custom-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand-logo {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
            letter-spacing: 1px;
        }
        .navbar-logo { height: 40px; width: auto; margin-right: 10px; }

        /* --- USER PROFILE STYLES --- */
        .user-profile-container {
            position: relative; 
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
        }

        .user-info {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            line-height: 1.2;
        }
        
        .welcome-text { font-size: 0.75rem; color: #a0a0a0; text-transform: uppercase; }
        .username-text { font-size: 0.95rem; font-weight: bold; color: white; }

        .user-avatar {
            width: 45px; height: 45px; border-radius: 50%; object-fit: cover;
            border: 2px solid #00d4ff; transition: transform 0.2s, box-shadow 0.2s;
        }

        .user-profile-container:hover .user-avatar {
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(0, 212, 255, 0.5);
        }

        .profile-dropdown-menu {
            display: none; 
            position: absolute; top: 60px; right: 0;
            background-color: #1b263b; border: 1px solid rgba(0, 212, 255, 0.2);
            border-radius: 10px; box-shadow: 0 5px 20px rgba(0,0,0,0.5);
            min-width: 180px; z-index: 1001; padding: 5px 0;
        }
        
        .profile-dropdown-menu.active { display: block; }

        .profile-link {
            display: flex; align-items: center; padding: 12px 20px;
            color: white; text-decoration: none; transition: background 0.2s; font-size: 0.9rem;
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }
        .profile-link:last-child { border-bottom: none; }
        .profile-link:hover { background-color: rgba(0, 212, 255, 0.1); color: #00d4ff; }
        
        .logout-btn { color: #ff6b6b; }

        /* --- SEARCH BAR --- */
        .search-container {
            position: relative;
            max-width: 600px;
            margin: 0 auto;
        }
        .search-input {
            background-color: #1b263b;
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: white;
            padding: 12px 20px;
            border-radius: 30px;
            width: 100%;
            padding-left: 45px;
            transition: 0.3s;
        }
        .search-input:focus {
            outline: none;
            border-color: #00d4ff;
        }
        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        /* --- QUIZ CARD STYLES --- */
        .quiz-card {
            background-color: #1b263b;
            border: 1px solid rgba(0, 212, 255, 0.1);
            border-radius: 15px;
            transition: transform 0.3s;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .quiz-card:hover {
            transform: translateY(-5px);
            border-color: #00d4ff;
        }
        
        .card-header-icon {
            font-size: 2.5rem; color: #00d4ff; margin-bottom: 0.5rem;
        }
        
        .badge-category {
            background-color: rgba(0, 212, 255, 0.15);
            color: #00d4ff;
            font-size: 0.75rem;
            padding: 5px 10px;
            border-radius: 20px;
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .meta-info {
            display: flex;
            justify-content: center;
            gap: 15px;
            font-size: 0.85rem;
            color: #a0a0a0;
            margin-bottom: 15px;
        }
        
        .meta-item { display: flex; align-items: center; gap: 5px; }

        /* Buttons */
        .btn-group-custom {
            margin-top: auto;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }
        
        .btn-start {
            background-color: #00d4ff; border: none;
            color: #0d1b2a; font-weight: bold; padding: 8px;
            text-decoration: none; border-radius: 8px; transition: 0.3s;
            text-align: center;
        }
        .btn-start:hover { background-color: #00b8e6; color: black; }

        .btn-leader {
            background-color: transparent; border: 1px solid rgba(255, 255, 255, 0.2);
            color: #e0e0e0; font-weight: 500; padding: 8px;
            text-decoration: none; border-radius: 8px; transition: 0.3s;
            text-align: center;
        }
        .btn-leader:hover { border-color: #ff9100; color: #ff9100; }
    </style>
</head>
<body>

<header class="custom-header">
    <nav class="custom-nav">
        <a href="${pageContext.request.contextPath}/" class="brand-logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Logo" class="navbar-logo">
            <span>QUIZ PORTAL</span>
        </a>

        <div class="user-profile-container" id="userProfileBtn">
            <div class="user-info">
                <span class="welcome-text">Welcome,</span>
                <span class="username-text"><%= username %></span>
            </div>
            <img src="${pageContext.request.contextPath}/assets/images/userlogo.jpg" alt="User" class="user-avatar">
            
            <div class="profile-dropdown-menu" id="userDropdown">
                <a href="${pageContext.request.contextPath}/results" class="profile-link">
                    <i class="bi bi-clipboard-data me-2"></i> My Results
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="profile-link logout-btn">
                    <i class="bi bi-box-arrow-right me-2"></i> Logout
                </a>
            </div>
        </div>
    </nav>
</header>

<div class="container py-5">
    
    <div class="row mb-5 text-center">
        <div class="col-lg-8 mx-auto">
            <h2 class="display-5 fw-bold text-white mb-3">Select a Quiz</h2>
            <div class="search-container">
                <i class="bi bi-search search-icon"></i>
                <input type="text" id="quizSearchInput" class="search-input" 
                       placeholder="Search by quiz name or category...">
            </div>
        </div>
    </div>

    <div class="row g-4" id="quizGrid">
        <% if (quizzes == null || quizzes.isEmpty()) { %>
            <div class="col-12 text-center py-5">
                <h4 class="text-white">No Quizzes Available</h4>
            </div>
        <% } else { 
            for (Quiz q : quizzes) { 
                // DYNAMIC DATA FROM THE UPDATED MODEL
                String category = (q.getCategory() != null && !q.getCategory().isEmpty()) ? q.getCategory() : "General";
                int qCount = q.getQuestionCount(); 
        %>
            <div class="col-md-6 col-lg-4 quiz-item" 
                 data-name="<%= q.getName().toLowerCase() %>" 
                 data-category="<%= category.toLowerCase() %>">
                 
                <div class="card quiz-card p-4 text-center">
                    <div class="card-header-icon"><i class="bi bi-mortarboard-fill"></i></div>
                    
                    <div>
                        <span class="badge-category"><%= category %></span>
                    </div>

                    <h4 class="text-white mb-2"><%= q.getName() %></h4>
                    
                    <div class="meta-info">
                        <div class="meta-item">
                            <i class="bi bi-clock"></i> <%= q.getTimeLimit() %> mins
                        </div>
                        <div class="meta-item">
                            <i class="bi bi-question-circle"></i> <%= qCount %> Qs
                        </div>
                    </div>

                    <div class="btn-group-custom">
                        <a href="${pageContext.request.contextPath}/quiz/attempt?id=<%= q.getId() %>" class="btn-start">
                            Attempt
                        </a>
                        <a href="${pageContext.request.contextPath}/leaderboard?quizId=<%= q.getId() %>" class="btn-leader">
                            <i class="bi bi-trophy-fill"></i> Rank
                        </a>
                    </div>
                </div>
            </div>
        <% }} %>
    </div>
    
    <div id="noResultsMsg" class="text-center mt-5" style="display: none;">
        <h5 class="text-secondary">No quizzes found matching your search.</h5>
    </div>
</div>

<script>
    // --- DROPDOWN LOGIC ---
    const userBtn = document.getElementById('userProfileBtn');
    const userMenu = document.getElementById('userDropdown');

    userBtn.addEventListener('click', (e) => {
        e.stopPropagation(); 
        userMenu.classList.toggle('active');
    });

    document.addEventListener('click', (e) => {
        if (!userMenu.contains(e.target) && !userBtn.contains(e.target)) {
            userMenu.classList.remove('active');
        }
    });

    // --- SEARCH LOGIC ---
    const searchInput = document.getElementById('quizSearchInput');
    const quizItems = document.querySelectorAll('.quiz-item');
    const noResultsMsg = document.getElementById('noResultsMsg');

    searchInput.addEventListener('keyup', function() {
        const query = searchInput.value.toLowerCase();
        let visibleCount = 0;

        quizItems.forEach(item => {
            const name = item.getAttribute('data-name');
            const category = item.getAttribute('data-category');

            if (name.includes(query) || category.includes(query)) {
                item.style.display = 'block';
                visibleCount++;
            } else {
                item.style.display = 'none';
            }
        });

        noResultsMsg.style.display = visibleCount === 0 ? 'block' : 'none';
    });
</script>

</body>
</html>