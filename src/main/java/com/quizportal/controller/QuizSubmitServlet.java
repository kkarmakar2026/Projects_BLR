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
 // private final QuestionDAO questionDAO = new QuestionDAO(); // Unused, can remove

 @Override
 protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
     // ... (Session checks remain the same) ...
     Integer attemptId = (Integer) req.getSession().getAttribute("ATTEMPT_ID");
     Integer userId = (Integer) req.getSession().getAttribute("USER_ID");

     if (attemptId == null || userId == null) {
         resp.sendRedirect(req.getContextPath() + "/login");
         return;
     }

     int quizId = Integer.parseInt(req.getParameter("quizId"));
     List<Question> questions = quizDAO.getQuizQuestions(quizId);

     for (Question q : questions) {
         // FIX: Changed "q_" to "question_" to match the JSP name attribute
         String selected = req.getParameter("question_" + q.getId());
         
         boolean isCorrect = selected != null && selected.equalsIgnoreCase(q.getCorrectOption());
         
         // Check if selected is null (user skipped question)
         // Ideally, your DB should allow NULLs, or you enforce 'required' in JSP
         String answerToSave = (selected != null) ? selected : null; 
         
         // Note: Ensure your saveAnswer method handles nulls gracefully
         // If your DB column is NOT NULL, you must ensure the user selects an option
         if(answerToSave != null) {
             attemptDAO.saveAnswer(attemptId, q.getId(), answerToSave, isCorrect);
         }
     }

     attemptDAO.completeAttempt(attemptId);
     req.getSession().removeAttribute("ATTEMPT_ID");

     req.setAttribute("attempt", attemptDAO.findById(attemptId));
     req.setAttribute("questions", questions);
     req.getRequestDispatcher("/quizResult.jsp").forward(req, resp);
 }
}