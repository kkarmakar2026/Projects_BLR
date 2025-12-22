package com.quizportal.controller;

import com.quizportal.dao.QuestionDAO;
import com.quizportal.model.Question;
import com.quizportal.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

@WebServlet("/quiz/submit")
public class QuizSubmitServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Session & User Check
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("USER_ID");
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Retrieve Quiz ID from the hidden form field
        String quizIdParam = request.getParameter("quizId");
        if (quizIdParam == null || quizIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quizzes");
            return;
        }
        int quizId = Integer.parseInt(quizIdParam);

        // 3. Logic: Calculate Score
        // We re-fetch the questions to compare user answers against the correct options in DB
        QuestionDAO qDao = new QuestionDAO(DBConnection.getConnection());
        List<Question> questions = qDao.getQuestionsByQuizId(quizId);
        
        double score = 0;
        double totalMarks = questions.size(); // Assuming 1 mark per question
        
        for (Question q : questions) {
            // MATCHING THE JSP: The input name is "question_" + id
            String paramName = "question_" + q.getId();
            String selectedOption = request.getParameter(paramName);
            
            // Check correctness
            if (selectedOption != null && selectedOption.equalsIgnoreCase(q.getCorrectOption())) {
                score++;
            }
        }
        
        // 4. Logic: Save Attempt to Database
        try (Connection con = DBConnection.getConnection()) {
            // We use the 'attempts' table we created earlier
            String sql = "INSERT INTO attempts (quiz_id, user_id, score, total_marks, completed_at) VALUES (?, ?, ?, ?, NOW())";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, quizId);
            ps.setInt(2, userId);
            ps.setDouble(3, score);
            ps.setDouble(4, totalMarks);
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
            // Optional: Handle database error
        }
        
        // 5. REDIRECT TO LEADERBOARD
        // This is the specific fix you requested.
        response.sendRedirect(request.getContextPath() + "/leaderboard?quizId=" + quizId);
    }
}