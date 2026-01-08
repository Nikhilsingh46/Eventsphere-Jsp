<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eventsphere.model.Event" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Events - EventSphere Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f3f5;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #0d1117;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }
        .container {
            margin: 40px auto;
            max-width: 1100px;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background-color: #0d1117;
            color: white;
        }
    </style>
</head>
<body>
<header>All Events - EventSphere Admin</header>

<div class="container">
    <h2>📅 Registered Events</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Event Name</th>
            <th>Description</th>
            <th>Date</th>
            <th>Venue</th>
            <th>Coordinator Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Status</th>
        </tr>

        <%
            List<Event> eventList = (List<Event>) request.getAttribute("eventList");
            if (eventList != null && !eventList.isEmpty()) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDate today = LocalDate.now();

                for (Event event : eventList) {
                    LocalDate eventDate = LocalDate.parse(event.getEvent_date(), formatter);
                    String status = eventDate.isBefore(today) ? "Past" : "Upcoming";
        %>
        <tr>
            <td><%= event.getEventId() %></td>
            <td><%= event.getEventName() %></td>
            <td><%= event.getDescription() %></td>
            <td><%= event.getEvent_date() %></td>
            <td><%= event.getVenue() %></td>
            <td><%= event.getCoordinator_name() %></td>
            <td><%= event.getCoordinator_email() %></td>
            <td><%= event.getCoordinator_phone() %></td>
            <td><%= status %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="9">No events found!</td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
