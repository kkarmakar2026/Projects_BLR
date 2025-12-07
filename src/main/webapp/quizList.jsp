<!-- src/main/webapp/quizList.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Available Quizzes</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="container">
    <h2>Available Quizzes</h2>
    <c:if test="${empty quizzes}">
        <p>No quizzes available yet.</p>
    </c:if>
    <ul class="list">
        <c:forEach items="${quizzes}" var="q">
            <li>
                <span>${q.name}</span>
                <a class="btn" href="quiz/attempt?id=${q.id}">Attempt</a>
                <a class="btn btn-secondary" href="leaderboard?quizId=${q.id}">Leaderboard</a>
            </li>
        </c:forEach>
    </ul>
</div>
</body>
</html>
