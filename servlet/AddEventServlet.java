package com.eventsphere.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eventsphere.db.DBConnection;

@WebServlet("/AddEventServlet")
public class AddEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String eventName = request.getParameter("eventName");
        String description = request.getParameter("description");
        String event_date = request.getParameter("event_date");
        String venue = request.getParameter("venue");
        String coordinator_name = request.getParameter("coordinator_name");
        String coordinator_email = request.getParameter("coordinator_email");
        String coordinator_phone = request.getParameter("coordinator_phone");
        String isUpcomingParam = request.getParameter("isUpcoming"); // New: Expecting "true"/"false" or "on"

        // Convert checkbox or dropdown value to boolean
        boolean isUpcoming = "true".equalsIgnoreCase(isUpcomingParam) || "on".equalsIgnoreCase(isUpcomingParam);

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create connection
            conn = DBConnection.getConnection();

            // Updated SQL insert with boolean is_upcoming
            String sql = "INSERT INTO events (eventName, description, event_date, venue, coordinator_name, coordinator_email, coordinator_phone, is_upcoming) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, eventName);
            pstmt.setString(2, description);
            pstmt.setString(3, event_date);
            pstmt.setString(4, venue);
            pstmt.setString(5, coordinator_name);
            pstmt.setString(6, coordinator_email);
            pstmt.setString(7, coordinator_phone);
            pstmt.setBoolean(8, isUpcoming); // New boolean value

            // Execute
            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("admindashboard.jsp?msg=Event Added Successfully");
            } else {
                response.sendRedirect("admindashboard.jsp?msg=Failed to Add Event");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admindashboard.jsp?msg=Error: " + e.getMessage());
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
