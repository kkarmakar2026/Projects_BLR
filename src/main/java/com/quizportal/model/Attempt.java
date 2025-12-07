// src/main/java/com/quizportal/model/Attempt.java
package com.quizportal.model;

import java.time.LocalDateTime;

public class Attempt {
    private int id;
    private int quizId;
    private int userId;
    private int score;
    private LocalDateTime startedAt;
    private LocalDateTime completedAt;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getQuizId() {
		return quizId;
	}
	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public LocalDateTime getStartedAt() {
		return startedAt;
	}
	public void setStartedAt(LocalDateTime startedAt) {
		this.startedAt = startedAt;
	}
	public LocalDateTime getCompletedAt() {
		return completedAt;
	}
	public void setCompletedAt(LocalDateTime completedAt) {
		this.completedAt = completedAt;
	}
	public Attempt() {
		super();
		this.id = id;
		this.quizId = quizId;
		this.userId = userId;
		this.score = score;
		this.startedAt = startedAt;
		this.completedAt = completedAt;
	}
	@Override
	public String toString() {
		return "Attempt [id=" + id + ", quizId=" + quizId + ", userId=" + userId + ", score=" + score + ", startedAt="
				+ startedAt + ", completedAt=" + completedAt + "]";
	}

  
}
