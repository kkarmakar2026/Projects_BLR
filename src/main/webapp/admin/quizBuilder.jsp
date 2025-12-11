<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.quizportal.model.Quiz, com.quizportal.model.Question" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Quiz Builder - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { padding-top: 80px; }
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
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-secondary">Dashboard</a>
    </div>
  </div>
</nav>

<div class="container py-4">

    <% 
        Quiz quiz = (Quiz) request.getAttribute("quiz");
        List<Question> questions = (List<Question>) request.getAttribute("questions");
        
        // ---------------------------------------------------------
        // STATE 1: CREATE NEW QUIZ (Title & Time Limit)
        // ---------------------------------------------------------
        if (quiz == null) {
    %>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card bg-dark border-secondary p-4 text-center shadow-lg">
                    <h3 class="text-white mb-3">Start New Quiz</h3>
                    
                    <form method="post" action="${pageContext.request.contextPath}/admin/quiz/builder">
                        <input type="hidden" name="action" value="createQuiz">
                        
                        <div class="mb-3">
                            <label class="form-label text-secondary small fw-bold">QUIZ TITLE</label>
                            <input type="text" name="quizTitle" class="form-control bg-dark text-white border-secondary text-center" 
                                   placeholder="e.g. Java Advanced" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label text-secondary small fw-bold">TIME LIMIT (MINUTES)</label>
                            <div class="input-group justify-content-center">
                                <span class="input-group-text bg-dark border-secondary text-secondary">
                                    <i class="bi bi-clock"></i>
                                </span>
                                <input type="number" name="timeLimit" class="form-control bg-dark text-white border-secondary text-center" 
                                       style="max-width: 100px;" value="10" min="1" required>
                                <span class="input-group-text bg-dark border-secondary text-secondary">mins</span>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary-custom w-100 py-2">
                            Next: Add Questions &rarr;
                        </button>
                    </form>
                </div>
            </div>
        </div>
    
    <% 
        // ---------------------------------------------------------
        // STATE 2: ADD QUESTIONS (Quiz Created)
        // ---------------------------------------------------------
        } else { 
    %>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <span class="text-secondary small">EDITING QUIZ:</span>
                <h2 class="text-white fw-bold d-flex align-items-center gap-3">
                    <%= quiz.getName() %>
                    <span class="badge border border-secondary text-secondary fs-6 fw-normal">
                        <i class="bi bi-clock me-1"></i> <%= quiz.getTimeLimit() %> mins
                    </span>
                </h2>
            </div>
            
            <form method="post" action="${pageContext.request.contextPath}/admin/quiz/builder">
                <input type="hidden" name="action" value="publish">
                <input type="hidden" name="quizId" value="<%= quiz.getId() %>">
                <button type="submit" class="btn btn-success px-4" onclick="return confirm('Finish and Publish Quiz?');">
                    <i class="bi bi-check-lg me-2"></i> Finish & Publish
                </button>
            </form>
        </div>

        <div class="row g-4">
            
            <div class="col-lg-7">
                <div class="card bg-dark border-info p-4 shadow-sm">
                    <h5 class="text-info mb-3"><i class="bi bi-plus-circle me-2"></i>Add New Question</h5>
                    
                    <form method="post" action="${pageContext.request.contextPath}/admin/quiz/builder">
                        <input type="hidden" name="action" value="addQuestion">
                        <input type="hidden" name="quizId" value="<%= quiz.getId() %>">

                        <div class="mb-3">
                            <label class="text-secondary small fw-bold">Question Text</label>
                            <textarea name="text" rows="2" class="form-control bg-dark text-white border-secondary" placeholder="Type your question here..." required></textarea>
                        </div>

                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <input type="text" name="optionA" class="form-control bg-dark text-white border-secondary" placeholder="Option A" required>
                            </div>
                            <div class="col-6">
                                <input type="text" name="optionB" class="form-control bg-dark text-white border-secondary" placeholder="Option B" required>
                            </div>
                            <div class="col-6">
                                <input type="text" name="optionC" class="form-control bg-dark text-white border-secondary" placeholder="Option C" required>
                            </div>
                            <div class="col-6">
                                <input type="text" name="optionD" class="form-control bg-dark text-white border-secondary" placeholder="Option D" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="text-secondary small fw-bold">Correct Answer</label>
                            <select name="correctOption" class="form-select bg-dark text-white border-secondary" required>
                                <option value="" disabled selected>Select Correct Option...</option>
                                <option value="A">Option A</option>
                                <option value="B">Option B</option>
                                <option value="C">Option C</option>
                                <option value="D">Option D</option>
                            </select>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary-custom flex-grow-1">Add Question</button>
                            <button type="reset" class="btn btn-outline-secondary">Reset</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="card bg-dark border-secondary h-100">
                    <div class="card-header border-secondary text-white fw-bold d-flex justify-content-between">
                        <span>Questions Added</span>
                        <span class="badge bg-secondary"><%= questions != null ? questions.size() : 0 %></span>
                    </div>
                    <div class="card-body p-0" style="max-height: 500px; overflow-y: auto;">
                        <% if (questions != null && !questions.isEmpty()) { %>
                            <div class="list-group list-group-flush">
                                <% int i = 1; for (Question q : questions) { %>
                                    <div class="list-group-item bg-dark text-white border-secondary">
                                        <div class="d-flex w-100 justify-content-between align-items-center">
                                            <div>
                                                <h6 class="mb-1 text-info small">Question <%= i++ %></h6>
                                                <p class="mb-1 text-truncate" style="max-width: 250px;"><%= q.getText() %></p>
                                            </div>
                                            <span class="badge bg-success"><%= q.getCorrectOption() %></span>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        <% } else { %>
                            <div class="text-center p-5 text-secondary">
                                <i class="bi bi-journal-plus display-6 mb-3 d-block opacity-50"></i>
                                No questions added yet.
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>

        </div>

    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>