<!-- src/main/webapp/admin/dashboard.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<div class="container">
    <h2>Dashboard</h2>
    <div class="stats">
        <div class="card">Total Quizzes: ${totalQuizzes}</div>
        <div class="card">Total Questions: ${totalQuestions}</div>
        <div class="card">Total Users: ${totalUsers}</div>
    </div>
    <p>
        <a class="btn" href="quizzes/create">Create New Quiz</a>
        <a class="btn" href="questions/create">Add Question</a>
        <a class="btn btn-secondary" href="profile">Profile</a>
        <a class="btn btn-secondary" href="change-password">Change Password</a>
        <a class="btn btn-secondary" href="logout">Logout</a>
    </p>
</div>
</body>
</html>
