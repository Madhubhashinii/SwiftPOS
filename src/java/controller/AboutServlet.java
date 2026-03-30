package controller;

import util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AboutServlet extends HttpServlet {

    // THIS handles sidebar click
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/jsp/about.jsp")
               .forward(request, response);
    }

}