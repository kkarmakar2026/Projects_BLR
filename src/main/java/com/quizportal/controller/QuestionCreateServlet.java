// src/main/java/com/quizportal/controller/QuestionCreateServlet.java
package com.quizportal.controller;

import com.quizportal.dao.QuestionDAO;
import com.quizportal.model.Question;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet("/admin/questions/create")
public class QuestionCreateServlet extends HttpServlet {
    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("ADMIN_ID") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }
        req.getRequestDispatcher("/admin/questionCreate.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer adminId = (Integer) req.getSession().getAttribute("ADMIN_ID");
        if (adminId == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }
        Question q = new Question();
        q.setText(req.getParameter("text"));
        q.setOptionA(req.getParameter("optionA"));
        q.setOptionB(req.getParameter("optionB"));
        q.setOptionC(req.getParameter("optionC"));
        q.setOptionD(req.getParameter("optionD"));
        q.setCorrectOption(req.getParameter("correctOption"));
        questionDAO.create(q, adminId);
        req.setAttribute("msg", "Question added");
        req.getRequestDispatcher("/admin/questionCreate.jsp").forward(req, resp);
    }
}
