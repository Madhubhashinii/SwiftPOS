package controller;

import model.User;
import util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Create user object
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                
                // Create session and store user
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());
                
                // Redirect based on role
                if ("admin".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/jsp/admin_dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/jsp/admin_dashboard.jsp");
                }
                
            } else {
                // Login failed
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to login page
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    }
}