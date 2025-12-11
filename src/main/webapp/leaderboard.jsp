<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="com.quizportal.model.Attempt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Leaderboard - Top Performers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body {
            padding-top: 80px;
        }

        .leaderboard-card {
            background-color: #1b263b;
            border: 1px solid rgba(0, 212, 255, 0.1);
            border-radius: 15px;
            overflow: hidden; /* Clips the table corners */
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .table-custom {
            color: #e0e1dd;
            margin-bottom: 0;
        }

        .table-custom thead {
            background-color: rgba(0, 0, 0, 0.3);
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
        }

        .table-custom th, .table-custom td {
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            padding: 15px 20px;
            vertical-align: middle;
        }

        .table-custom tr:last-child td {
            border-bottom: none;
        }

        .table-custom tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.05);
        }

        /* Rank Badge Styling */
        .rank-badge {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
        }

        /* User Avatar Placeholder */
        .user-avatar {
            width: 40px;
            height: 40px;
            background-color: #0d1b2a;
            border: 2px solid #2c3e50;
            color: #00d4ff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 15px;
        }
        
        .score-text {
            color: #00d4ff;
            font-family: 'Courier New', monospace;
            font-weight: bold;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top" style="background-color: rgba(13, 27, 42, 0.95); border-bottom: 1px solid rgba(0, 212, 255, 0.1);">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" height="40" class="me-2 rounded-circle">
        <span class="fw-bold text-white">QUIZ PORTAL</span>
    </a>
    <div class="ms-auto">
        <a href="${pageContext.request.contextPath}/quizzes" class="btn btn-sm btn-outline-light">
            <i class="bi bi-arrow-left"></i> Back to Quizzes
        </a>
    </div>
  </div>
</nav>

<div class="container py-4">
    
    <div class="text-center mb-5">
        <div class="display-1 text-warning mb-2"><i class="bi bi-trophy-fill"></i></div>
        <h2 class="display-5 fw-bold text-white">Leaderboard</h2>
        <p class="lead text-secondary">Top performers globally.</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card leaderboard-card">
                <div class="table-responsive">
                    <table class="table table-custom">
                        <thead>
                        <tr>
                            <th class="text-center" style="width: 100px;">Rank</th>
                            <th>Player</th>
                            <th class="text-end">Score</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Attempt> attempts = (List<Attempt>) request.getAttribute("attempts");
                            Map<Integer, String> usernames = (Map<Integer, String>) request.getAttribute("usernames");

                            if (attempts != null && !attempts.isEmpty()) {
                                int rank = 1;
                                for (Attempt a : attempts) {
                                    String username = usernames.getOrDefault(a.getUserId(), "Unknown User");
                                    String initial = (username.length() > 0) ? username.substring(0, 1).toUpperCase() : "?";
                        %>
                            <tr>
                                <td class="text-center">
                                    <% if (rank == 1) { %>
                                        <div class="d-inline-block text-warning" title="1st Place"><i class="bi bi-trophy-fill fs-4"></i></div>
                                    <% } else if (rank == 2) { %>
                                        <div class="d-inline-block text-secondary" title="2nd Place"><i class="bi bi-award-fill fs-4" style="color: #c0c0c0;"></i></div>
                                    <% } else if (rank == 3) { %>
                                        <div class="d-inline-block" title="3rd Place"><i class="bi bi-award-fill fs-4" style="color: #cd7f32;"></i></div>
                                    <% } else { %>
                                        <span class="text-secondary fw-bold">#<%= rank %></span>
                                    <% } %>
                                </td>

                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="user-avatar shadow-sm"><%= initial %></div>
                                        <span class="fw-semibold text-white"><%= username %></span>
                                    </div>
                                </td>

                                <td class="text-end">
                                    <span class="score-text"><%= a.getScore() %> pts</span>
                                </td>
                            </tr>
                        <%
                                    rank++;
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="3" class="text-center py-5 text-secondary">
                                    <i class="bi bi-hourglass-split fs-2 mb-2 d-block"></i>
                                    No attempts recorded yet. Be the first!
                                </td>
                            </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>