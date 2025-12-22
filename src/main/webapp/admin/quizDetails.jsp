<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.quizportal.model.Question" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Quiz Content</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { padding-top: 80px; }
        .navbar-logo {
            max-height: 50px;
            width: auto;
            object-fit: contain;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top" style="background-color: rgba(13, 27, 42, 0.95); border-bottom: 1px solid rgba(0, 212, 255, 0.1);">
        <div class="container-fluid px-4">
            <div class="d-flex justify-content-between align-items-center w-100">
                
                <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" class="navbar-logo me-2" alt="Quiz Portal">
                    <span class="fw-bold text-white">ADMIN PANEL</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-secondary text-white border-secondary">
                    <i class="bi bi-speedometer2 me-1"></i> Dashboard
                </a>
                
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h6 class="text-secondary small text-uppercase mb-1">Content Management</h6>
                <h2 class="text-white fw-bold">
                    Editing Quiz #<%= request.getAttribute("quizId") %>
                </h2>
            </div>
            
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admin/quiz/builder?quizId=<%= request.getAttribute("quizId") %>" 
                   class="btn btn-primary-custom d-flex align-items-center">
                    <i class="bi bi-plus-lg me-2"></i> Add New Question
                </a>

                <a href="${pageContext.request.contextPath}/admin/quizzes/manage" class="btn btn-outline-secondary text-white">
                    Back to Quizzes
                </a>
            </div>
        </div>

        <% List<Question> questions = (List<Question>) request.getAttribute("questions"); 
           if(questions != null && !questions.isEmpty()) { 
               for(Question q : questions) { %>
        <div class="card bg-dark border-secondary mb-3 shadow-sm">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <span class="badge bg-secondary mb-2">ID: <%= q.getId() %></span>
                        <h5 class="text-info mb-3"><%= q.getText() %></h5>
                    </div>
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
                    <div class="col-md-6 mb-2 p-2 border border-secondary rounded-start border-opacity-25 <%= q.getCorrectOption().equals("A") ? "border-success text-success bg-success bg-opacity-10" : "" %>">
                        <strong class="text-white">A:</strong> <%= q.getOptionA() %>
                    </div>
                    <div class="col-md-6 mb-2 p-2 border border-secondary rounded-end border-opacity-25 <%= q.getCorrectOption().equals("B") ? "border-success text-success bg-success bg-opacity-10" : "" %>">
                        <strong class="text-white">B:</strong> <%= q.getOptionB() %>
                    </div>
                    <div class="col-md-6 mb-2 p-2 border border-secondary rounded-start border-opacity-25 <%= q.getCorrectOption().equals("C") ? "border-success text-success bg-success bg-opacity-10" : "" %>">
                        <strong class="text-white">C:</strong> <%= q.getOptionC() %>
                    </div>
                    <div class="col-md-6 mb-2 p-2 border border-secondary rounded-end border-opacity-25 <%= q.getCorrectOption().equals("D") ? "border-success text-success bg-success bg-opacity-10" : "" %>">
                        <strong class="text-white">D:</strong> <%= q.getOptionD() %>
                    </div>
                </div>
                <div class="mt-2 text-success small fw-bold">
                    <i class="bi bi-check-circle-fill me-1"></i> Correct Answer: <%= q.getCorrectOption() %>
                </div>
            </div>
        </div>
        <% }} else { %>
            <div class="alert alert-warning text-center py-5">
                <i class="bi bi-exclamation-circle display-5 mb-3 d-block opacity-50"></i>
                No questions found in this quiz. <br>
                Click "Add New Question" to get started.
            </div>
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>