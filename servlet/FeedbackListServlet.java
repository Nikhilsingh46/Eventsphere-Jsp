package com.eventsphere.servlet;

import com.eventsphere.db.DBConnection;
import com.eventsphere.model.Feedback;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/FeedbackListServlet")
public class FeedbackListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Feedback> feedbackList = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT f.*, u.fullname AS userName, e.eventName FROM feedbacks f " +
                           "JOIN users u ON f.user_id = u.userId " +
                           "JOIN events e ON f.event_id = e.event_id " +
                           "ORDER BY f.created_at DESC";

            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setId(rs.getInt("id"));
                fb.setEventId(rs.getInt("event_id"));
                fb.setUserId(rs.getInt("user_id"));
                fb.setFeedbackText(rs.getString("feedback_text"));
                fb.setCreatedAt(rs.getTimestamp("created_at"));
                fb.setUserName(rs.getString("userName"));
                fb.setEventName(rs.getString("eventName"));

                feedbackList.add(fb);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("feedbackList", feedbackList);
        RequestDispatcher rd = request.getRequestDispatcher("adminFeedback.jsp");
        rd.forward(request, response);
    }
}
