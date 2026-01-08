package com.eventsphere.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/eventsphere";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Rnikhil24@";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String userEmail = (session != null) ? (String) session.getAttribute("email") : null;

        if (userEmail == null) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().print("Unauthorized access.");
            return;
        }

        String eventIdParam = request.getParameter("event_id");
        String feedbackText = request.getParameter("feedback_text");

        if (eventIdParam == null || feedbackText == null || feedbackText.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("Missing event ID or feedback text.");
            return;
        }

        int eventId;
        try {
            eventId = Integer.parseInt(eventIdParam);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("Invalid event ID.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            // Get user ID from email
            String getUserQuery = "SELECT userId FROM users WHERE email = ?";
            int userId = -1;
            try (PreparedStatement ps = conn.prepareStatement(getUserQuery)) {
                ps.setString(1, userEmail);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        userId = rs.getInt("userId");
                    }
                }
            }

            if (userId != -1) {
                // Optional: Prevent duplicate feedback
                String checkQuery = "SELECT id FROM feedbacks WHERE event_id = ? AND user_id = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                    checkStmt.setInt(1, eventId);
                    checkStmt.setInt(2, userId);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next()) {
                            response.setContentType("text/plain");
                            response.getWriter().print("You have already submitted feedback for this event.");
                            return;
                        }
                    }
                }

                // Insert feedback
                String insertQuery = "INSERT INTO feedbacks (event_id, user_id, feedback_text, created_at) VALUES (?, ?, ?, NOW())";
                try (PreparedStatement ps = conn.prepareStatement(insertQuery)) {
                    ps.setInt(1, eventId);
                    ps.setInt(2, userId);
                    ps.setString(3, feedbackText);
                    ps.executeUpdate();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("Server error while saving feedback.");
            return;
        }

        response.setContentType("text/plain");
        response.getWriter().print("Thank you for your feedback!");
    }
}
