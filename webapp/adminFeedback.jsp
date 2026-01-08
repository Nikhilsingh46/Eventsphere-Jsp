<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.eventsphere.model.Feedback" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Feedback</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        h2 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px 15px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Feedback List</h2>
    <table>
        <tr>
            <th>User Name</th>
            <th>Event Name</th>
            <th>Feedback</th>
            <th>Submitted At</th>
        </tr>
        <%
            List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");
            if (feedbackList != null && !feedbackList.isEmpty()) {
                for (Feedback fb : feedbackList) {
        %>
        <tr>
            <td><%= fb.getUserName() %></td>
            <td><%= fb.getEventName() %></td>
            <td><%= fb.getFeedbackText() %></td>
            <td><%= fb.getCreatedAt() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4">No feedback available.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
