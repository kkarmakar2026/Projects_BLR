// src/main/java/com/quizportal/model/User.java
package com.quizportal.model;

public class User {
    private int id;
    private String username;
    private String passwordHash;
    private String name;
    private String email;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPasswordHash() {
		return passwordHash;
	}
	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public User() {
		super();
		this.id = id;
		this.username = username;
		this.passwordHash = passwordHash;
		this.name = name;
		this.email = email;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", passwordHash=" + passwordHash + ", name=" + name
				+ ", email=" + email + "]";
	}

    
}
