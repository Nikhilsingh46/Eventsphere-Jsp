package com.eventsphere.servlet;

import com.eventsphere.dao.EventDAO;
import com.eventsphere.model.Event;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/EventListServlet")
public class EventListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EventDAO eventDAO = new EventDAO();
        
        List<Event> eventList = eventDAO.getAllEvents();
         
        request.setAttribute("eventList", eventList);
        RequestDispatcher rd = request.getRequestDispatcher("adminEvents.jsp");
        rd.forward(request, response);
    }
}
