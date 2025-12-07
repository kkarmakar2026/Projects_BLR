<!-- src/main/webapp/admin/quizCreate.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Create Quiz</title>
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<div class="container">
    <h2>Create Quiz</h2>
    <form method="post" action="create">
        <label>Quiz Name</label>
        <input type="text" name="quizName" required />
        <h3>Select Questions</h3>
        <ul class="list">
            <c:forEach items="${questions}" var="q">
                <li>
                    <label>
                        <input type="checkbox" name="questionId" value="${q.id}" />
                        ${q.text}
                    </label>
                </li>
            </c:forEach>
        </ul>
        <button type="submit" class="btn">Save & Continue</button>
    </form>
</div>
</body>
</html>
