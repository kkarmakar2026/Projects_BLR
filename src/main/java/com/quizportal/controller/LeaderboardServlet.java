// src/main/java/com/quizportal/controller/LeaderboardServlet.java
package com.quizportal.controller;

import com.quizportal.dao.AttemptDAO;
import com.quizportal.dao.UserDAO;
import com.quizportal.model.Attempt;
import com.quizportal.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import java.util.*;

@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {
    private final AttemptDAO attemptDAO = new AttemptDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int quizId = Integer.parseInt(req.getParameter("quizId"));
        List<Attempt> attempts = attemptDAO.leaderboardForQuiz(quizId);

        // Map userId -> username
        Map<Integer, String> usernames = new HashMap<>();
        for (Attempt a : attempts) {
            int userId = a.getUserId();
            usernames.putIfAbsent(userId, Optional.ofNullable(userDAO.findById(userId))
                                                  .map(User::getUsername).orElse("user#" + userId));
        }

        req.setAttribute("attempts", attempts);
        req.setAttribute("usernames", usernames);
        req.getRequestDispatcher("/leaderboard.jsp").forward(req, resp);
    }
}
