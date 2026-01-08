package com.eventsphere.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UserDashboardServlet")
public class UserDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/eventsphere";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Rnikhil24@";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("email");

        ArrayList<Event> upcomingEvents = new ArrayList<>();
        ArrayList<Event> previousEvents = new ArrayList<>();

        Event todayEvent = null;       // ⭐ Today's event
        boolean hasTodayEvent = false; // ⭐ flag for ribbon visibility

        String fullName = "";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

            // Fetch user name
            String userQuery = "SELECT fullName FROM users WHERE email = ?";
            try (PreparedStatement userPs = conn.prepareStatement(userQuery)) {
                userPs.setString(1, userEmail);
                try (ResultSet userRs = userPs.executeQuery()) {
                    if (userRs.next()) {
                        fullName = userRs.getString("fullName");
                    }
                }
            }

            // ⭐ Fetch today's event
            String todayQuery = "SELECT * FROM events WHERE event_date = CURDATE() LIMIT 1";
            try (PreparedStatement ps = conn.prepareStatement(todayQuery);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    todayEvent = extractEvent(rs);
                    hasTodayEvent = true;
                }
            }

            // Fetch upcoming events
            String queryUpcoming = "SELECT * FROM events WHERE event_date > CURDATE()";
            try (PreparedStatement ps = conn.prepareStatement(queryUpcoming);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    upcomingEvents.add(extractEvent(rs));
                }
            }

            // Fetch previous events
            String queryPastEvent = "SELECT * FROM events WHERE event_date < CURDATE()";
            try (PreparedStatement ps = conn.prepareStatement(queryPastEvent);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    previousEvents.add(extractEvent(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong while loading events.");
        }

        // Set attributes for JSP
        request.setAttribute("userEmail", userEmail);
        request.setAttribute("fullName", fullName);
        request.setAttribute("upcomingEvents", upcomingEvents);
        request.setAttribute("previousEvents", previousEvents);

        // ⭐ Special ribbon attributes
        request.setAttribute("todayEvent", todayEvent);
        request.setAttribute("hasTodayEvent", hasTodayEvent);

        RequestDispatcher dispatcher = request.getRequestDispatcher("userdashboard.jsp");
        dispatcher.forward(request, response);
    }

    // Extract event
    private Event extractEvent(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setEventId(rs.getInt("event_id"));
        event.setEventName(rs.getString("eventName"));
        event.setDescription(rs.getString("description"));
        event.setEventDate(rs.getDate("event_date"));
        event.setVenue(rs.getString("venue"));
        event.setCoordinatorName(rs.getString("coordinator_name"));
        event.setCoordinatorEmail(rs.getString("coordinator_email"));
        event.setCoordinatorPhone(rs.getString("coordinator_phone"));
        return event;
    }

    // Inner Event Class
    public static class Event {
        private int eventId;
        private String eventName;
        private String description;
        private Date eventDate;
        private String venue;
        private String coordinatorName;
        private String coordinatorEmail;
        private String coordinatorPhone;

        public int getEventId() { return eventId; }
        public void setEventId(int eventId) { this.eventId = eventId; }

        public String getEventName() { return eventName; }
        public void setEventName(String eventName) { this.eventName = eventName; }

        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }

        public Date getEventDate() { return eventDate; }
        public void setEventDate(Date eventDate) { this.eventDate = eventDate; }

        public String getVenue() { return venue; }
        public void setVenue(String venue) { this.venue = venue; }

        public String getCoordinatorName() { return coordinatorName; }
        public void setCoordinatorName(String coordinatorName) { this.coordinatorName = coordinatorName; }

        public String getCoordinatorEmail() { return coordinatorEmail; }
        public void setCoordinatorEmail(String coordinatorEmail) { this.coordinatorEmail = coordinatorEmail; }

        public String getCoordinatorPhone() { return coordinatorPhone; }
        public void setCoordinatorPhone(String coordinatorPhone) { this.coordinatorPhone = coordinatorPhone; }
    }
}
