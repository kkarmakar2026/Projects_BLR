package com.quizportal.dao;

import com.quizportal.model.Question;
import com.quizportal.model.Quiz;
import com.quizportal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizDAO {

    // 1. Create a new Quiz with Time Limit
    public int createQuiz(String name, int adminId, int timeLimit) {
        String sql = "INSERT INTO quizzes (name, created_by, time_limit) VALUES (?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, name);
            ps.setInt(2, adminId);
            ps.setInt(3, timeLimit); // Save time limit
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error creating quiz", e);
        }
        return -1;
    }

    // 2. Link a Question to a Quiz
    public void addQuestionToQuiz(int quizId, int questionId, int position) {
        String sql = "INSERT INTO quiz_questions (quiz_id, question_id, position) VALUES (?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quizId);
            ps.setInt(2, questionId);
            ps.setInt(3, position);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding question to quiz", e);
        }
    }

    // 3. Publish a Quiz
    public void publishQuiz(int quizId) {
        String sql = "UPDATE quizzes SET is_published=1 WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quizId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error publishing quiz", e);
        }
    }

    // 4. Find Quiz by ID (Fetch time limit)
    public Quiz findById(int id) {
        String sql = "SELECT * FROM quizzes WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Quiz q = new Quiz();
                    q.setId(rs.getInt("id"));
                    q.setName(rs.getString("name"));
                    q.setPublished(rs.getInt("is_published") == 1);
                    q.setTimeLimit(rs.getInt("time_limit")); // Fetch time limit
                    return q;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error finding quiz", e);
        }
        return null;
    }

    // 5. List ONLY Published Quizzes (For Students)
    public List<Quiz> listPublished() {
        String sql = "SELECT * FROM quizzes WHERE is_published=1 ORDER BY created_at DESC";
        List<Quiz> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Quiz q = new Quiz();
                q.setId(rs.getInt("id"));
                q.setName(rs.getString("name"));
                q.setPublished(true);
                q.setTimeLimit(rs.getInt("time_limit"));
                list.add(q);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error listing published quizzes", e);
        }
        return list;
    }

    // 6. List ALL Quizzes (For Admin Dashboard)
    public List<Quiz> getAllQuizzes() {
        String sql = "SELECT * FROM quizzes ORDER BY created_at DESC";
        List<Quiz> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Quiz q = new Quiz();
                q.setId(rs.getInt("id"));
                q.setName(rs.getString("name"));
                q.setPublished(rs.getInt("is_published") == 1);
                q.setTimeLimit(rs.getInt("time_limit"));
                list.add(q);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error listing all quizzes", e);
        }
        return list;
    }

    // 7. Delete a Quiz
    public boolean deleteQuiz(int quizId) {
        String sql = "DELETE FROM quizzes WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quizId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 8. Get Questions for a specific Quiz
    public List<Question> getQuizQuestions(int quizId) {
        String sql = "SELECT q.* FROM questions q JOIN quiz_questions qq ON q.id=qq.question_id WHERE qq.quiz_id=? ORDER BY qq.position ASC";
        List<Question> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quizId);
            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getting quiz questions", e);
        }
        return list;
    }

 // Add inside QuizDAO class
    public boolean updateQuiz(Quiz quiz) {
        String sql = "UPDATE quizzes SET name=?, time_limit=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, quiz.getName());
            ps.setInt(2, quiz.getTimeLimit());
            ps.setInt(3, quiz.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // 9. Count total quizzes
    public int countQuizzes() {
        String sql = "SELECT COUNT(*) c FROM quizzes";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt("c");
        } catch (SQLException e) {
            throw new RuntimeException("Error counting quizzes", e);
        }
        return 0;
    }
}