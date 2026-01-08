<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>EventSphere</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

 body {
  font-family: 'Poppins', sans-serif;
  background: linear-gradient(135deg, #89f7fe, #66a6ff);
  background-size: 400% 400%;
  animation: gradientBG 12s ease infinite;
  color: #000;
}



    /* Header Section */
    .header {
      background: rgba(0, 0, 0, 0.4);
      backdrop-filter: blur(10px);
      padding: 20px 50px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      position: sticky;
      top: 0;
      z-index: 10;
    }

    .header div:first-child {
      font-size: 30px;
      font-weight: 700;
      background: linear-gradient(90deg, #FFD60A, #fff);
      background-clip: text;
      color: transparent;
      animation: shine 4s linear infinite;
      letter-spacing: 1px;
    }

    .header a {
      color: white;
      text-decoration: none;
      font-weight: 600;
      margin-left: 20px;
      transition: color 0.3s ease, transform 0.2s;
    }

    .header a:hover {
      color: #FFD60A;
      transform: scale(1.1);
    }

    /* Hero Section */
    .hero {
      height: 40vh;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      text-align: center;
      padding: 0 20px;
      animation: fadeSlide 1.2s ease-in-out;
    }

    .hero h1 {
      font-size: 54px;
      font-weight: 700;
      color: #1c1c1c;
      margin-bottom: 20px;
      text-shadow: 2px 2px 10px rgba(0,0,0,0.15);
    }

    .hero p {
      font-size: 18px;
      max-width: 600px;
      color: #333;
      margin-bottom: 40px;
      line-height: 1.6;
    }

    /* Buttons */
    .cta-buttons a {
      display: inline-block;
      margin: 0 15px;
      padding: 14px 36px;
      border-radius: 30px;
      font-size: 16px;
      background: linear-gradient(90deg, #FFD60A, #FFB703);
      color: #1c1c1c;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.3s ease;
      box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    }

    .cta-buttons a:hover {
      transform: scale(1.08);
      background: linear-gradient(90deg, #ffea00, #ffe14d);
      box-shadow: 0 6px 15px rgba(0,0,0,0.3);
    }

	/* Events Section */
.events-section {
    text-align: center;
    padding: 40px 20px;
  }
  .events-title {
    font-size: 32px;
    font-weight: bold;
    margin-bottom: 25px;
  }
  .events-container {
    display: flex;
    justify-content: center;
    gap: 25px;
    flex-wrap: wrap;
  }
  .event-box {
    width: 300px;
    padding: 20px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.15);
    transition: 0.3s;
  }
  .event-box:hover {
    transform: scale(1.05);
  }
  .event-box h3 {
    font-size: 20px;
    margin-bottom: 12px;
    color: #333;
  }
  .event-box p {
    font-size: 15px;
    color: #444;
    min-height: 70px;
  }
  .view-btn {
    display: inline-block;
    margin-top: 10px;
    padding: 10px 20px;
    border-radius: 25px;
    background: #FFB703;
    color: #000;
    font-weight: bold;
    text-decoration: none;
  }
  .view-btn:hover {
    background: #FFD60A;
  }
	
    /* Footer */
    .footer {
      background-color: #1c1c1c;
      color: white;
      text-align: center;
      padding: 20px;
      font-size: 14px;
      border-top: 3px solid transparent;
      border-image: linear-gradient(90deg, #FFB703, #FFD60A);
      border-image-slice: 1;
    }

    /* Animations */
    @keyframes gradientBG {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }

    @keyframes shine {
      0% { background-position: -200px; }
      100% { background-position: 200px; }
    }

    @keyframes fadeSlide {
      0% { opacity: 0; transform: translateY(30px); }
      100% { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>

<body>

<%@ page import="java.sql.*" %>

<%
    String url = "jdbc:mysql://localhost:3306/eventsphere";
    String user = "root";
    String pass = "Rnikhil24@";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, pass);

    java.sql.Date today = new java.sql.Date(System.currentTimeMillis());

    PreparedStatement pastStmt = conn.prepareStatement(
        "SELECT eventName, description FROM events WHERE event_date < ? ORDER BY event_date DESC LIMIT 1"
    );
    pastStmt.setDate(1, today);

    PreparedStatement todayStmt = conn.prepareStatement(
        "SELECT eventName, description FROM events WHERE event_date = ? LIMIT 1"
    );
    todayStmt.setDate(1, today);

    PreparedStatement upcomingStmt = conn.prepareStatement(
        "SELECT eventName, description FROM events WHERE event_date > ? ORDER BY event_date ASC LIMIT 1"
    );
    upcomingStmt.setDate(1, today);

    ResultSet pastEvent = pastStmt.executeQuery();
    ResultSet todayEvent = todayStmt.executeQuery();
    ResultSet upcomingEvent = upcomingStmt.executeQuery();
%>


  <!-- Header -->
  <div class="header">
    <div>EventSphere</div>
    <div>
   		<a href="About.jsp">About Us</a>
      <a href="login.jsp">Login</a>
      <a href="register.jsp">Register</a>
    </div>
  </div>

  <!-- Hero Section -->
  <div class="hero">
    <h1>Welcome to EventSphere</h1>
    <p>Your one-stop platform to explore and manage college events. Log in to get started!</p>
    <div class="cta-buttons">
      <a href="login.jsp">Login</a>
      <a href="register.jsp">Register</a>
    </div>
  </div>

	<!-- Events Section -->
<div class="events-section">
  <h2 class="events-title">Explore Events</h2>

  <div class="events-container">

    <!-- Past Event -->
    <div class="event-box">
      <h3>Past Event</h3>
      <p>
        <% if (pastEvent.next()) { %>
          <strong><%= pastEvent.getString("eventName") %></strong><br>
          <%= pastEvent.getString("description") %>
        <% } else { %>
          No past event available.
        <% } %>
      </p>
      <a href="login.jsp" class="view-btn">View More</a>
    </div>

    <!-- Today Event -->
    <div class="event-box">
      <h3>Today's Event</h3>
      <p>
        <% if (todayEvent.next()) { %>
          <strong><%= todayEvent.getString("eventName") %></strong><br>
          <%= todayEvent.getString("description") %>
        <% } else { %>
          No event today.
        <% } %>
      </p>
      <a href="login.jsp" class="view-btn">View More</a>
    </div>

    <!-- Upcoming Event -->
    <div class="event-box">
      <h3>Upcoming Event</h3>
      <p>
        <% if (upcomingEvent.next()) { %>
          <strong><%= upcomingEvent.getString("eventName") %></strong><br>
          <%= upcomingEvent.getString("description") %>
        <% } else { %>
          No upcoming event.
        <% } %>
      </p>
      <a href="login.jsp" class="view-btn">View More</a>
    </div>

  </div>
</div>
	
  <!-- Footer -->
  <div class="footer">
    © 2025 EventSphere. All rights reserved.
  </div>

</body>
</html>
