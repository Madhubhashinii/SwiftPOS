package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    private static final String URL = "jdbc:mysql://localhost:3306/swiftpos_db";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    
    public static Connection getConnection() throws SQLException {
        try {
            // Explicitly load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found!", e);
        }
    }
    
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("✓ Success! Connected to: "
                + conn.getMetaData().getDatabaseProductName());
        } catch (SQLException e) {
            System.err.println("✗ Connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
