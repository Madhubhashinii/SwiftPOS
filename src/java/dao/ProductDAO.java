package dao;

import model.Product;
import util.DBConnection;
import java.sql.*;
import java.util.*;

public class ProductDAO {
    
    // Get all products
    public List<Product> getAll() throws Exception {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getInt("category_id")
                ));
            }
        }
        return list;
    }
    
    // Add new product
    public void addProduct(Product product) throws Exception {
        String sql = "INSERT INTO products (name, price, stock, category_id) VALUES (?, ?, ?, ?)";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setInt(4, product.getCategoryId());
            ps.executeUpdate();
        }
    }
    
    // Update product
    public void updateProduct(Product product) throws Exception {
        String sql = "UPDATE products SET name=?, price=?, stock=?, category_id=? WHERE id=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setInt(4, product.getCategoryId());
            ps.setInt(5, product.getId());
            ps.executeUpdate();
        }
    }
    
    // Delete product
    public void deleteProduct(int id) throws Exception {
        String sql = "DELETE FROM products WHERE id=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
    
    // Get product by ID
    public Product getProductById(int id) throws Exception {
        String sql = "SELECT * FROM products WHERE id=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getDouble("price"),
                    rs.getInt("stock"),
                    rs.getInt("category_id")
                );
            }
        }
        return null;
    }
}