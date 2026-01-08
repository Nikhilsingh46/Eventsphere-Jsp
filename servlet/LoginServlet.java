package com.eventsphere.servlet;

import com.eventsphere.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.*;
import java.util.Arrays;
import java.util.List;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    // Hardcoded admin email list (case-insensitive)
    private static final List<String> ADMIN_EMAILS = Arrays.asList("admin@eventsphere.com");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email").trim().toLowerCase();
        String password = request.getParameter("password").trim();

        try (Connection conn = DBConnection.getConnection()) {

            String query = "SELECT * FROM users WHERE LOWER(email)=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("userId", rs.getInt("userId"));
                session.setAttribute("collegeName", rs.getString("collegeName"));
                session.setAttribute("fullName", rs.getString("fullName"));

                // Check if user is admin
                if (ADMIN_EMAILS.contains(email)) {
                    response.sendRedirect("admindashboard.jsp");
                } else {
                    response.sendRedirect("UserDashboardServlet");
                }

            } else {
                // Forward instead of redirect to avoid ?error=invalid in URL
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                request.setAttribute("error", "invalid");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
