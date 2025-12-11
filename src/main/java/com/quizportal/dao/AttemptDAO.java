// src/main/java/com/quizportal/dao/AttemptDAO.java
package com.quizportal.dao;

import com.quizportal.model.Attempt;
import com.quizportal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttemptDAO {
    public int startAttempt(int quizId, int userId) {
        String sql = "INSERT INTO attempts (quiz_id, user_id, score) VALUES (?,?,0)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, quizId);
            ps.setInt(2, userId);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return -1;
    }

    public void saveAnswer(int attemptId, int questionId, String selectedOption, boolean isCorrect) {
        String sql = "INSERT INTO attempt_answers (attempt_id, question_id, selected_option, is_correct) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, attemptId);
            ps.setInt(2, questionId);
            ps.setString(3, selectedOption);
            ps.setBoolean(4, isCorrect);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void completeAttempt(int attemptId) {
        String sql = "UPDATE attempts SET completed_at=NOW(), score=(SELECT COUNT(*) FROM attempt_answers WHERE attempt_id=? AND is_correct=1) WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, attemptId);
            ps.setInt(2, attemptId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Attempt findById(int id) {
        String sql = "SELECT * FROM attempts WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Attempt a = new Attempt();
                    a.setId(rs.getInt("id"));
                    a.setQuizId(rs.getInt("quiz_id"));
                    a.setUserId(rs.getInt("user_id"));
                    a.setScore(rs.getInt("score"));
                    return a;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public List<Attempt> leaderboardForQuiz(int quizId) {
        String sql = "SELECT * FROM attempts WHERE quiz_id=? AND completed_at IS NOT NULL ORDER BY score DESC, completed_at ASC";
        List<Attempt> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quizId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Attempt a = new Attempt();
                    a.setId(rs.getInt("id"));
                    a.setQuizId(rs.getInt("quiz_id"));
                    a.setUserId(rs.getInt("user_id"));
                    a.setScore(rs.getInt("score"));
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }
}
