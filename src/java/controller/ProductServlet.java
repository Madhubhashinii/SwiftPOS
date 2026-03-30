package controller;

import dao.ProductDAO;
import model.Product;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ProductServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    String action = request.getParameter("action");
    
    // If action is null (which happens when you just go to /products), 
    // it will call listProducts and show your Management page.
    if (action == null || action.equals("list")) {
        try {
            listProducts(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    } 
    // ... rest of your code
}
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if (action.equals("add")) {
                addProduct(request, response);
            } else if (action.equals("update")) {
                updateProduct(request, response);
            } else if (action.equals("delete")) {
                deleteProduct(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws Exception, ServletException, IOException {
        
        List<Product> products = productDAO.getAll();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/jsp/products.jsp").forward(request, response);
    }
    
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception, IOException {
        
        String name = request.getParameter("productName");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stockQuantity"));
        
        Product product = new Product();
        product.setName(name);
        product.setPrice(price);
        product.setStock(stock);
        product.setCategoryId(categoryId);
        
        productDAO.addProduct(product);
        
        response.sendRedirect(request.getContextPath() + "/products");
    }
    
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("productName");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stockQuantity"));
        
        Product product = new Product();
        product.setId(id);
        product.setName(name);
        product.setPrice(price);
        product.setStock(stock);
        product.setCategoryId(categoryId);
        
        productDAO.updateProduct(product);
        
        response.sendRedirect(request.getContextPath() + "/products");
    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteProduct(id);
        
        response.sendRedirect(request.getContextPath() + "/products");
    }
}