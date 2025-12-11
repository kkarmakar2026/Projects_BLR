package com.quizportal.model;

import java.util.List;

public class Quiz {
    private int id;
    private String name;
    private boolean published;
    private int timeLimit; // Added this field for the timer functionality
    private List<QuizQuestion> questions;

    // Default Constructor
    public Quiz() {
        super();
        this.timeLimit = 10; // Default to 10 minutes if not set
    }

    // Parameterized Constructor (Optional, helpful for testing)
    public Quiz(int id, String name, boolean published, int timeLimit) {
        this.id = id;
        this.name = name;
        this.published = published;
        this.timeLimit = timeLimit;
    }

    // --- Getters and Setters ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isPublished() {
        return published;
    }

    public void setPublished(boolean published) {
        this.published = published;
    }

    public int getTimeLimit() {
        return timeLimit;
    }

    public void setTimeLimit(int timeLimit) {
        this.timeLimit = timeLimit;
    }

    public List<QuizQuestion> getQuestions() {
        return questions;
    }

    public void setQuestions(List<QuizQuestion> questions) {
        this.questions = questions;
    }

    // --- toString Method ---

    @Override
    public String toString() {
        return "Quiz [id=" + id + ", name=" + name + ", published=" + published + ", timeLimit=" + timeLimit + ", questions=" + questions + "]";
    }
}