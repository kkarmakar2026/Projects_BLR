<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.quizportal.model.Quiz" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Quizzes - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    
    <style>
        body { padding-top: 80px; }
        .table-dark-custom {
            background-color: #1b263b;
            color: #e0e1dd;
        }
        .table-dark-custom th {
            background-color: #0d1b2a;
            color: #00d4ff;
            border-bottom: 2px solid #2c3e50;
        }
        .table-dark-custom td {
            border-bottom: 1px solid #2c3e50;
            vertical-align: middle;
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-white">Manage Quizzes</h2>
    </div>

    <% if(request.getParameter("msg") != null) { %>
        <div class="alert alert-success d-flex align-items-center mb-3">
            <i class="bi bi-check-circle-fill me-2"></i>
            <div><%= request.getParameter("msg") %></div>
        </div>
    <% } %>

    <div class="card bg-dark border-secondary shadow-lg">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-dark-custom table-hover mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Quiz Name</th>
                            <th>Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                           List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
                           if(quizzes != null && !quizzes.isEmpty()) { 
                               for(Quiz q : quizzes) { 
                        %>
                        <tr>
                            <td class="ps-4 text-secondary">#<%= q.getId() %></td>
                            <td class="fw-bold"><%= q.getName() %></td>
                            <td>
                                <% if(q.isPublished()) { %>
                                    <span class="badge bg-success">Published</span>
                                <% } else { %>
                                    <span class="badge bg-warning text-dark">Draft</span>
                                <% } %>
                            </td>
                            
                            <td class="text-end pe-4">
                                
                                <a href="${pageContext.request.contextPath}/admin/quiz/edit?quizId=<%= q.getId() %>" 
                                   class="btn btn-sm btn-outline-primary me-2" title="Edit Time & Title">
                                    <i class="bi bi-gear-fill"></i> Settings
                                </a>

                                <a href="${pageContext.request.contextPath}/admin/quiz/details?quizId=<%= q.getId() %>" 
                                   class="btn btn-sm btn-warning text-dark fw-bold me-2" title="Edit Questions">
                                    <i class="bi bi-pencil-square"></i> Questions
                                </a>
                                
                                <a href="${pageContext.request.contextPath}/admin/quizzes/manage?action=delete&id=<%= q.getId() %>" 
                                   class="btn btn-sm btn-danger" 
                                   onclick="return confirm('Are you sure? This will delete the quiz and ALL its questions.');"
                                   title="Delete Quiz">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <% 
                               } 
                           } else { 
                        %>
                        <tr>
                            <td colspan="4" class="text-center py-5 text-secondary">
                                <i class="bi bi-folder2-open display-4 mb-3 d-block"></i>
                                No quizzes found. Go to Dashboard to create one!
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>