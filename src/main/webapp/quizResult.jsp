<!-- src/main/webapp/quizResult.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Your Results</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="container">
    <h2>Your Score: ${attempt.score}</h2>
    <p><a class="btn" href="leaderboard?quizId=${attempt.quizId}">View Leaderboard</a></p>
    <h3>Answers</h3>
    <c:forEach items="${questions}" var="q" varStatus="vs">
        <div class="question">
            <h4>Q${vs.index + 1}. ${q.text}</h4>
            <ul>
                <li class="${q.correctOption=='A' ? 'correct' : ''}">A: ${q.optionA}</li>
                <li class="${q.correctOption=='B' ? 'correct' : ''}">B: ${q.optionB}</li>
                <li class="${q.correctOption=='C' ? 'correct' : ''}">C: ${q.optionC}</li>
                <li class="${q.correctOption=='D' ? 'correct' : ''}">D: ${q.optionD}</li>
            </ul>
            <p class="hint">Correct answer is highlighted.</p>
        </div>
        <hr/>
    </c:forEach>
</div>
</body>
</html>
