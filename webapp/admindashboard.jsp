<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | EventSphere</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
        }
        header {
    background: #1e293b;
    color: #fff;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: relative;
}

.logout-container {
    margin-left: auto;
}
        .logo {
            font-size: 24px;
            font-weight: bold;
        }
        .logout-btn {
            background-color: #ef4444;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        .cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 40px;
            justify-content: center;
        }
        .card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            width: 200px;
            text-align: center;
            box-shadow: 0 0 10px rgba(0,0,0,0.08);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card a {
            text-decoration: none;
            color: #1e40af;
            font-weight: 600;
        }
        .form-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.08);
        }
        .form-section h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            display: grid;
            gap: 12px;
            max-width: 600px;
            margin: auto;
        }
        input, select, textarea {
            padding: 12px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        button[type="submit"] {
            background-color: #2563eb;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }
        button[type="submit"]:hover {
            background-color: #1e40af;
        }
        .msg-success {
            color: green;
            text-align: center;
            margin-top: 10px;
        }
        .msg-error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
        footer {
            text-align: center;
            padding: 20px;
            background-color: #1e293b;
            color: white;
            margin-top: 60px;
        }
    </style>
</head>
<body>

<header>
    <div class="logo">EventSphere - Admin</div>
    <div class="logout-container">
        <form action="LogoutServlet" method="post">
            <button class="logout-btn">Logout</button>
        </form>
    </div>
</header>

<div class="container">
    <h2>Welcome, Admin 👋</h2>

    <div class="cards">
        <div class="card"><a href="EventListServlet">View Events</a></div>
        <div class="card"><a href="FeedbackListServlet">View Feedbacks</a></div>
        <div class="card"><a href="UserListServlet">View Users</a></div>
  
    </div>

    <div class="form-section">
        <h3>Add New Event</h3>
        <form action="AddEventServlet" method="post">
            <input type="text" name="eventName" placeholder="Event Name" required>
            <textarea name="description" placeholder="Event Description" rows="4" required></textarea>
            <input type="date" name="event_date" required>
            <input type="text" name="venue" placeholder="Venue" required>
            <input type="text" name="coordinator_name" placeholder="Coordinator Name" required>
            <input type="email" name="coordinator_email" placeholder="Coordinator Email" required>
            <input type="text" name="coordinator_phone" placeholder="Coordinator Phone" required>
            <select name="status" required>
                <option value="">-- Select Status --</option>
                <option value="upcoming">Upcoming</option>
                <option value="past">Past</option>
            </select>
            <button type="submit">Add Event</button>
        </form>

        <%
            String msg = request.getParameter("msg");
            if ("success".equals(msg)) {
        %>
            <p class="msg-success">✅ Event added successfully!</p>
        <%
            } else if ("error".equals(msg)) {
        %>
            <p class="msg-error">❌ Something went wrong!</p>
        <% } %>
    </div>
</div>

<footer>
    &copy; 2025 EventSphere. Admin Panel.
</footer>

</body>
</html>
