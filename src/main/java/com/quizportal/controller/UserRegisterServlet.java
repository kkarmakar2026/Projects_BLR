// src/main/java/com/quizportal/controller/UserRegisterServlet.java
package com.quizportal.controller;

import com.quizportal.dao.UserDAO;
import com.quizportal.model.User;
import com.quizportal.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet("/register")
public class UserRegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        String email = req.getParameter("email");

        User existing = userDAO.findByUsername(username);
        if (existing != null) {
            req.setAttribute("error", "Username already exists");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        User u = new User();
        u.setUsername(username);
        u.setPasswordHash(PasswordUtil.hash(password));
        u.setName(name);
        u.setEmail(email);
        int id = userDAO.create(u);

        HttpSession session = req.getSession();
        session.setAttribute("USER_ID", id);
        session.setAttribute("USERNAME", username);

        resp.sendRedirect(req.getContextPath() + "/quizzes");
    }
}
