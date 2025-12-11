// src/main/java/com/quizportal/controller/AdminDashboardServlet.java
package com.quizportal.controller;

import com.quizportal.dao.AdminDAO;
import com.quizportal.dao.QuestionDAO;
import com.quizportal.dao.QuizDAO;
import com.quizportal.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private final QuizDAO quizDAO = new QuizDAO();
    private final QuestionDAO questionDAO = new QuestionDAO();
    private final UserDAO userDAO = new UserDAO();
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer adminId = (Integer) req.getSession().getAttribute("ADMIN_ID");
        if (adminId == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        req.setAttribute("totalQuizzes", quizDAO.countQuizzes());
        req.setAttribute("totalQuestions", questionDAO.countQuestions());
        req.setAttribute("totalUsers", userDAO.countUsers());
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}
