package com.quizportal.controller;

import com.quizportal.dao.QuizDAO;
import com.quizportal.model.Quiz;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/quizzes/manage")
public class AdminQuizListServlet extends HttpServlet {
    private final QuizDAO quizDAO = new QuizDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("ADMIN_ID") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        // Handle Delete Action
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            quizDAO.deleteQuiz(id); // Deletes quiz and auto-deletes questions via DB Cascade
            resp.sendRedirect(req.getContextPath() + "/admin/quizzes/manage?msg=Quiz+Deleted");
            return;
        }

        List<Quiz> quizzes = quizDAO.getAllQuizzes();
        req.setAttribute("quizzes", quizzes);
        req.getRequestDispatcher("/admin/quizList.jsp").forward(req, resp);
    }
}