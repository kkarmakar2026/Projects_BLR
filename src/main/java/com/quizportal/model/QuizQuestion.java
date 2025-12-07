// src/main/java/com/quizportal/model/QuizQuestion.java
package com.quizportal.model;

public class QuizQuestion {
    private int quizId;
    private int questionId;
    private int position;
	public int getQuizId() {
		return quizId;
	}
	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public int getPosition() {
		return position;
	}
	public void setPosition(int position) {
		this.position = position;
	}
	public QuizQuestion(int quizId, int questionId, int position) {
		super();
		this.quizId = quizId;
		this.questionId = questionId;
		this.position = position;
	}
	@Override
	public String toString() {
		return "QuizQuestion [quizId=" + quizId + ", questionId=" + questionId + ", position=" + position + "]";
	}

    
}
