package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() throws SQLException {
        try {
            // Reads from Railway environment variables
            // Falls back to localhost (XAMPP) if not set
            String url = System.getenv("DB_URL") != null 
                ? System.getenv("DB_URL") 
                : "jdbc:mysql://localhost:3306/swiftpos_db";
            
            String user = System.getenv("DB_USER") != null 
                ? System.getenv("DB_USER") 
                : "root";
            
            String password = System.getenv("DB_PASS") != null 
                ? System.getenv("DB_PASS") 
                : "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);

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