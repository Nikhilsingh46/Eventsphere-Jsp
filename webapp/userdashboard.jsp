<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.eventsphere.servlet.UserDashboardServlet.Event" %>
<%@ page import="com.eventsphere.db.DBConnection" %>

<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String fullName = (String) session.getAttribute("fullName"); // name set in session
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - EventSphere</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to bottom right, #e0f2ff, #cbd5ff);
        }

.event-ribbon {
    width: 100%;
    background: #5e17eb;
    color: white;
    padding: 10px 0;
    overflow: hidden;
    position: relative;
    font-size: 16px;
    font-weight: 500;
    border-bottom: 3px solid #3b0db3;
}

.ribbon-content {
    white-space: nowrap;
    display: inline-block;
    padding-left: 100%;
    animation: ribbon-scroll 12s linear infinite;
}

@keyframes ribbon-scroll {
    0% { transform: translateX(0); }
    100% { transform: translateX(-100%); }
}

        header {
            background-color: #1a1a1a;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .logout-btn {
            background-color: crimson;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .container {
            padding: 40px;
        }

        h1 {
            font-size: 26px;
            margin-bottom: 30px;
        }

        h3 {
            margin-top: 50px;
            color: #333;
            border-left: 6px solid #4f46e5;
            padding-left: 15px;
        }

        .event-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 20px;
        }

        .event-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 25px;
            width: 300px;
            transition: 0.3s ease;
        }

        .event-card:hover {
            transform: translateY(-5px);
        }

        .event-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .event-description {
            font-size: 14px;
            margin-bottom: 15px;
        }

        .btn-group {
            display: flex;
            justify-content: space-between;
        }

        .btn {
            padding: 8px 14px;
            font-size: 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-book {
            background-color: #28a745;
            color: white;
        }

        .btn-feedback {
            background-color: #facc15;
            color: #222;
        }

        footer {
            text-align: center;
            background-color: #1a1a1a;
            color: white;
            padding: 15px 0;
            margin-top: 60px;
        }
    </style>
</head>
<body>

<header>
    <div class="logo">EventSphere</div>
    <form action="LogoutServlet" method="post">
        <button class="logout-btn" type="submit">Logout</button>
    </form>
</header>

<%
    Boolean hasTodayEvent = (Boolean) request.getAttribute("hasTodayEvent");
    if (hasTodayEvent != null && hasTodayEvent) {

        // Today event object
        Event todayEvent = (Event) request.getAttribute("todayEvent");
%>

    <div class="event-ribbon">
        <div class="ribbon-content">
            🎉 Today’s Event:
            <strong><%= todayEvent.getEventName() %></strong> |
            Venue: <%= todayEvent.getVenue() %> |
            Coordinator: <%= todayEvent.getCoordinatorName() %> |
            <%= todayEvent.getDescription() %>
        </div>
    </div>

<%
    }
%>


<div class="container">
    <h1>Welcome, <%= fullName %> 👋</h1>

    <!-- Upcoming Events Section -->
    <h3>📅 Upcoming Events</h3>
    <div class="event-grid">
        <%
            List<Event> upcomingEvents = (List<Event>) request.getAttribute("upcomingEvents");
            if (upcomingEvents != null && !upcomingEvents.isEmpty()) {
                for (Event event : upcomingEvents) {
        %>
        <div class="event-card">
            <div class="event-title"><%= event.getEventName() %></div>
            <div class="event-description"><%= event.getDescription() %></div>
            <p><strong>Date:</strong> <%= event.getEventDate() %></p>
            <p><strong>Venue:</strong> <%= event.getVenue() %></p>
            <p><strong>CoordinatorName:</strong> <%= event.getCoordinatorName() %></p>
            <p><strong>CoordinatorContact:</strong> <%= event.getCoordinatorPhone() %></p>
            <div class="btn-group">
                <form action="BookTicketServlet" method="post">
                    <input type="hidden" name="event_id" value="<%= event.getEventId() %>">
       
                </form>
            </div>
        </div>
        <%      }
            } else {
        %>
        <p>No upcoming events available at the moment.</p>
        <% } %>
    </div>

    <!-- Attended Events Section -->
    <h3>✅ Previous Events</h3>
    <div class="event-grid">
        <%
            List<Event> attendedEvents = (List<Event>) request.getAttribute("previousEvents");
            if (attendedEvents != null && !attendedEvents.isEmpty()) {
                for (Event event : attendedEvents) {
        %>
        <div class="event-card">
            <div class="event-title"><%= event.getEventName() %></div>
            <div class="event-description"><%= event.getDescription() %></div>
            <p><strong>Date:</strong> <%= event.getEventDate() %></p>
            <p><strong>Venue:</strong> <%= event.getVenue() %></p>
            <p><strong>CoordinatorName:</strong> <%= event.getCoordinatorName() %></p>
            <p><strong>CoordinatorContact:</strong> <%= event.getCoordinatorPhone() %></p>
            <div class="btn-group">
               <form onsubmit="return submitFeedback(this, <%= event.getEventId() %>)" enctype="application/x-www-form-urlencoded">
    				<input type="hidden" name="event_id" value="<%= event.getEventId() %>">
    				<textarea name="feedback_text" rows="2" cols="25" placeholder="Your feedback..." required></textarea>
    				<br><br>
    				<button class="btn btn-feedback" type="submit">Give Feedback</button>
				</form>
				<div id="feedback-response-<%= event.getEventId() %>"></div>
            </div>
        </div>
        <%      }
            } else {
        %>
        <p>You haven’t attended any events yet or already submitted feedback.</p>
        <% } %>
    </div>
</div>

<footer>
    © 2025 EventSphere. All rights reserved.
</footer>

<script>
function submitFeedback(form, eventId) {
    const feedbackText = form.querySelector('textarea[name="feedback_text"]').value;
    const eventIdValue = form.querySelector('input[name="event_id"]').value;

    const params = new URLSearchParams();
    params.append("feedback_text", feedbackText);
    params.append("event_id", eventIdValue);

    fetch('SubmitFeedbackServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params
    })
    .then(res => res.text())
    .then(responseText => {
        document.getElementById("feedback-response-" + eventId).innerHTML = responseText;
        form.reset();
    })
    .catch(err => {
        console.error("Error submitting feedback:", err);
    });

    return false; // prevent default form submission
}

</script>

</body>
</html>
