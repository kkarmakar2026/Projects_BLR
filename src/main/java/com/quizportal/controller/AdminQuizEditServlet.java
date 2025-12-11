package com.quizportal.controller;

import com.quizportal.dao.QuizDAO;
import com.quizportal.model.Quiz;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

// This annotation maps the URL to this class
@WebServlet("/admin/quiz/edit")
public class AdminQuizEditServlet extends HttpServlet {
    
    private final QuizDAO quizDAO = new QuizDAO();

    // 1. GET: Show the Edit Form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Security Check
        if (req.getSession().getAttribute("ADMIN_ID") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        try {
            int quizId = Integer.parseInt(req.getParameter("quizId"));
            Quiz quiz = quizDAO.findById(quizId);
            
            if (quiz == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/quizzes/manage?error=Quiz+not+found");
                return;
            }
            
            req.setAttribute("quiz", quiz);
            req.getRequestDispatcher("/admin/quizEdit.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/quizzes/manage");
        }
    }

    // 2. POST: Process the Update
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Security Check
        if (req.getSession().getAttribute("ADMIN_ID") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        try {
            int quizId = Integer.parseInt(req.getParameter("quizId"));
            String name = req.getParameter("name");
            
            // Handle timeLimit parsing safely
            int timeLimit = 10;
            try {
                timeLimit = Integer.parseInt(req.getParameter("timeLimit"));
            } catch (NumberFormatException e) {
                timeLimit = 10; // Default if empty
            }

            Quiz quiz = new Quiz();
            quiz.setId(quizId);
            quiz.setName(name);
            quiz.setTimeLimit(timeLimit);

            // Call DAO to update
            boolean success = quizDAO.updateQuiz(quiz);

            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin/quizzes/manage?msg=Quiz+Settings+Updated");
            } else {
                req.setAttribute("error", "Failed to update quiz.");
                req.setAttribute("quiz", quiz);
                req.getRequestDispatcher("/admin/quizEdit.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/quizzes/manage?error=Error+updating");
        }
    }
}