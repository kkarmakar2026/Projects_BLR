// src/main/java/com/quizportal/controller/QuizAttemptServlet.java
package com.quizportal.controller;

import com.quizportal.dao.AttemptDAO;
import com.quizportal.dao.QuizDAO;
import com.quizportal.model.Question;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import java.util.List;

@WebServlet("/quiz/attempt")
public class QuizAttemptServlet extends HttpServlet {
    private final QuizDAO quizDAO = new QuizDAO();
    private final AttemptDAO attemptDAO = new AttemptDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("USER_ID");
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int quizId = Integer.parseInt(req.getParameter("id"));
        int attemptId = attemptDAO.startAttempt(quizId, userId);
        req.getSession().setAttribute("ATTEMPT_ID", attemptId);

        List<Question> questions = quizDAO.getQuizQuestions(quizId);
        req.setAttribute("questions", questions);
        req.setAttribute("quizId", quizId);
        req.getRequestDispatcher("/quizAttempt.jsp").forward(req, resp);
    }
}
