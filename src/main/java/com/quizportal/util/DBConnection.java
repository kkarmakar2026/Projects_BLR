// src/main/java/com/quizportal/util/DBConnection.java
package com.quizportal.util;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;

public class DBConnection {
    private static DataSource dataSource;

    static {
        try {
            InitialContext ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/QuizDB");
        } catch (NamingException e) {
            throw new RuntimeException("Failed to initialize datasource", e);
        }
    }

    public static Connection getConnection() {
        try {
            return dataSource.getConnection();
        } catch (Exception e) {
            throw new RuntimeException("Unable to get DB connection", e);
        }
    }
}
