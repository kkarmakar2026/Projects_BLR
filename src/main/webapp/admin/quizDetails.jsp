<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.quizportal.model.Question" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Quiz Content</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>body{padding-top:80px;}</style>
</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-white">Editing Quiz ID: <%= request.getAttribute("quizId") %></h2>
            <a href="${pageContext.request.contextPath}/admin/quizzes/manage" class="btn btn-outline-light">Back to Quizzes</a>
        </div>

        <% List<Question> questions = (List<Question>) request.getAttribute("questions"); 
           if(questions != null && !questions.isEmpty()) { 
               for(Question q : questions) { %>
        <div class="card bg-dark border-secondary mb-3">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-start">
                    <h5 class="text-info mb-3"><%= q.getText() %></h5>
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/admin/question/edit?id=<%= q.getId() %>&quizId=<%= request.getAttribute("quizId") %>" 
                           class="btn btn-sm btn-outline-warning">
                            <i class="bi bi-pencil"></i> Edit
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/quiz/details?action=deleteQuestion&questionId=<%= q.getId() %>&quizId=<%= request.getAttribute("quizId") %>" 
                           class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this question completely?');">
                            <i class="bi bi-trash"></i>
                        </a>
                    </div>
                </div>
                <div class="row text-secondary">
                    <div class="col-6 mb-1"><strong class="text-white">A:</strong> <%= q.getOptionA() %></div>
                    <div class="col-6 mb-1"><strong class="text-white">B:</strong> <%= q.getOptionB() %></div>
                    <div class="col-6 mb-1"><strong class="text-white">C:</strong> <%= q.getOptionC() %></div>
                    <div class="col-6 mb-1"><strong class="text-white">D:</strong> <%= q.getOptionD() %></div>
                </div>
                <div class="mt-2 text-success small fw-bold">Correct Answer: <%= q.getCorrectOption() %></div>
            </div>
        </div>
        <% }} else { %>
            <div class="alert alert-warning">No questions found in this quiz.</div>
        <% } %>
    </div>
</body>
</html>