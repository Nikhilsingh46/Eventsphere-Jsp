package com.eventsphere.dao;

import com.eventsphere.db.DBConnection;
import com.eventsphere.model.Feedback;

import java.sql.*;
import java.util.*;

public class FeedbackDAO {

    public List<Feedback> getAllFeedbacks() {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, u.fullName, e.eventName FROM feedbacks f " +
                     "JOIN users u ON f.user_id = u.userId " +
                     "JOIN events e ON f.event_id = e.event_id " +
                     "ORDER BY f.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setId(rs.getInt("id"));
                fb.setEventId(rs.getInt("event_id"));
                fb.setUserId(rs.getInt("user_id"));
                fb.setFeedbackText(rs.getString("feedback_text"));
                fb.setCreatedAt(rs.getTimestamp("created_at"));
                fb.setUserName(rs.getString("fullName"));
                fb.setEventName(rs.getString("eventName"));
                feedbacks.add(fb);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbacks;
    }
}
