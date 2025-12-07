// src/main/java/com/quizportal/controller/QuizListServlet.java
package com.quizportal.controller;

import com.quizportal.dao.QuizDAO;
import com.quizportal.model.Quiz;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import java.util.List;

@WebServlet("/quizzes")
public class QuizListServlet extends HttpServlet {
    private final QuizDAO quizDAO = new QuizDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Quiz> quizzes = quizDAO.listPublished();
        req.setAttribute("quizzes", quizzes);
        req.getRequestDispatcher("/quizList.jsp").forward(req, resp);
    }
}
