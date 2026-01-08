package com.eventsphere.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false); // Don't create new session
        if (session != null) {
            session.invalidate(); // End the session
        }

        response.sendRedirect("login.jsp"); // Redirect to login page after logout
    }
}
