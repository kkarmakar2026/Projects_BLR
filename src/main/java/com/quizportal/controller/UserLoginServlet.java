// src/main/java/com/quizportal/controller/UserLoginServlet.java
package com.quizportal.controller;

import com.quizportal.dao.UserDAO;
import com.quizportal.model.User;
import com.quizportal.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        User user = userDAO.findByUsername(username);
        if (user != null && PasswordUtil.matches(password, user.getPasswordHash())) {
            HttpSession session = req.getSession();
            session.setAttribute("USER_ID", user.getId());
            session.setAttribute("USERNAME", user.getUsername());
            resp.sendRedirect(req.getContextPath() + "/quizzes");
        } else {
            req.setAttribute("error", "Invalid credentials");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
