<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.quizportal.model.Quiz" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Quiz Settings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>body{padding-top:80px;}</style>
</head>
<body>
    
    <nav class="navbar navbar-expand-lg fixed-top" style="background-color: rgba(13, 27, 42, 0.95); border-bottom: 1px solid rgba(0, 212, 255, 0.1);">
        <div class="container">
            <span class="navbar-brand text-white fw-bold">ADMIN PANEL</span>
        </div>
    </nav>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card bg-dark border-secondary p-4 shadow-lg">
                    <div class="text-center mb-4">
                        <h3 class="text-white">Edit Quiz Settings</h3>
                        <p class="text-secondary small">Update general quiz information.</p>
                    </div>
                    
                    <% Quiz q = (Quiz) request.getAttribute("quiz"); %>
                    
                    <form method="post" action="${pageContext.request.contextPath}/admin/quiz/edit">
                        <input type="hidden" name="quizId" value="<%= q.getId() %>">

                        <div class="mb-4">
                            <label class="form-label text-secondary small fw-bold">QUIZ TITLE</label>
                            <input type="text" name="name" value="<%= q.getName() %>" 
                                   class="form-control bg-dark text-white border-secondary" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label text-secondary small fw-bold">TIME LIMIT (MINUTES)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-dark border-secondary text-secondary">
                                    <i class="bi bi-clock"></i>
                                </span>
                                <input type="number" name="timeLimit" value="<%= q.getTimeLimit() %>" 
                                       class="form-control bg-dark text-white border-secondary" min="1" required>
                            </div>
                            <div class="form-text text-secondary">Updates the countdown timer for all users.</div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary-custom">
                                Save Changes
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/quizzes/manage" class="btn btn-outline-secondary">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>