package com.quizportal.controller;

import com.quizportal.dao.QuestionDAO;
import com.quizportal.dao.QuizDAO;
import com.quizportal.model.Question;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/quizzes/create")
public class QuizCreateServlet extends HttpServlet {
    
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

        // 2. Search Logic (Search Question by ID)
        String searchIdParam = req.getParameter("searchId");
        List<Question> questions = new ArrayList<>();

        if (searchIdParam != null && !searchIdParam.trim().isEmpty()) {
            try {
                int searchId = Integer.parseInt(searchIdParam);
                Question q = questionDAO.findById(searchId);
                
                if (q != null) {
                    questions.add(q);
                    req.setAttribute("msg", "Found question with ID: " + searchId);
                } else {
                    req.setAttribute("error", "No question found with ID: " + searchId);
                    // On error, load all questions so the table isn't empty
                    questions = questionDAO.listAll(); 
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Invalid ID format. Please enter a number.");
                questions = questionDAO.listAll();
            }
        } else {
            // Default: Load all questions if no search is active
            questions = questionDAO.listAll();
        }

        req.setAttribute("questions", questions);
        req.getRequestDispatcher("/admin/quizCreate.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // 1. Check Admin Session
        Integer adminId = (Integer) req.getSession().getAttribute("ADMIN_ID");
        if (adminId == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }
        
        // 2. Retrieve Form Data
        String quizName = req.getParameter("quizName");
        String[] questionIds = req.getParameterValues("questionId");
        
        // --- FIX: Handle Time Limit ---
        String timeParam = req.getParameter("timeLimit");
        int timeLimit = 10; // Default to 10 minutes if not provided
        if (timeParam != null && !timeParam.trim().isEmpty()) {
            try {
                timeLimit = Integer.parseInt(timeParam);
            } catch (NumberFormatException e) {
                timeLimit = 10; // Fallback default
            }
        }

        // 3. Create Quiz (Now passing 3 arguments: name, adminId, timeLimit)
        int quizId = quizDAO.createQuiz(quizName, adminId, timeLimit);
        
        // 4. Map Selected Questions to Quiz
        if (questionIds != null) {
            int pos = 1;
            for (String qid : questionIds) {
                quizDAO.addQuestionToQuiz(quizId, Integer.parseInt(qid), pos++);
            }
        }
        
        // 5. Forward to Publish/Success page
        req.setAttribute("quizId", quizId);
        req.getRequestDispatcher("/admin/quizPublish.jsp").forward(req, resp);
    }
}