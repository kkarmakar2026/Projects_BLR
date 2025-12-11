// src/main/java/com/quizportal/dao/QuestionDAO.java
package com.quizportal.dao;

import com.quizportal.model.Question;
import com.quizportal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO {

    // 1. Create a new question
    public int create(Question q, int adminId) {
        String sql = "INSERT INTO questions (text, option_a, option_b, option_c, option_d, correct_option, created_by) VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, q.getText());
            ps.setString(2, q.getOptionA());
            ps.setString(3, q.getOptionB());
            ps.setString(4, q.getOptionC());
            ps.setString(5, q.getOptionD());
            ps.setString(6, q.getCorrectOption());
            ps.setInt(7, adminId);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error creating question", e);
        }
        return -1;
    }

    // 2. Find a question by ID (Fixed: Only one version now)
    public Question findById(int id) {
        String sql = "SELECT * FROM questions WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Question q = new Question();
                    q.setId(rs.getInt("id"));
                    q.setText(rs.getString("text"));
                    q.setOptionA(rs.getString("option_a"));
                    q.setOptionB(rs.getString("option_b"));
                    q.setOptionC(rs.getString("option_c"));
                    q.setOptionD(rs.getString("option_d"));
                    q.setCorrectOption(rs.getString("correct_option"));
                    return q;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error finding question by ID", e);
        }
        return null;
    }

    // 3. List all questions
    public List<Question> listAll() {
        String sql = "SELECT * FROM questions ORDER BY id DESC";
        List<Question> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id"));
                q.setText(rs.getString("text"));
                q.setOptionA(rs.getString("option_a"));
                q.setOptionB(rs.getString("option_b"));
                q.setOptionC(rs.getString("option_c"));
                q.setOptionD(rs.getString("option_d"));
                q.setCorrectOption(rs.getString("correct_option"));
                list.add(q);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error listing questions", e);
        }
        return list;
    }

    // 4. Update an existing question (Added for Admin Features)
    public boolean updateQuestion(Question q) {
        String sql = "UPDATE questions SET text=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_option=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, q.getText());
            ps.setString(2, q.getOptionA());
            ps.setString(3, q.getOptionB());
            ps.setString(4, q.getOptionC());
            ps.setString(5, q.getOptionD());
            ps.setString(6, q.getCorrectOption());
            ps.setInt(7, q.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Delete a question (Added for Admin Features)
    public boolean deleteQuestion(int id) {
        String sql = "DELETE FROM questions WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 6. Count total questions
    public int countQuestions() {
        String sql = "SELECT COUNT(*) c FROM questions";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt("c");
        } catch (SQLException e) {
            throw new RuntimeException("Error counting questions", e);
        }
        return 0;
    }
}