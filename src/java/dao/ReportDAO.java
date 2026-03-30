package dao;

import model.Sale;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {

    public List<Sale> getAllSales() throws Exception {
        List<Sale> salesList = new ArrayList<>();
        // Query to get sale details + username + count of items in that sale
        String sql = "SELECT s.*, u.username, " +
                     "(SELECT SUM(quantity) FROM sale_items WHERE sale_id = s.id) as item_count " +
                     "FROM sales s " +
                     "LEFT JOIN users u ON s.user_id = u.id " +
                     "ORDER BY s.sale_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Sale sale = new Sale();
                sale.setId(rs.getInt("id"));
                sale.setSaleDate(rs.getTimestamp("sale_date"));
                sale.setTotalAmount(rs.getDouble("total_amount"));
                sale.setPaymentMethod(rs.getString("payment_method"));
                
                // These use the new methods we added to Sale.java
                sale.setCashier(rs.getString("username")); 
                sale.setItems(rs.getInt("item_count"));
                sale.setSubtotal(rs.getDouble("total_amount") * 0.92); // Estimating subtotal
                sale.setTax(rs.getDouble("total_amount") * 0.08);      // Estimating tax
                
                salesList.add(sale);
            }
        }
        return salesList;
    }

    public double getTotalRevenue() throws Exception {
        String sql = "SELECT SUM(total_amount) FROM sales";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getDouble(1);
        }
        return 0.0;
    }

    public int getTotalProductsSold() throws Exception {
        String sql = "SELECT SUM(quantity) FROM sale_items";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }
    public boolean clearAllSalesHistory() {
    // Replace 'sales' with your actual table name if different (e.g., 'transactions')
    String sql = "DELETE FROM sales"; 
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        int rowsAffected = ps.executeUpdate();
        // Returns true if rows were deleted, or if the table was already empty
        return rowsAffected >= 0; 
        
    } catch (SQLException e) {
        System.out.println("Error clearing history: " + e.getMessage());
        return false;
    }
}
}