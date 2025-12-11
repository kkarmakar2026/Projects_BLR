<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.quizportal.model.Question" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Question</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>body{padding-top:80px;}</style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card bg-dark border-secondary p-4">
                    <h3 class="text-white mb-3">Edit Question</h3>
                    
                    <% Question q = (Question) request.getAttribute("question"); %>
                    
                    <form method="post" action="${pageContext.request.contextPath}/admin/question/edit">
                        <input type="hidden" name="id" value="<%= q.getId() %>">
                        <input type="hidden" name="quizId" value="<%= request.getAttribute("quizId") %>">

                        <div class="mb-3">
                            <label class="text-secondary small fw-bold">Question Text</label>
                            <textarea name="text" rows="2" class="form-control bg-dark text-white border-secondary" required><%= q.getText() %></textarea>
                        </div>

                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <label class="text-secondary small">Option A</label>
                                <input type="text" name="optionA" value="<%= q.getOptionA() %>" class="form-control bg-dark text-white border-secondary" required>
                            </div>
                            <div class="col-6">
                                <label class="text-secondary small">Option B</label>
                                <input type="text" name="optionB" value="<%= q.getOptionB() %>" class="form-control bg-dark text-white border-secondary" required>
                            </div>
                            <div class="col-6">
                                <label class="text-secondary small">Option C</label>
                                <input type="text" name="optionC" value="<%= q.getOptionC() %>" class="form-control bg-dark text-white border-secondary" required>
                            </div>
                            <div class="col-6">
                                <label class="text-secondary small">Option D</label>
                                <input type="text" name="optionD" value="<%= q.getOptionD() %>" class="form-control bg-dark text-white border-secondary" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="text-secondary small fw-bold">Correct Answer</label>
                            <select name="correctOption" class="form-select bg-dark text-white border-secondary" required>
                                <option value="A" <%= "A".equals(q.getCorrectOption()) ? "selected" : "" %>>Option A</option>
                                <option value="B" <%= "B".equals(q.getCorrectOption()) ? "selected" : "" %>>Option B</option>
                                <option value="C" <%= "C".equals(q.getCorrectOption()) ? "selected" : "" %>>Option C</option>
                                <option value="D" <%= "D".equals(q.getCorrectOption()) ? "selected" : "" %>>Option D</option>
                            </select>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary-custom flex-grow-1">Save Changes</button>
                            <a href="${pageContext.request.contextPath}/admin/quiz/details?quizId=<%= request.getAttribute("quizId") %>" class="btn btn-outline-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>