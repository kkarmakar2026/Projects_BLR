package com.quizportal.dao;

import com.quizportal.model.Question;
import com.quizportal.util.DBConnection; // Ensure you import your DBConnection

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO {
    
    private Connection con;

    // 1. Default Constructor (Required for Admin features that open their own connection)
    public QuestionDAO() {
    }

    // 2. Constructor with Connection (Required for Quiz Submission Servlet)
    public QuestionDAO(Connection con) {
        this.con = con;
    }

    // --- HELPER: Get a valid connection ---
    // If 'this.con' exists, use it. Otherwise, get a new one from DBConnection.
    private Connection getConnection() throws SQLException {
        if (this.con != null && !this.con.isClosed()) {
            return this.con;
        }
        return DBConnection.getConnection();
    }

    // --- 3. FETCH QUESTIONS FOR A QUIZ (Used in Quiz Attempt) ---
    public List<Question> getQuestionsByQuizId(int quizId) {
        List<Question> list = new ArrayList<>();
        String query = "SELECT q.* FROM questions q " +
                       "JOIN quiz_questions qq ON q.id = qq.question_id " +
                       "WHERE qq.quiz_id = ?";

        // We use the helper to ensure we have a connection
        try {
            Connection currentCon = getConnection();
            PreparedStatement ps = currentCon.prepareStatement(query);
            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question q = mapResultSetToQuestion(rs);
                list.add(q);
            }
            // Note: If we opened a new connection locally, we ideally should close it,
            // but if it was passed via constructor, we shouldn't. 
            // For safety in this hybrid approach, we usually rely on the caller to manage connection
            // or use try-with-resources if using the Default Constructor.
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // --- 4. CREATE QUESTION (Used in Admin Panel) ---
    public int create(Question q, Integer adminId) {
        String sql = "INSERT INTO questions (text, option_a, option_b, option_c, option_d, correct_option, created_by) VALUES (?,?,?,?,?,?,?)";
        
        // Using try-with-resources to safely handle new connections for Admin tasks
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, q.getText());
            ps.setString(2, q.getOptionA());
            ps.setString(3, q.getOptionB());
            ps.setString(4, q.getOptionC());
            ps.setString(5, q.getOptionD());
            ps.setString(6, q.getCorrectOption());
            
            if (adminId != null) ps.setInt(7, adminId);
            else ps.setNull(7, Types.INTEGER);

            ps.executeUpdate();
            
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // --- 5. FIND BY ID (Used for Editing) ---
    public Question findById(int id) {
        String sql = "SELECT * FROM questions WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToQuestion(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // --- 6. LIST ALL QUESTIONS (Used in Admin Dashboard) ---
    public List<Question> listAll() {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT * FROM questions ORDER BY id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(mapResultSetToQuestion(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // --- 7. UPDATE QUESTION ---
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

    // --- 8. DELETE QUESTION ---
    public void deleteQuestion(int qId) {
        String sql = "DELETE FROM questions WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, qId);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // --- 9. COUNT QUESTIONS ---
    // Changed return type from Object to int
    public int countQuestions() {
        String sql = "SELECT COUNT(*) FROM questions";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) return rs.getInt(1);
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // --- HELPER: Map SQL Row to Java Object ---
    private Question mapResultSetToQuestion(ResultSet rs) throws SQLException {
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