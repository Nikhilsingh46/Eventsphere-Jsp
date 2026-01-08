<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.eventsphere.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Users</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: Arial;
            margin: 20px;
            background-color: #f4f4f4;
        }
        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 10px #ccc;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h2>Registered Users</h2>

    <%
        List<User> users = (List<User>) request.getAttribute("userList");
        if (users != null && !users.isEmpty()) {
    %>
        <table>
            <tr>
                <th>User ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>College</th>
            </tr>
            <% 
                for (User user : users) {
                    // Skip the admin based on email or full name (no 'role' field in model)
                    if (!"admin@gmail.com".equalsIgnoreCase(user.getEmail()) && 
                        !"admin".equalsIgnoreCase(user.getFullName())) {
            %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getFullName() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getCollegeName() %></td>
            </tr>
            <% 
                    }
                } 
            %>
        </table>
    <%
        } else {
    %>
        <p style="text-align:center;">No users found.</p>
    <%
        }
    %>
</body>
</html>
