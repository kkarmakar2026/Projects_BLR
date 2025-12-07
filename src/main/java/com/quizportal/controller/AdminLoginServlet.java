// src/main/java/com/quizportal/controller/AdminLoginServlet.java
package com.quizportal.controller;

import com.quizportal.dao.AdminDAO;
import com.quizportal.model.Admin;
import com.quizportal.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/admin/adminLogin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        Admin admin = adminDAO.findByUsername(username);
        if (admin != null && PasswordUtil.matches(password, admin.getPasswordHash())) {
            HttpSession session = req.getSession();
            session.setAttribute("ADMIN_ID", admin.getId());
            session.setAttribute("ADMIN_NAME", admin.getName());
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            req.setAttribute("error", "Invalid credentials");
            req.getRequestDispatcher("/admin/adminLogin.jsp").forward(req, resp);
        }
    }
}
