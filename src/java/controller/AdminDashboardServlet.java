package controller;

import util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin_dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }
        
        try (Connection con = DBConnection.getConnection()) {
            
            // Get today's sales
            String todaySalesSql = "SELECT COALESCE(SUM(total_amount), 0) as total FROM sales WHERE DATE(sale_date) = CURDATE()";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(todaySalesSql);
            double todaySales = 0;
            if (rs.next()) {
                todaySales = rs.getDouble("total");
            }
            
            // Get total products
            String productsSql = "SELECT COUNT(*) as total FROM products";
            rs = stmt.executeQuery(productsSql);
            int totalProducts = 0;
            if (rs.next()) {
                totalProducts = rs.getInt("total");
            }
            
            // Get active users
            String usersSql = "SELECT COUNT(*) as total FROM users";
            rs = stmt.executeQuery(usersSql);
            int activeUsers = 0;
            if (rs.next()) {
                activeUsers = rs.getInt("total");
            }
            
            // Get monthly revenue
            String monthRevenueSql = "SELECT COALESCE(SUM(total_amount), 0) as total FROM sales WHERE MONTH(sale_date) = MONTH(CURDATE()) AND YEAR(sale_date) = YEAR(CURDATE())";
            rs = stmt.executeQuery(monthRevenueSql);
            double monthRevenue = 0;
            if (rs.next()) {
                monthRevenue = rs.getDouble("total");
            }
            
            // Get recent activities (mock data for now - you can enhance this)
            List<Map<String, String>> recentActivities = new ArrayList<>();
            
            // Set attributes
            request.setAttribute("todaySales", String.format("%.2f", todaySales));
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("activeUsers", activeUsers);
            request.setAttribute("monthRevenue", String.format("%.2f", monthRevenue));
            request.setAttribute("recentActivities", recentActivities);
            
            // Forward to dashboard JSP
            request.getRequestDispatcher("/jsp/admin_dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/jsp/error.jsp");
        }
    }
}