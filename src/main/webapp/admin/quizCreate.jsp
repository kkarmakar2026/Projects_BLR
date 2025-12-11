<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizportal.model.Question" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Create New Quiz - Quiz Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body {
            padding-top: 80px;
        }

        .quiz-form-card {
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

        /* Question List Styling */
        .question-selection-box {
            max-height: 400px;
            overflow-y: auto;
            background-color: #0d1b2a;
            border: 1px solid #2c3e50;
            border-radius: 8px;
        }

        /* Scrollbar styling */
        .question-selection-box::-webkit-scrollbar {
            width: 8px;
        }
        .question-selection-box::-webkit-scrollbar-thumb {
            background-color: #2c3e50;
            border-radius: 4px;
        }

        .question-item {
            border-bottom: 1px solid #2c3e50;
            transition: background 0.2s;
            cursor: pointer;
        }

        .question-item:hover {
            background-color: rgba(255, 255, 255, 0.05);
        }

        .question-item:last-child {
            border-bottom: none;
        }

        .form-check-input {
            background-color: #1b263b;
            border-color: #6c757d;
            width: 1.3em;
            height: 1.3em;
        }
        
        .form-check-input:checked {
            background-color: #00d4ff;
            border-color: #00d4ff;
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
            <i class="bi bi-arrow-left"></i> Back
        </a>
    </div>
  </div>
</nav>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card quiz-form-card p-4">
                
                <div class="mb-4 text-center">
                    <div class="display-6 text-white fw-bold">Create New Quiz</div>
                    <p class="text-secondary">Define the quiz title and select questions.</p>
                </div>

                <form method="post" action="${pageContext.request.contextPath}/admin/quizzes/create">
                    
                    <div class="mb-4">
                        <label class="form-label text-secondary small text-uppercase fw-bold">Quiz Title</label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-secondary">
                                <i class="bi bi-card-heading"></i>
                            </span>
                            <input type="text" name="quizName" class="form-control form-control-dark" placeholder="e.g., Java Basics - Level 1" required />
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <label class="form-label text-secondary small text-uppercase fw-bold mb-0">Select Questions</label>
                            
                            <div class="input-group input-group-sm" style="width: 200px;">
                                <span class="input-group-text bg-dark border-secondary text-secondary"><i class="bi bi-search"></i></span>
                                <input type="text" id="questionSearch" class="form-control form-control-dark" placeholder="Filter...">
                            </div>
                        </div>

                        <div class="question-selection-box p-2">
                            <%
                                List<Question> questions = (List<Question>) request.getAttribute("questions");
                                if (questions != null && !questions.isEmpty()) {
                                    for (Question q : questions) {
                            %>
                                <label class="d-flex align-items-start p-3 question-item text-decoration-none w-100">
                                    <div class="me-3 mt-1">
                                        <input type="checkbox" name="questionId" value="<%= q.getId() %>" class="form-check-input">
                                    </div>
                                    <div class="flex-grow-1">
                                        <span class="text-white question-text"><%= q.getText() %></span>
                                        <div class="small text-secondary mt-1">
                                            <span class="badge bg-dark border border-secondary text-secondary">ID: <%= q.getId() %></span>
                                        </div>
                                    </div>
                                </label>
                            <%
                                    }
                                } else {
                            %>
                                <div class="text-center p-5 text-secondary">
                                    <i class="bi bi-exclamation-circle fs-1 mb-2"></i>
                                    <p>No questions available.</p>
                                    <a href="${pageContext.request.contextPath}/admin/questions/create" class="btn btn-sm btn-outline-info">Create Questions First</a>
                                </div>
                            <%
                                }
                            %>
                        </div>
                        <div class="form-text text-secondary mt-2">
                            Select at least one question to proceed.
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary-custom py-2">
                            Create Quiz
                        </button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('questionSearch').addEventListener('keyup', function() {
        let filter = this.value.toLowerCase();
        let items = document.querySelectorAll('.question-item');

        items.forEach(function(item) {
            let text = item.querySelector('.question-text').textContent.toLowerCase();
            if (text.includes(filter)) {
                item.style.display = 'flex'; // Restore flex display
            } else {
                item.style.display = 'none';
            }
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>