package com.eventsphere.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import com.eventsphere.db.DBConnection;
import javax.servlet.annotation.WebServlet;

@WebServlet("/CoordinatorListServlet")
public class CoordinatorListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        List<String[]> coordList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT name, email, college FROM users WHERE role = 'coordinator'")) {

            while (rs.next()) {
                coordList.add(new String[]{
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("college")
                });
            }

            request.setAttribute("coordList", coordList);
            RequestDispatcher rd = request.getRequestDispatcher("adminCoordinators.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
