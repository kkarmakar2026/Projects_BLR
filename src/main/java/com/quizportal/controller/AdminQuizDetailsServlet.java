package com.quizportal.controller;

import com.quizportal.dao.QuestionDAO;
import com.quizportal.dao.QuizDAO;
import com.quizportal.model.Question;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/quiz/details")
public class AdminQuizDetailsServlet extends HttpServlet {
    private final QuizDAO quizDAO = new QuizDAO();
    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("ADMIN_ID") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        String quizIdStr = req.getParameter("quizId");
        if (quizIdStr == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/quizzes/manage");
            return;
        }
        int quizId = Integer.parseInt(quizIdStr);

        // Handle Delete Question Action
        String action = req.getParameter("action");
        if ("deleteQuestion".equals(action)) {
            int qId = Integer.parseInt(req.getParameter("questionId"));
            questionDAO.deleteQuestion(qId); // Or remove from quiz_questions table mapping
            resp.sendRedirect(req.getContextPath() + "/admin/quiz/details?quizId=" + quizId + "&msg=Question+Removed");
            return;
        }

        List<Question> questions = quizDAO.getQuizQuestions(quizId);
        req.setAttribute("questions", questions);
        req.setAttribute("quizId", quizId);
        req.getRequestDispatcher("/admin/quizDetails.jsp").forward(req, resp);
    }
}