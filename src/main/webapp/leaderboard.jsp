<!-- src/main/webapp/leaderboard.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Leaderboard</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div class="container">
    <h2>Leaderboard</h2>
    <table class="table">
        <thead>
        <tr>
            <th>Rank</th>
            <th>User</th>
            <th>Score</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${attempts}" var="a" varStatus="vs">
            <tr>
                <td>${vs.index + 1}</td>
                <td>${usernames[a.userId]}</td>
                <td>${a.score}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <p><a href="quizzes" class="btn">Back to Quizzes</a></p>
</div>
</body>
</html>
