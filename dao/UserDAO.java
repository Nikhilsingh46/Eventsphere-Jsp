package com.eventsphere.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.eventsphere.db.DBConnection;
import com.eventsphere.model.User;

public class UserDAO {

    // ✅ Login method (unchanged)
    public User login(String email, String password) {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        user = new User();
                        user.setId(rs.getInt("userId"));
                        user.setFullName(rs.getString("fullName"));
                        user.setEmail(rs.getString("email"));
                        user.setPassword(rs.getString("password"));

                        // Admin detection logic
                        if ("admin@eventsphere.com".equalsIgnoreCase(email) && "admin123".equals(password)) {
                            user.setEmail("admin");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // ✅ Fetch all users (for admin dashboard)
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM users");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("userId"));
                user.setFullName(rs.getString("fullName"));
                user.setEmail(rs.getString("email"));
                user.setCollegeName(rs.getString("collegeName"));
                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }
}
