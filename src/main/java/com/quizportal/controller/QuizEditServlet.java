package com.quizportal.controller;

import com.quizportal.dao.QuizDAO;
import com.quizportal.model.Quiz;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/quiz/edit")
public class QuizEditServlet extends HttpServlet {
    private final QuizDAO quizDAO = new QuizDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Auth Check
        if (req.getSession().getAttribute("ADMIN_ID") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        try {
            int quizId = Integer.parseInt(req.getParameter("quizId"));
            Quiz quiz = quizDAO.findById(quizId);
            
            if (quiz != null) {
                req.setAttribute("quiz", quiz);
                req.getRequestDispatcher("/admin/quizEdit.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/quizzes/manage?error=QuizNotFound");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin/quizzes/manage");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int quizId = Integer.parseInt(req.getParameter("quizId"));
        String name = req.getParameter("name");
        int timeLimit = Integer.parseInt(req.getParameter("timeLimit"));
        String category = req.getParameter("category");

        Quiz quiz = new Quiz();
        quiz.setId(quizId);
        quiz.setName(name);
        quiz.setTimeLimit(timeLimit);
        quiz.setCategory(category);

        boolean updated = quizDAO.updateQuiz(quiz);

        if (updated) {
            resp.sendRedirect(req.getContextPath() + "/admin/quizzes/manage?msg=Quiz+Updated+Successfully");
        } else {
            req.setAttribute("error", "Failed to update quiz settings");
            req.setAttribute("quiz", quiz);
            req.getRequestDispatcher("/admin/quizEdit.jsp").forward(req, resp);
        }
    }
}