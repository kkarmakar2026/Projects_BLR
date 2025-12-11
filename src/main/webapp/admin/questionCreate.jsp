<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizportal.model.Question" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Create Quiz - Quiz Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body { padding-top: 80px; }
        
        .form-card {
            background-color: #1b263b;
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .form-control-dark {
            background-color: #0d1b2a;
            border: 1px solid #2c3e50;
            color: #e0e1dd;
        }
        
        .form-control-dark:focus {
            background-color: #0d1b2a;
            border-color: #00d4ff;
            color: #fff;
            box-shadow: 0 0 0 0.25rem rgba(0, 212, 255, 0.25);
        }

        /* Scrollable List Area */
        .question-selection-box {
            max-height: 500px;
            overflow-y: auto;
            background-color: #0d1b2a;
            border: 1px solid #2c3e50;
            border-radius: 8px;
        }

        .question-item {
            border-bottom: 1px solid #2c3e50;
            cursor: pointer;
            transition: 0.2s;
        }
        .question-item:hover { background-color: rgba(255, 255, 255, 0.05); }

        .form-check-input {
            width: 1.3em; height: 1.3em;
            background-color: #1b263b; border-color: #6c757d;
        }
        .form-check-input:checked {
            background-color: #00d4ff; border-color: #00d4ff;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top" style="background-color: rgba(13, 27, 42, 0.95); border-bottom: 1px solid rgba(0, 212, 255, 0.1);">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" height="40" class="me-2 rounded-circle">
        <span class="fw-bold text-white">ADMIN PANEL</span>
    </a>
    <div class="ms-auto">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-secondary">
            <i class="bi bi-arrow-left"></i> Dashboard
        </a>
    </div>
  </div>
</nav>

<div class="container py-4">
    
    <form method="post" action="${pageContext.request.contextPath}/admin/quizzes/create" id="createQuizForm">
        
        <div class="row g-4">
            
            <div class="col-lg-4">
                <div class="card form-card p-4 h-100">
                    <div class="d-flex align-items-center mb-4">
                        <div class="fs-2 text-primary me-3"><i class="bi bi-file-earmark-plus-fill"></i></div>
                        <div>
                            <h4 class="fw-bold text-white mb-0">Quiz Details</h4>
                            <small class="text-secondary">Set title & save</small>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label text-secondary small fw-bold">QUIZ TITLE</label>
                        <input type="text" name="quizName" id="quizNameInput" class="form-control form-control-dark" 
                               placeholder="e.g. Java Basics" required 
                               value="<%= request.getParameter("quizName") != null ? request.getParameter("quizName") : "" %>">
                    </div>

                    <div class="mt-auto">
                        <button type="submit" class="btn btn-primary-custom w-100 py-2">
                            <i class="bi bi-check-lg me-2"></i> Create & Publish
                        </button>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="card form-card h-100">
                    <div class="card-header bg-transparent border-bottom border-secondary p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="text-white mb-0"><i class="bi bi-list-check me-2"></i>Select Questions</h5>
                            <span class="badge bg-dark border border-secondary text-secondary">
                                <%= request.getAttribute("msg") != null ? "Filtered View" : "All Questions" %>
                            </span>
                        </div>
                    </div>
                    
                    <div class="card-body">
                        
                        <div class="mb-3">
                            <div class="row g-2 align-items-center">
                                <div class="col-auto"><label class="text-secondary small fw-bold">SEARCH ID:</label></div>
                                <div class="col">
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark border-secondary text-secondary">#</span>
                                        <input type="number" id="searchIdInput" class="form-control form-control-dark" 
                                               placeholder="Enter ID..." 
                                               value="<%= request.getParameter("searchId") != null ? request.getParameter("searchId") : "" %>">
                                        
                                        <button type="button" onclick="performSearch()" class="btn btn-primary-custom">
                                            <i class="bi bi-search"></i>
                                        </button>
                                        
                                        <% if (request.getParameter("searchId") != null && !request.getParameter("searchId").isEmpty()) { %>
                                            <a href="${pageContext.request.contextPath}/admin/quizzes/create" class="btn btn-outline-secondary">
                                                <i class="bi bi-x-lg"></i>
                                            </a>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                            <% 
                                String error = (String) request.getAttribute("error");
                                if (error != null) { 
                            %>
                                <div class="text-danger small mt-2"><i class="bi bi-exclamation-circle me-1"></i> <%= error %></div>
                            <% } %>
                        </div>

                        <div class="question-selection-box">
                            <%
                                List<Question> questions = (List<Question>) request.getAttribute("questions");
                                if (questions != null && !questions.isEmpty()) {
                                    for (Question q : questions) {
                            %>
                                <label class="d-flex align-items-start p-3 question-item w-100">
                                    <div class="me-3 mt-1">
                                        <input type="checkbox" name="questionId" value="<%= q.getId() %>" class="form-check-input">
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="d-flex justify-content-between">
                                            <span class="text-white fw-semibold"><%= q.getText() %></span>
                                            <span class="badge bg-dark border border-secondary text-secondary align-self-start ms-2">ID: <%= q.getId() %></span>
                                        </div>
                                        <div class="small text-secondary mt-1">
                                            Correct: <span class="text-info"><%= q.getCorrectOption() %></span>
                                        </div>
                                    </div>
                                </label>
                            <%
                                    }
                                } else {
                            %>
                                <div class="text-center p-5 text-secondary">
                                    <i class="bi bi-search display-6 mb-3 d-block"></i>
                                    No questions found.
                                </div>
                            <%
                                }
                            %>
                        </div>
                        <div class="form-text text-secondary mt-2">
                            Check the boxes of the questions you want to include.
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </form>
</div>

<script>
    function performSearch() {
        const searchId = document.getElementById('searchIdInput').value;
        const currentName = document.getElementById('quizNameInput').value;
        
        // Reload page with search params (GET request), keeping the quiz name
        // Use encodeURIComponent to handle special characters safely
        window.location.href = '${pageContext.request.contextPath}/admin/quizzes/create?searchId=' + searchId + '&quizName=' + encodeURIComponent(currentName);
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>