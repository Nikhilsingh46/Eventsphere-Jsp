package com.eventsphere.dao;

import com.eventsphere.db.DBConnection;
import com.eventsphere.model.Coordinator;

import java.sql.*;
import java.util.*;

public class CoordinatorDAO {

    public List<Coordinator> getAllCoordinators() {
        List<Coordinator> coordinators = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM coordinator");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Coordinator c = new Coordinator();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                coordinators.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return coordinators;
    }
}
