<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizportal.model.Quiz" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Available Quizzes - Quiz Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body {
            padding-top: 80px;
        }

        .quiz-card {
            background-color: #1b263b;
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
            overflow: hidden;
            position: relative;
        }

        .quiz-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
            border-color: rgba(0, 212, 255, 0.3);
        }

        /* Decorative top accent */
        .quiz-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #00d4ff, #1b263b);
        }

        .quiz-icon {
            font-size: 3rem;
            color: #00d4ff;
            margin-bottom: 1rem;
            opacity: 0.9;
        }

        .quiz-title {
            color: #fff;
            font-weight: 700;
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }

        .quiz-meta {
            color: #6c757d;
            font-size: 0.85rem;
            margin-bottom: 1.5rem;
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
    
    <div class="collapse navbar-collapse" id="quizNavbar">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
        <li class="nav-item">
            <a class="nav-link active" href="#">Quizzes</a>
        </li>
        <li class="nav-item ms-lg-3">
             <a class="btn btn-sm btn-outline-danger rounded-pill px-3" href="${pageContext.request.contextPath}/logout">
                <i class="bi bi-box-arrow-right"></i> Logout
             </a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container py-4">
    
    <div class="row mb-5 text-center">
        <div class="col-lg-8 mx-auto">
            <h2 class="display-5 fw-bold text-white">Explore Quizzes</h2>
            <p class="lead text-secondary">Choose a topic below to test your knowledge and climb the leaderboard.</p>
        </div>
    </div>

    <div class="row g-4">
        <%
            List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");

            if (quizzes == null || quizzes.isEmpty()) {
        %>
            <div class="col-12 text-center py-5">
                <div class="text-secondary opacity-50 mb-3">
                    <i class="bi bi-journal-x display-1"></i>
                </div>
                <h4 class="text-white">No Quizzes Available</h4>
                <p class="text-secondary">Check back later or contact the admin.</p>
            </div>
        <%
            } else {
                for (Quiz q : quizzes) {
        %>
            <div class="col-md-6 col-lg-4">
                <div class="card quiz-card p-4 text-center">
                    
                    <div class="quiz-icon">
                        <i class="bi bi-mortarboard-fill"></i>
                    </div>

                    <h3 class="quiz-title"><%= q.getName() %></h3>
                    
                    <div class="quiz-meta">
                        <span class="badge bg-dark border border-secondary text-secondary">
                            ID: <%= q.getId() %>
                        </span>
                        <span class="mx-1">•</span>
                        <span>Ready to start</span>
                    </div>

                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/quiz/attempt?id=<%= q.getId() %>" class="btn btn-primary-custom">
                            Attempt Quiz
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/leaderboard?quizId=<%= q.getId() %>" class="btn btn-sm btn-outline-secondary border-0 mt-1">
                            <i class="bi bi-trophy"></i> View Leaderboard
                        </a>
                    </div>

                </div>
            </div>
        <%
                }
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>