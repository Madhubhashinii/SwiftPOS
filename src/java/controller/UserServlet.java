package controller;

import dao.UserDAO;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

//@WebServlet("/users")
public class UserServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "delete":
                    deleteUser(request, response);
                    break;
                case "reset":
                    resetPassword(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                addUser(request, response);
            } else if ("update".equals(action)) {
                updateUser(request, response);
            }
        } catch (SQLException ex) {
            // Handle Unique Constraint Violation (Username already exists)
            if (ex.getMessage().contains("Duplicate entry")) {
                request.setAttribute("error", "Username already exists!");
                try {
                    listUsers(request, response);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } else {
                throw new ServletException(ex);
            }
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<User> listUser = userDAO.getAllUsers();
        request.setAttribute("users", listUser);
        request.getRequestDispatcher("/jsp/users.jsp").forward(request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        User newUser = new User();
        newUser.setUsername(request.getParameter("username"));
        newUser.setPassword(request.getParameter("password"));
        // This matches your ENUM ('Admin', 'Cashier')
        newUser.setRole(request.getParameter("role"));
        
        userDAO.addUser(newUser);
        response.sendRedirect(request.getContextPath() + "/users");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.getUserById(id);
        if (user != null) {
            user.setUsername(request.getParameter("username"));
            user.setRole(request.getParameter("role"));
            userDAO.updateUser(user);
        }
        response.sendRedirect(request.getContextPath() + "/users");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(id);
        response.sendRedirect(request.getContextPath() + "/users");
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.getUserById(id);
        if (user != null) {
            user.setPassword("1234"); // Default password
            userDAO.updateUser(user);
        }
        response.sendRedirect(request.getContextPath() + "/users");
    }
}