// src/main/java/com/quizportal/controller/QuizSubmitServlet.java
package com.quizportal.controller;

import com.quizportal.dao.AttemptDAO;
import com.quizportal.dao.QuestionDAO;
import com.quizportal.dao.QuizDAO;
import com.quizportal.model.Question;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import java.util.List;

@WebServlet("/quiz/submit")
public class QuizSubmitServlet extends HttpServlet {
    private final AttemptDAO attemptDAO = new AttemptDAO();
    private final QuizDAO quizDAO = new QuizDAO();
    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer attemptId = (Integer) req.getSession().getAttribute("ATTEMPT_ID");
        Integer userId = (Integer) req.getSession().getAttribute("USER_ID");
        if (attemptId == null || userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int quizId = Integer.parseInt(req.getParameter("quizId"));
        List<Question> questions = quizDAO.getQuizQuestions(quizId);

        for (Question q : questions) {
            String selected = req.getParameter("q_" + q.getId());
            boolean isCorrect = selected != null && selected.equalsIgnoreCase(q.getCorrectOption());
            attemptDAO.saveAnswer(attemptId, q.getId(), selected != null ? selected : "", isCorrect);
        }

        attemptDAO.completeAttempt(attemptId);
        req.getSession().removeAttribute("ATTEMPT_ID");

        req.setAttribute("attempt", attemptDAO.findById(attemptId));
        req.setAttribute("questions", questions);
        req.getRequestDispatcher("/quizResult.jsp").forward(req, resp);
    }
}
