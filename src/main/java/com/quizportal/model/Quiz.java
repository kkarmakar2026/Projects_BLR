package com.quizportal.model;

import java.util.List;

public class Quiz {
    private int id;
    private String name;
    private boolean published;
    private int timeLimit; 
    private String category; // NEW FIELD: Added for category support
    private List<QuizQuestion> questions;

    // Default Constructor
    public Quiz() {
        super();
        this.timeLimit = 10; 
    }

    // Updated Parameterized Constructor
    public Quiz(int id, String name, boolean published, int timeLimit, String category) {
        this.id = id;
        this.name = name;
        this.published = published;
        this.timeLimit = timeLimit;
        this.category = category; // Set the category
    }

    // --- Getters and Setters ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public boolean isPublished() { return published; }
    public void setPublished(boolean published) { this.published = published; }

    public int getTimeLimit() { return timeLimit; }
    public void setTimeLimit(int timeLimit) { this.timeLimit = timeLimit; }
    
    private int questionCount;
    public int getQuestionCount() { return questionCount; }
    public void setQuestionCount(int questionCount) { this.questionCount = questionCount; }
    
    // NEW GETTER: This fixes the JasperException
    public String getCategory() {
        return category;
    }

    // NEW SETTER
    public void setCategory(String category) {
        this.category = category;
    }

    public List<QuizQuestion> getQuestions() { return questions; }
    public void setQuestions(List<QuizQuestion> questions) { this.questions = questions; }

    // Updated toString Method
    @Override
    public String toString() {
        return "Quiz [id=" + id + ", name=" + name + ", published=" + published + 
               ", timeLimit=" + timeLimit + ", category=" + category + ", questions=" + questions + "]";
    }
}