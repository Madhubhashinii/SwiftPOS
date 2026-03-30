package controller;

import util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class ReceiptServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int saleId = Integer.parseInt(request.getParameter("saleId"));

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM sales WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, saleId);

            ResultSet rs = ps.executeQuery();
            request.setAttribute("saleData", rs);

            request.getRequestDispatcher("jsp/receipt.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
