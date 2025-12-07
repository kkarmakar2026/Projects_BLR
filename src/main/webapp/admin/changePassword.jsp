<!-- src/main/webapp/admin/changePassword.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Change Password</title>
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
<div class="container">
    <h2>Change Password</h2>
    <c:if test="${not empty msg}">
        <div class="alert alert-success">${msg}</div>
    </c:if>
    <form method="post" action="change-password">
        <label>New Password</label>
        <input type="password" name="newPassword" required />
        <button type="submit" class="btn">Update</button>
    </form>
</div>
</body>
</html>
