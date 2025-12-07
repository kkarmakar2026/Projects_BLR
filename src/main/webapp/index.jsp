<!-- src/main/webapp/index.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="assets/header.jsp" />
<html>
<head>
    <title>Quiz Portal</title>
    <link rel="stylesheet" href="assests/css/style.css">
</head>
<body>
<div class="container">
    <h1>Welcome to the Quiz Portal</h1>
    <p>
        <a href="quizzes" class="btn">Explore Quizzes</a>
        <a href="login" class="btn">Login</a>
        <a href="register" class="btn">Register</a>
        <a href="admin/login" class="btn btn-secondary">Admin</a>
    </p>
</div>
</body>
</html>
