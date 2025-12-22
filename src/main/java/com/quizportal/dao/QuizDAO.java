package com.quizportal.dao;

import com.quizportal.model.Question;
import com.quizportal.model.Quiz;
import com.quizportal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizDAO {

    /**
     * NEW HELPER: Get question count for a specific quiz
     */
    public int getQuestionCount(int quizId) {
        String sql = "SELECT COUNT(*) FROM quiz_questions WHERE quiz_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quizId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int createQuiz(String name, int adminId, int timeLimit, String category) {
        String sql = "INSERT INTO quizzes (name, created_by, time_limit, category) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, name);
            ps.setInt(2, adminId);
            ps.setInt(3, timeLimit);
            ps.setString(4, category);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error creating quiz", e);
        }
        return -1;
    }

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
                    q.setTimeLimit(rs.getInt("time_limit"));
                    q.setCategory(rs.getString("category"));
                    // Dynamically set count
                    q.setQuestionCount(getQuestionCount(q.getId())); 
                    return q;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error finding quiz", e);
        }
        return null;
    }

    public List<Quiz> listPublished() {
        String sql = "SELECT * FROM quizzes WHERE is_published=1 ORDER BY id DESC";
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
                q.setCategory(rs.getString("category"));
                // Dynamically set count for each quiz in the list
                q.setQuestionCount(getQuestionCount(q.getId())); 
                list.add(q);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error listing published quizzes", e);
        }
        return list;
    }

    public List<Quiz> getAllQuizzes() {
        String sql = "SELECT * FROM quizzes ORDER BY id DESC";
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
                q.setCategory(rs.getString("category"));
                q.setQuestionCount(getQuestionCount(q.getId()));
                list.add(q);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error listing all quizzes", e);
        }
        return list;
    }

    // ... [Rest of your methods like addQuestionToQuiz, deleteQuiz, etc. remain the same] ...
    
    public void addQuestionToQuiz(int quizId, int questionId, int position) {
        String sql = "INSERT INTO quiz_questions (quiz_id, question_id, position) VALUES (?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quizId);
            ps.setInt(2, questionId);
            ps.setInt(3, position);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error linking question", e);
        }
    }

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
            throw new RuntimeException("Error fetching questions", e);
        }
        return list;
    }

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

    public int countQuizzes() {
        String sql = "SELECT COUNT(*) FROM quizzes";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw new RuntimeException("Error counting quizzes", e);
        }
        return 0;
    }

    public boolean updateQuiz(Quiz quiz) {
        String sql = "UPDATE quizzes SET name = ?, time_limit = ?, category = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, quiz.getName());
            ps.setInt(2, quiz.getTimeLimit());
            ps.setString(3, quiz.getCategory());
            ps.setInt(4, quiz.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}