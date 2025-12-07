<!-- src/main/webapp/admin/quizPublish.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Publish Quiz</title>
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<div class="container">
    <h2>Quiz Created</h2>
    <p>Quiz ID: ${quizId}</p>
    <form method="post" action="publish">
        <input type="hidden" name="quizId" value="${quizId}" />
        <button type="submit" class="btn">Publish</button>
    </form>
    <p><a href="dashboard" class="btn btn-secondary">Back to Dashboard</a></p>
</div>
</body>
</html>
