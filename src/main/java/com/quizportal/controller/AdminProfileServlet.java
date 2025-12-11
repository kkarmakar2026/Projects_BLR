// src/main/java/com/quizportal/controller/AdminProfileServlet.java
package com.quizportal.controller;

import com.quizportal.dao.AdminDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet("/admin/profile")
public class AdminProfileServlet extends HttpServlet {
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("ADMIN_ID") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }
        req.getRequestDispatcher("/admin/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer adminId = (Integer) req.getSession().getAttribute("ADMIN_ID");
        if (adminId == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        adminDAO.updateProfile(adminId, name, email);
        req.setAttribute("msg", "Profile updated");
        req.getRequestDispatcher("/admin/profile.jsp").forward(req, resp);
    }
}
