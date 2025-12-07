
//src/main/java/com/quizportal/controller/QuizCreateServlet.java
package com.quizportal.controller;

import com.quizportal.dao.QuestionDAO;
import com.quizportal.dao.QuizDAO;
import com.quizportal.model.Question;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import java.util.List;

@WebServlet("/admin/quizzes/create")
public class QuizCreateServlet extends HttpServlet {
 private final QuizDAO quizDAO = new QuizDAO();
 private final QuestionDAO questionDAO = new QuestionDAO();

 @Override
 protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     Integer adminId = (Integer) req.getSession().getAttribute("ADMIN_ID");
     if (adminId == null) {
         resp.sendRedirect(req.getContextPath() + "/admin/login");
         return;
     }
     List<Question> questions = questionDAO.listAll();
     req.setAttribute("questions", questions);
     req.getRequestDispatcher("/admin/quizCreate.jsp").forward(req, resp);
 }

 @Override
 protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
     Integer adminId = (Integer) req.getSession().getAttribute("ADMIN_ID");
     if (adminId == null) {
         resp.sendRedirect(req.getContextPath() + "/admin/login");
         return;
     }
     String quizName = req.getParameter("quizName");
     String[] questionIds = req.getParameterValues("questionId");
     int quizId = quizDAO.createQuiz(quizName, adminId);
     if (questionIds != null) {
         int pos = 1;
         for (String qid : questionIds) {
             quizDAO.addQuestionToQuiz(quizId, Integer.parseInt(qid), pos++);
         }
     }
     req.setAttribute("quizId", quizId);
     req.getRequestDispatcher("/admin/quizPublish.jsp").forward(req, resp);
 }
}
