<!-- src/main/webapp/quizAttempt.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Attempt Quiz</title>
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<div class="container">
    <h2>Quiz</h2>
    <form method="post" action="../quiz/submit">
        <input type="hidden" name="quizId" value="${quizId}" />
        <c:forEach items="${questions}" var="q" varStatus="vs">
            <div class="question">
                <h4>Q${vs.index + 1}. ${q.text}</h4>
                <label><input type="radio" name="q_${q.id}" value="A" /> ${q.optionA}</label><br/>
                <label><input type="radio" name="q_${q.id}" value="B" /> ${q.optionB}</label><br/>
                <label><input type="radio" name="q_${q.id}" value="C" /> ${q.optionC}</label><br/>
                <label><input type="radio" name="q_${q.id}" value="D" /> ${q.optionD}</label><br/>
            </div>
            <hr/>
        </c:forEach>
        <button type="submit" class="btn">Submit</button>
    </form>
</div>
</body>
</html>
