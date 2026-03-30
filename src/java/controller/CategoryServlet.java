package controller;

import dao.CategoryDAO;
import model.Category;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CategoryServlet extends HttpServlet {
    
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.equals("list")) {
                listCategories(request, response);
            } else if (action.equals("delete")) {
                deleteCategory(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if (action.equals("add")) {
                addCategory(request, response);
            } else if (action.equals("update")) {
                updateCategory(request, response);
            } else if (action.equals("delete")) {
                deleteCategory(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws Exception, ServletException, IOException {
        
        List<Category> categories = categoryDAO.getAll();
        
        // Calculate stats
        int totalCategories = categories.size();
        int activeCategories = (int) categories.stream().filter(c -> c.getProductCount() > 0).count();
        int emptyCategories = totalCategories - activeCategories;
        int totalProducts = categories.stream().mapToInt(Category::getProductCount).sum();
        int maxProductsPerCategory = categories.stream().mapToInt(Category::getProductCount).max().orElse(1);
        
        request.setAttribute("categories", categories);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("activeCategories", activeCategories);
        request.setAttribute("emptyCategories", emptyCategories);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("maxProductsPerCategory", maxProductsPerCategory);
        
        request.getRequestDispatcher("/jsp/categories.jsp").forward(request, response);
    }
    
    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws Exception, IOException {
        
        String name = request.getParameter("categoryName");
        String description = request.getParameter("description");
        
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);
        
        categoryDAO.addCategory(category);
        
        response.sendRedirect(request.getContextPath() + "/categories");
    }
    
    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws Exception, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("categoryName");
        String description = request.getParameter("description");
        
        Category category = new Category();
        category.setId(id);
        category.setName(name);
        category.setDescription(description);
        
        categoryDAO.updateCategory(category);
        
        response.sendRedirect(request.getContextPath() + "/categories");
    }
    
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws Exception, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        categoryDAO.deleteCategory(id);
        
        response.sendRedirect(request.getContextPath() + "/categories");
    }
}