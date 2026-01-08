package com.eventsphere.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.eventsphere.db.DBConnection;
import com.eventsphere.model.Event;

import java.time.LocalDate;

public class EventDAO {

    // Add Event
    public boolean addEvent(Event event) {
        boolean isAdded = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO events (eventName, description, event_date, is_upcoming, venue, coordinator_name, coordinator_email, coordinator_phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, event.getEventName());
            ps.setString(2, event.getDescription());
            ps.setDate(3, java.sql.Date.valueOf(event.getEvent_date()));
            ps.setBoolean(4, true); // Default to true
            ps.setString(5, event.getVenue());
            ps.setString(6, event.getCoordinator_name());
            ps.setString(7, event.getCoordinator_email());
            ps.setString(8, event.getCoordinator_phone());

            int rows = ps.executeUpdate();
            if (rows > 0) isAdded = true;

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isAdded;
    }

    // Get Events by College with is_upcoming auto update
    public List<Event> getEventsByCollege(String collegeName) {
        List<Event> eventList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM events WHERE college_name = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, collegeName);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("event_id"));
                event.setEventName(rs.getString("eventName"));
                event.setDescription(rs.getString("description"));
                event.setEvent_date(rs.getDate("event_date").toString());
                event.setVenue(rs.getString("venue"));
                event.setCoordinator_name(rs.getString("coordinator_name"));
                event.setCoordinator_email(rs.getString("coordinator_email"));
                event.setCoordinator_phone(rs.getString("coordinator_phone"));

                // Auto update is_upcoming
                LocalDate eventDate = LocalDate.parse(event.getEvent_date());
                LocalDate today = LocalDate.now();
                boolean isUpcoming = !eventDate.isBefore(today);
                updateEventUpcomingStatus(event.getEventId(), isUpcoming);
                event.setIsUpcoming(isUpcoming);

                eventList.add(event);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return eventList;
    }

    // ✅ Get all events with is_upcoming auto-update
    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM events");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("event_id"));
                event.setEventName(rs.getString("eventName"));
                event.setDescription(rs.getString("description"));
                event.setEvent_date(rs.getDate("event_date").toString());
                event.setVenue(rs.getString("venue"));
                event.setCoordinator_name(rs.getString("coordinator_name"));
                event.setCoordinator_email(rs.getString("coordinator_email"));
                event.setCoordinator_phone(rs.getString("coordinator_phone"));

                // ✅ Auto update is_upcoming based on today's date
                LocalDate eventDate = LocalDate.parse(event.getEvent_date());
                LocalDate today = LocalDate.now();
                boolean isUpcoming = !eventDate.isBefore(today);
                updateEventUpcomingStatus(event.getEventId(), isUpcoming);
                event.setIsUpcoming(isUpcoming);
                
                events.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }

    // Update is_upcoming status
    public void updateEventUpcomingStatus(int eventId, boolean isUpcoming) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE events SET is_upcoming = ? WHERE event_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setBoolean(1, isUpcoming);
            ps.setInt(2, eventId);
            ps.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
