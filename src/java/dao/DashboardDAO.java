package dao;

import util.DBConnection;
import model.Activity;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO {

    // 1. Get Today's Sales Sum
    public double getTodaySales() throws SQLException {
        String sql = "SELECT SUM(total_amount) FROM sales WHERE DATE(sale_date) = CURDATE()";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return (rs.next()) ? rs.getDouble(1) : 0.0;
        }
    }

    // 2. Get Total Product Count
    public int getTotalProducts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return (rs.next()) ? rs.getInt(1) : 0;
        }
    }

    // 3. Get Active User Count
    public int getActiveUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return (rs.next()) ? rs.getInt(1) : 0;
        }
    }

    // 4. Get Monthly Revenue
    public double getMonthlyRevenue() throws SQLException {
        String sql = "SELECT SUM(total_amount) FROM sales WHERE MONTH(sale_date) = MONTH(CURDATE()) AND YEAR(sale_date) = YEAR(CURDATE())";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            return (rs.next()) ? rs.getDouble(1) : 0.0;
        }
    }

    // 5. Get Recent Activity (Joins Sales and Users)
    public List<Activity> getRecentActivities() throws SQLException {
        List<Activity> activities = new ArrayList<>();
        // Note: Joining sales.user_id with users.id as per your schema
        String sql = "SELECT s.total_amount, s.sale_date, u.username " +
                     "FROM sales s " +
                     "JOIN users u ON s.user_id = u.id " +
                     "ORDER BY s.sale_date DESC LIMIT 5";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                String desc = "Sale completed: LKR " + String.format("%.2f", rs.getDouble("total_amount"));
                activities.add(new Activity(
                    desc,
                    rs.getTimestamp("sale_date").toString(),
                    rs.getString("username"),
                    "sale",
                    "fa-shopping-cart"
                ));
            }
        }
        return activities;
    }
}