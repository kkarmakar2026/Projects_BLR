package com.quizportal.controller;

import com.quizportal.dao.QuestionDAO;
import com.quizportal.dao.QuizDAO;
import com.quizportal.model.Question;
import com.quizportal.model.Quiz;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/quiz/builder")
public class QuizBuilderServlet extends HttpServlet {
    
    private final QuizDAO quizDAO = new QuizDAO();
    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Check Admin Session
        Integer adminId = (Integer) req.getSession().getAttribute("ADMIN_ID");
        if (adminId == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        // 2. Check if we are editing an existing draft (quizId in URL)
        String quizIdParam = req.getParameter("quizId");
        
        if (quizIdParam != null) {
            int quizId = Integer.parseInt(quizIdParam);
            Quiz quiz = quizDAO.findById(quizId);
            List<Question> questions = quizDAO.getQuizQuestions(quizId);
            
            req.setAttribute("quiz", quiz);
            req.setAttribute("questions", questions);
        }

        // 3. Load the JSP
        req.getRequestDispatcher("/admin/quizBuilder.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer adminId = (Integer) req.getSession().getAttribute("ADMIN_ID");
        if (adminId == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        String action = req.getParameter("action");

        if ("createQuiz".equals(action)) {
            // STEP 1: Create the Quiz Shell
            String title = req.getParameter("quizTitle");
            
            // --- NEW CODE: Handle Time Limit ---
            String timeParam = req.getParameter("timeLimit");
            int timeLimit = 10; // Default
            if (timeParam != null && !timeParam.trim().isEmpty()) {
                try {
                    timeLimit = Integer.parseInt(timeParam);
                } catch (NumberFormatException e) {
                    timeLimit = 10; // Fallback if parsing fails
                }
            }

            // Call updated DAO method with timeLimit
            int quizId = quizDAO.createQuiz(title, adminId, timeLimit);
            
            // Redirect to same page with quizId to start adding questions
            resp.sendRedirect(req.getContextPath() + "/admin/quiz/builder?quizId=" + quizId);
        
        } else if ("addQuestion".equals(action)) {
            // STEP 2: Create Question & Link to Quiz
            int quizId = Integer.parseInt(req.getParameter("quizId"));
            
            // Create Question Object
            Question q = new Question();
            q.setText(req.getParameter("text"));
            q.setOptionA(req.getParameter("optionA"));
            q.setOptionB(req.getParameter("optionB"));
            q.setOptionC(req.getParameter("optionC"));
            q.setOptionD(req.getParameter("optionD"));
            q.setCorrectOption(req.getParameter("correctOption"));
            
            // Save Question to DB
            int questionId = questionDAO.create(q, adminId);
            
            // Calculate Position (Simple logic: count existing + 1)
            int position = quizDAO.getQuizQuestions(quizId).size() + 1;
            
            // Link to Quiz
            quizDAO.addQuestionToQuiz(quizId, questionId, position);
            
            // Redirect back to builder to show the new question
            resp.sendRedirect(req.getContextPath() + "/admin/quiz/builder?quizId=" + quizId + "&msg=Question+Added");
            
        } else if ("publish".equals(action)) {
            // STEP 3: Finalize
            int quizId = Integer.parseInt(req.getParameter("quizId"));
            quizDAO.publishQuiz(quizId);
            resp.sendRedirect(req.getContextPath() + "/admin/quizzes/manage?msg=Quiz+Published");
        }
    }
}