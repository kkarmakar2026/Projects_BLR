package com.quizportal.model;

import java.sql.Timestamp;

public class QuizResult {
    private String quizName;
    private double score;
    private double totalMarks;
    private Timestamp attemptTime;

    public QuizResult(String quizName, double score, double totalMarks, Timestamp attemptTime) {
        this.quizName = quizName;
        this.score = score;
        this.totalMarks = totalMarks;
        this.attemptTime = attemptTime;
    }

    public String getQuizName() { return quizName; }
    public double getScore() { return score; }
    public double getTotalMarks() { return totalMarks; }
    public Timestamp getAttemptTime() { return attemptTime; }
    
    // Helper to calculate percentage for the UI
    public double getPercentage() {
        return (totalMarks > 0) ? (score / totalMarks) * 100 : 0;
    }
}