package controller;

import model.Sale;
import util.DBConnection;
// Import your DAO if it's in a different package
// import dao.ReportDAO; 

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ReportServlet") // Ensure this matches your <form action="...">
public class ReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ... (Keep your existing doGet code here to fetch and display data)
        List<Sale> salesList = new ArrayList<>();
        double totalRevenue = 0;
        int totalSalesCount = 0;

        try (Connection con = DBConnection.getConnection()) {
            // 1. Get Summary Stats
            String summarySql = "SELECT COUNT(*) AS totalCount, SUM(total_amount) AS revenue FROM sales";
            try (Statement st = con.createStatement(); 
                 ResultSet rs = st.executeQuery(summarySql)) {
                if (rs.next()) {
                    totalSalesCount = rs.getInt("totalCount");
                    totalRevenue = rs.getDouble("revenue");
                }
            }

            // 2. Get Detailed Sales
            String tableSql = "SELECT s.*, u.username FROM sales s " +
                             "LEFT JOIN users u ON s.user_id = u.id " +
                             "ORDER BY s.sale_date DESC";
            
            try (Statement st = con.createStatement(); 
                 ResultSet rs = st.executeQuery(tableSql)) {
                while (rs.next()) {
                    Sale sale = new Sale();
                    sale.setId(rs.getInt("id"));
                    sale.setSaleDate(rs.getTimestamp("sale_date"));
                    sale.setTotalAmount(rs.getDouble("total_amount"));
                    sale.setPaymentMethod(rs.getString("payment_method"));
                    sale.setCashier(rs.getString("username")); 
                    salesList.add(sale);
                }
            }

            request.setAttribute("totalSales", totalRevenue);
            request.setAttribute("totalProductsSold", totalSalesCount);
            request.setAttribute("sales", salesList);
            request.setAttribute("activeCashiers", 1);
            request.setAttribute("growthRate", 0.0);

            request.getRequestDispatcher("jsp/reports.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("clearHistory".equals(action)) {
            boolean isSuccess = false;
            
            // Logic to clear history
            // Option A: Using a DAO (Recommended)
            // ReportDAO reportDAO = new ReportDAO();
            // isSuccess = reportDAO.clearAllSalesHistory();

            // Option B: Direct JDBC (If you don't have a DAO class yet)
            try (Connection con = DBConnection.getConnection()) {
                String sql = "DELETE FROM sales"; 
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.executeUpdate();
                    isSuccess = true;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            if (isSuccess) {
                // Redirect back to the Servlet's GET method to refresh the table
                response.sendRedirect("ReportServlet?status=success&msg=History+Cleared");
            } else {
                response.sendRedirect("ReportServlet?status=error&msg=Failed+to+Clear");
            }
        }
    }
}