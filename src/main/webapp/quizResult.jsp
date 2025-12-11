<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.quizportal.model.Attempt" %>
<%@ page import="com.quizportal.model.Question" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Quiz Results - Quiz Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body {
            background-color: #0d1b2a;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }

        .result-card {
            background-color: #1b263b;
            border: 1px solid rgba(0, 212, 255, 0.2);
            border-radius: 20px;
            box-shadow: 0 0 40px rgba(0, 212, 255, 0.1);
            max-width: 600px;
            width: 100%;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .score-circle {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            background: radial-gradient(circle, #1b263b 0%, #0d1b2a 100%);
            border: 4px solid #00d4ff;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px auto;
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.3);
        }

        .score-number {
            font-size: 3.5rem;
            font-weight: 800;
            color: #fff;
            line-height: 1;
        }

        .score-label {
            font-size: 0.85rem;
            color: #6c757d;
            text-transform: uppercase;
            margin-top: 5px;
            letter-spacing: 1px;
        }

        .percentage-badge {
            background-color: rgba(0, 212, 255, 0.1);
            color: #00d4ff;
            border: 1px solid #00d4ff;
            padding: 5px 20px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 1.3rem;
            display: inline-block;
            margin-bottom: 20px;
        }
        
        .result-message {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 10px;
            color: #ff9100; /* Orange Accent */
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="card result-card p-5">
        
        <%
            // Retrieve data
            Attempt attempt = (Attempt) request.getAttribute("attempt");
            List<Question> questions = (List<Question>) request.getAttribute("questions");
            
            // 1. Get Totals
            int totalQuestions = (questions != null) ? questions.size() : 0;
            int rawScore = (attempt != null) ? attempt.getScore() : 0;
            
            // 2. Logic to convert Points to Count
            // Based on your previous backend code, 1 question = 10 points.
            // We divide by 10 to get the actual number of correct answers.
            int pointsPerQuestion = 10; 
            int correctAnswers = (pointsPerQuestion > 0) ? rawScore / pointsPerQuestion : 0;

            // 3. Calculate Percentage
            double percentage = 0.0;
            if (totalQuestions > 0) {
                percentage = ((double) correctAnswers / totalQuestions) * 100;
            }
            
            // 4. Feedback Message
            String feedback = "";
            if (percentage < 50) feedback = "Keep Practicing!";
            else if (percentage < 80) feedback = "Good Job!";
            else feedback = "Perfect Score!";
            
            // Get Quiz ID for links
            int quizId = (attempt != null) ? attempt.getQuizId() : 0;
        %>

        <h2 class="text-white mb-4">Quiz Completed!</h2>

        <div class="score-circle">
            <div class="score-number">
                <%= correctAnswers %> <span style="font-size: 2rem; color: #6c757d; font-weight: 300;">/</span> <%= totalQuestions %>
            </div>
            <div class="score-label">Score</div>
        </div>

        <div class="percentage-badge">
            <%= String.format("%.0f", percentage) %>%
        </div>

        <div class="result-message"><%= feedback %></div>
        
        <p class="text-secondary mb-5">
            Check the leaderboard to see your rank!
        </p>

        <div class="d-grid gap-3">
            <a href="${pageContext.request.contextPath}/leaderboard?quizId=<%= quizId %>" class="btn btn-primary-custom py-3 fs-5">
                <i class="bi bi-trophy-fill me-2"></i> View Leaderboard
            </a>

            <a href="${pageContext.request.contextPath}/quizzes" class="btn btn-outline-secondary border-0">
                <i class="bi bi-arrow-left"></i> Back to Quizzes
            </a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>