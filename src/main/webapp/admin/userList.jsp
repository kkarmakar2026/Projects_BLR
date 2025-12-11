<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.quizportal.model.User" %>
<html>
<head>
    <title>User List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>body{background-color:#0d1b2a; color:white; padding-top:80px;}</style>
</head>
<body>
    <div class="container">
        <h2 class="mb-4">Registered Users</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary mb-3">&larr; Dashboard</a>
        
        <div class="card bg-dark border-secondary">
            <div class="card-body p-0">
                <table class="table table-dark table-striped mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Full Name</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<User> users = (List<User>) request.getAttribute("users");
                           if(users != null) { for(User u : users) { %>
                        <tr>
                            <td><%= u.getId() %></td>
                            <td><%= u.getUsername() %></td>
                            <td><%= u.getName() %></td>
                            <td><%= u.getEmail() %></td>
                        </tr>
                        <% }} %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>