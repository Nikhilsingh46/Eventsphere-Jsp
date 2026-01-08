<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Admin - Coordinators</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #FF9800; color: white; }
    </style>
</head>
<body>
    <h2>Coordinator List</h2>
    <table>
        <tr>
            <th>Name</th><th>Email</th><th>College</th>
        </tr>
        <%
            List<String[]> list = (List<String[]>) request.getAttribute("coordList");
            for(String[] c : list) {
        %>
        <tr>
            <td><%= c[0] %></td>
            <td><%= c[1] %></td>
            <td><%= c[2] %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
