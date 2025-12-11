// src/main/java/com/quizportal/controller/AdminChangePasswordServlet.java
package com.quizportal.controller;

import com.quizportal.dao.AdminDAO;
import com.quizportal.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/change-password")
public class AdminChangePasswordServlet extends HttpServlet {
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("ADMIN_ID") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }
        req.getRequestDispatcher("/admin/changePassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer adminId = (Integer) req.getSession().getAttribute("ADMIN_ID");
        if (adminId == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }
        String newPass = req.getParameter("newPassword");
        adminDAO.changePassword(adminId, PasswordUtil.hash(newPass));
        req.setAttribute("msg", "Password changed");
        req.getRequestDispatcher("/admin/changePassword.jsp").forward(req, resp);
    }
}
