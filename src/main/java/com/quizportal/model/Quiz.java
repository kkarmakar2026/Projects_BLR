// src/main/java/com/quizportal/model/Quiz.java
package com.quizportal.model;

import java.util.List;

public class Quiz {
    private int id;
    private String name;
    private boolean published;
    private List<QuizQuestion> questions;
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
	public List<QuizQuestion> getQuestions() {
		return questions;
	}
	public void setQuestions(List<QuizQuestion> questions) {
		this.questions = questions;
	}
	public Quiz() {
		super();
		this.id = id;
		this.name = name;
		this.published = published;
		this.questions = questions;
	}
	@Override
	public String toString() {
		return "Quiz [id=" + id + ", name=" + name + ", published=" + published + ", questions=" + questions + "]";
	}

    
}
