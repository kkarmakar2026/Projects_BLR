package com.quizportal.controller;

import com.quizportal.dao.QuizResultDAO;
import com.quizportal.model.QuizResult;
import com.quizportal.util.DBConnection; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/results")
public class ResultServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Check if user is logged in
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("USER_ID");

        if (userId == null) {
            response.sendRedirect("login"); 
            return;
        }

        try {
            // 2. Fetch results from DAO using YOUR DBConnection class
            // --- FIX HERE: Changed ConnectionProvider to DBConnection ---
            QuizResultDAO dao = new QuizResultDAO(DBConnection.getConnection());
            
            List<QuizResult> resultList = dao.getResultsByUserId(userId);

            // 3. Set data in request scope
            request.setAttribute("myResults", resultList);

            // 4. Forward to JSP
            request.getRequestDispatcher("my_results.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
        }
    }
}