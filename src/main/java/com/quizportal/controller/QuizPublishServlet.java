// src/main/java/com/quizportal/controller/QuizPublishServlet.java
package com.quizportal.controller;

import com.quizportal.dao.QuizDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet("/admin/quizzes/publish")
public class QuizPublishServlet extends HttpServlet {
    private final QuizDAO quizDAO = new QuizDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer adminId = (Integer) req.getSession().getAttribute("ADMIN_ID");
        if (adminId == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }
        int quizId = Integer.parseInt(req.getParameter("quizId"));
        quizDAO.publishQuiz(quizId);
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}
