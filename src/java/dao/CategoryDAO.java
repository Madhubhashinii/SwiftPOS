package dao;

import model.Category;
import util.DBConnection;
import java.sql.*;
import java.util.*;

public class CategoryDAO {
    
    // Get all categories with product count
    public List<Category> getAll() throws Exception {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT c.*, COUNT(p.id) as product_count " +
                     "FROM categories c " +
                     "LEFT JOIN products p ON c.id = p.category_id " +
                     "GROUP BY c.id";
        
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                category.setProductCount(rs.getInt("product_count"));
                list.add(category);
            }
        }
        return list;
    }
    
    // Add new category
    public void addCategory(Category category) throws Exception {
        String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.executeUpdate();
        }
    }
    
    // Update category
    public void updateCategory(Category category) throws Exception {
        String sql = "UPDATE categories SET name=?, description=? WHERE id=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getId());
            ps.executeUpdate();
        }
    }
    
    // Delete category
    public void deleteCategory(int id) throws Exception {
        String sql = "DELETE FROM categories WHERE id=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
    
    // Get category by ID
    public Category getCategoryById(int id) throws Exception {
        String sql = "SELECT * FROM categories WHERE id=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                return category;
            }
        }
        return null;
    }
}