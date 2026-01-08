package com.eventsphere.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eventsphere.db.DBConnection;
import com.eventsphere.model.User;

@WebServlet("/UserListServlet")
public class UserListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<User> userList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            // Fetch all users
            String sql = "SELECT userId, fullName, email, collegeName FROM users";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String email = rs.getString("email");
                String fullName = rs.getString("fullName");

                // Skip admin users (based on email and full name)
                if ("admin@gmail.com".equalsIgnoreCase(email) || "admin".equalsIgnoreCase(fullName)) {
                    continue;
                }

                User user = new User();
                user.setId(rs.getInt("userId"));
                user.setFullName(fullName);
                user.setEmail(email);
                user.setCollegeName(rs.getString("collegeName"));

                userList.add(user);
            }

            request.setAttribute("userList", userList);
            request.getRequestDispatcher("adminUsers.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error fetching users.");
            request.getRequestDispatcher("adminUsers.jsp").forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { }
            try { if (stmt != null) stmt.close(); } catch (Exception e) { }
            try { if (conn != null) conn.close(); } catch (Exception e) { }
        }
    }
}
