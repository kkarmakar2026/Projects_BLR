package com.quizportal.dao;

import com.quizportal.model.QuizResult;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizResultDAO {
    private Connection con;

    public QuizResultDAO(Connection con) {
        this.con = con;
    }

    public List<QuizResult> getResultsByUserId(int userId) {
        List<QuizResult> list = new ArrayList<>();
        
        // --- FIX: Query the 'attempts' table instead of 'results' ---
        // We join 'attempts' with 'quizzes' to get the quiz name.
        String query = "SELECT q.name as quiz_name, a.score, a.total_marks, a.completed_at " +
                       "FROM attempts a " +
                       "JOIN quizzes q ON a.quiz_id = q.id " +
                       "WHERE a.user_id = ? " +
                       "ORDER BY a.completed_at DESC";

        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String name = rs.getString("quiz_name");
                double score = rs.getDouble("score");
                double total = rs.getDouble("total_marks");
                
                // Use completed_at as the timestamp
                Timestamp time = rs.getTimestamp("completed_at");
                
                // If completed_at is null (e.g. crash), fallback to current time
                if (time == null) {
                    time = new Timestamp(System.currentTimeMillis());
                }

                list.add(new QuizResult(name, score, total, time));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}