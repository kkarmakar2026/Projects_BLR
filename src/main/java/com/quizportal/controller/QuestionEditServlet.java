package com.quizportal.controller;

import com.quizportal.dao.QuestionDAO;
import com.quizportal.model.Question;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/question/edit")
public class QuestionEditServlet extends HttpServlet {
    private final QuestionDAO questionDAO = new QuestionDAO();

    // Show the Edit Form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("ADMIN_ID") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        int questionId = Integer.parseInt(req.getParameter("id"));
        Question q = questionDAO.findById(questionId);
        
        req.setAttribute("question", q);
        req.setAttribute("quizId", req.getParameter("quizId")); // Pass quizId to return later
        req.getRequestDispatcher("/admin/questionEdit.jsp").forward(req, resp);
    }

    // Process the Update
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("ADMIN_ID") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        int quizId = Integer.parseInt(req.getParameter("quizId"));

        Question q = new Question();
        q.setId(id);
        q.setText(req.getParameter("text"));
        q.setOptionA(req.getParameter("optionA"));
        q.setOptionB(req.getParameter("optionB"));
        q.setOptionC(req.getParameter("optionC"));
        q.setOptionD(req.getParameter("optionD"));
        q.setCorrectOption(req.getParameter("correctOption"));

        boolean success = questionDAO.updateQuestion(q);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/admin/quiz/details?quizId=" + quizId + "&msg=Question+Updated");
        } else {
            req.setAttribute("error", "Failed to update question.");
            req.setAttribute("question", q);
            req.setAttribute("quizId", quizId);
            req.getRequestDispatcher("/admin/questionEdit.jsp").forward(req, resp);
        }
    }
}