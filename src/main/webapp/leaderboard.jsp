<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="com.quizportal.model.Attempt" %>

<%-- 
    FIX: Use <%! (Declaration Tag) instead of <% (Scriptlet Tag).
    This moves the class outside of the _jspService method, allowing static members.
--%>
<%!
    static class StringUtils {
        public static String getInitials(String name) {
            return (name != null && !name.isEmpty()) ? name.substring(0, 1).toUpperCase() : "?";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Leaderboard - Quiz Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        body {
            background-color: #0d1b2a;
            color: #e0e1dd;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 70px;
        }

        /* --- NAVBAR STYLES --- */
        .custom-navbar {
            background: rgba(13, 27, 42, 0.95);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            z-index: 1030;
        }
        .navbar-logo { max-height: 45px; width: auto; object-fit: contain; }

        /* --- MAIN RANK SECTION (PODIUM) --- */
        .podium-section {
            /* Distinct Background */
            background: radial-gradient(circle at center, rgba(0, 212, 255, 0.15) 0%, rgba(13, 27, 42, 0) 70%);
            padding-bottom: 20px;
            margin-bottom: 20px;
            /* FIX: Push down to prevent header overlap */
            margin-top: 60px; 
        }

        .podium-container {
            display: flex;
            justify-content: center;
            align-items: flex-end;
            gap: 20px;
            padding-top: 40px;
        }

        .podium-item {
            text-align: center;
            position: relative;
            transition: transform 0.3s;
            width: 90px;
        }

        /* Avatar Circle */
        .avatar-circle {
            width: 70px; height: 70px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem; font-weight: bold;
            color: #fff;
            margin: 0 auto 10px;
            border: 4px solid;
            background-color: #1b263b;
            position: relative;
            box-shadow: 0 10px 20px rgba(0,0,0,0.3);
            z-index: 1;
        }

        /* Rank 1 Styling */
        .rank-1 { transform: translateY(-20px) scale(1.15); z-index: 2; }
        .rank-1 .avatar-circle { border-color: #FFD700; box-shadow: 0 0 25px rgba(255, 215, 0, 0.4); }
        .rank-1 .rank-badge { background: #FFD700; color: #000; }
        
        .crown-icon {
            position: absolute; top: -35px; left: 50%; transform: translateX(-50%);
            font-size: 2.2rem; color: #FFD700; 
            filter: drop-shadow(0 2px 5px rgba(0,0,0,0.5));
            animation: float 3s ease-in-out infinite;
            z-index: 3;
        }

        /* Rank 2 Styling */
        .rank-2 { order: 1; }
        .rank-2 .avatar-circle { border-color: #C0C0C0; }
        .rank-2 .rank-badge { background: #C0C0C0; color: #000; }

        /* Rank 3 Styling */
        .rank-3 { order: 3; }
        .rank-3 .avatar-circle { border-color: #CD7F32; }
        .rank-3 .rank-badge { background: #CD7F32; color: #000; }

        /* Number Badge (1, 2, 3) inside the circle */
        .rank-badge {
            position: absolute; bottom: -10px; left: 50%; transform: translateX(-50%);
            width: 24px; height: 24px; border-radius: 50%;
            font-size: 0.8rem; font-weight: bold;
            display: flex; align-items: center; justify-content: center;
            border: 2px solid #0d1b2a;
        }

        .player-name { 
            font-weight: bold; font-size: 0.9rem; margin-top: 15px; display: block; 
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
        }
        .player-score { font-size: 0.85rem; color: #00d4ff; font-weight: bold; }

        @keyframes float {
            0% { transform: translateX(-50%) translateY(0); }
            50% { transform: translateX(-50%) translateY(-8px); }
            100% { transform: translateX(-50%) translateY(0); }
        }

        /* --- SCROLLABLE LIST SECTION (Rank 4+) --- */
        .leaderboard-list {
            background-color: #1b263b;
            border-radius: 20px 20px 0 0;
            padding: 10px 20px 30px 20px;
            border-top: 1px solid rgba(255,255,255,0.05);
            min-height: 300px;
        }

        .list-item {
            display: flex; align-items: center;
            padding: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.05);
            transition: background 0.2s;
            border-radius: 10px;
            margin-bottom: 5px;
        }
        .list-item:hover { background-color: rgba(255,255,255,0.05); transform: translateX(5px); }
        
        .list-rank { width: 35px; font-weight: bold; color: #6c757d; font-size: 0.9rem; }
        
        .list-avatar {
            width: 40px; height: 40px; border-radius: 50%;
            background-color: #25324b; color: #e0e1dd;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; margin-right: 15px; 
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .list-info { flex-grow: 1; }
        .list-name { font-weight: 600; font-size: 0.95rem; display: block; color: white; }
        .list-score { color: #00d4ff; font-weight: bold; }

        .empty-state { text-align: center; padding: 50px 20px; color: #6c757d; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark fixed-top custom-navbar">
    <div class="container-fluid px-4">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/">
            
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" class="navbar-logo me-2" alt="Logo">
            <span class="fw-bold">Leaderboard</span>
        </a>
        
        <a href="${pageContext.request.contextPath}/quizzes" class="btn btn-sm btn-outline-info rounded-pill px-3">
            <i class="bi bi-x-lg"></i> Close
        </a>
    </div>
</nav>

<div class="container pb-5">
    
    <%
        List<Attempt> attempts = (List<Attempt>) request.getAttribute("attempts");
        Map<Integer, String> usernames = (Map<Integer, String>) request.getAttribute("usernames");

        Attempt r1 = null, r2 = null, r3 = null;
        if (attempts != null && !attempts.isEmpty()) {
            if (attempts.size() > 0) r1 = attempts.get(0);
            if (attempts.size() > 1) r2 = attempts.get(1);
            if (attempts.size() > 2) r3 = attempts.get(2);
        }
    %>

    <% if (r1 != null) { %>
    
    <div class="podium-section">
        
        <div class="podium-container">
            
            <div class="podium-item rank-2" style="visibility: <%= (r2 != null) ? "visible" : "hidden" %>">
                <div class="avatar-circle">
                    <%= (r2 != null) ? StringUtils.getInitials(usernames.get(r2.getUserId())) : "" %>
                    <div class="rank-badge">2</div>
                </div>
                <span class="player-name"><%= (r2 != null) ? usernames.get(r2.getUserId()) : "" %></span>
                <span class="player-score"><%= (r2 != null) ? (int)r2.getScore() : 0 %> pts</span>
            </div>

            <div class="podium-item rank-1">
                <i class="bi bi-crown-fill crown-icon"></i>
                <div class="avatar-circle">
                    <%= StringUtils.getInitials(usernames.get(r1.getUserId())) %>
                    <div class="rank-badge">1</div>
                </div>
                <span class="player-name"><%= usernames.get(r1.getUserId()) %></span>
                <span class="player-score"><%= (int)r1.getScore() %> pts</span>
            </div>

            <div class="podium-item rank-3" style="visibility: <%= (r3 != null) ? "visible" : "hidden" %>">
                <div class="avatar-circle">
                    <%= (r3 != null) ? StringUtils.getInitials(usernames.get(r3.getUserId())) : "" %>
                    <div class="rank-badge">3</div>
                </div>
                <span class="player-name"><%= (r3 != null) ? usernames.get(r3.getUserId()) : "" %></span>
                <span class="player-score"><%= (r3 != null) ? (int)r3.getScore() : 0 %> pts</span>
            </div>
        </div>
    </div>
    
    <% } else { %>
        <div class="empty-state">
            <i class="bi bi-trophy" style="font-size: 4rem; opacity: 0.5;"></i>
            <h4 class="mt-3">No Champions Yet</h4>
            <p>Be the first to take this quiz!</p>
        </div>
    <% } %>

    <% if (attempts != null && attempts.size() > 3) { %>
    <div class="leaderboard-list">
        <% 
            for (int i = 3; i < attempts.size(); i++) {
                Attempt a = attempts.get(i);
                String name = usernames.getOrDefault(a.getUserId(), "Unknown");
                String initial = StringUtils.getInitials(name);
        %>
        <div class="list-item">
            <div class="list-rank">#<%= (i + 1) %></div>
            <div class="list-avatar"><%= initial %></div>
            <div class="list-info">
                <span class="list-name"><%= name %></span>
            </div>
            <div class="list-score"><%= (int)a.getScore() %> pts</div>
        </div>
        <% } %>
    </div>
    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>