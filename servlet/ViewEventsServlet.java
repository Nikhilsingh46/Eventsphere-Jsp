package com.eventsphere.servlet;

import com.eventsphere.dao.EventDAO;
import com.eventsphere.model.Event;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewEvents")
public class ViewEventsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get collegeName from session
        HttpSession session = request.getSession(false);
        String collegeName = (session != null) ? (String) session.getAttribute("collegeName") : null;

        if (collegeName != null) {
            // Get list of events from DAO
            EventDAO eventDAO = new EventDAO();
            List<Event> eventList = eventDAO.getEventsByCollege(collegeName);

            // Set the event list in request scope
            request.setAttribute("eventList", eventList);

            // Forward to admin dashboard to display events
            request.getRequestDispatcher("admindashboard.jsp").forward(request, response);
        } else {
            // If no collegeName in session, redirect to login page
            response.sendRedirect("login.jsp");
        }
    }
}
