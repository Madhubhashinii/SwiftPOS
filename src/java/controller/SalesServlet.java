package controller;

import dao.ProductDAO;
import dao.CategoryDAO;
import dao.SalesDAO;
import model.Product;
import model.Category;
import model.Sale;
import util.DBConnection;
import org.json.JSONObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.List; // Essential for the Product list
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class SalesServlet extends HttpServlet {

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        List<Product> products = productDAO.getAll(); 
        List<Category> categories = categoryDAO.getAll();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        
        // ✅ ADD THESE TWO LINES:
        request.setAttribute("saleId", System.currentTimeMillis() % 10000); // Temporary ID
        request.setAttribute("currentDate", new java.util.Date().toString());

    } catch (Exception e) {
        e.printStackTrace();
    }
    request.getRequestDispatcher("/jsp/sales.jsp").forward(request, response);
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            String jsonString = request.getParameter("saleData");
            JSONObject saleObject = new JSONObject(jsonString);
            
            double total = saleObject.getDouble("total");
            String paymentMethod = saleObject.getString("paymentMethod");
            
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                out.print("{\"success\": false, \"message\": \"User session expired. Please login again.\"}");
                return;
            }

            // Create Sale object to pass to your DAO
            Sale sale = new Sale();
            sale.setUserId(userId);
            sale.setTotalAmount(total);
            sale.setPaymentMethod(paymentMethod);

            // Use your existing SalesDAO to save
            SalesDAO salesDAO = new SalesDAO();
            int saleId = salesDAO.saveSale(sale);

            if (saleId > 0) {
                out.print("{\"success\": true, \"saleId\": " + saleId + "}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to save sale in database.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}