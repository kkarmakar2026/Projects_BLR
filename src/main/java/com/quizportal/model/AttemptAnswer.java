// src/main/java/com/quizportal/model/AttemptAnswer.java
package com.quizportal.model;

public class AttemptAnswer {
    private int id;
    private int attemptId;
    private int questionId;
    private String selectedOption;
    private boolean correct;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAttemptId() {
		return attemptId;
	}
	public void setAttemptId(int attemptId) {
		this.attemptId = attemptId;
	}
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public String getSelectedOption() {
		return selectedOption;
	}
	public void setSelectedOption(String selectedOption) {
		this.selectedOption = selectedOption;
	}
	public boolean isCorrect() {
		return correct;
	}
	public void setCorrect(boolean correct) {
		this.correct = correct;
	}
	public AttemptAnswer(int id, int attemptId, int questionId, String selectedOption, boolean correct) {
		super();
		this.id = id;
		this.attemptId = attemptId;
		this.questionId = questionId;
		this.selectedOption = selectedOption;
		this.correct = correct;
	}
	@Override
	public String toString() {
		return "AttemptAnswer [id=" + id + ", attemptId=" + attemptId + ", questionId=" + questionId
				+ ", selectedOption=" + selectedOption + ", correct=" + correct + "]";
	}

   
}
