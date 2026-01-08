<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | EventSphere</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: #f5f5f5;
        }

        .header {
            background: #5e17eb;
            color: white;
            padding: 25px 0;
            text-align: center;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 40px auto;
            padding: 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        h1, h2 {
            margin: 0 0 20px;
        }

        p {
            font-size: 16px;
            line-height: 1.7;
            color: #444;
        }

        .footer {
            background: #8B5CF6;
            color: white;
            text-align: center;
            padding: 18px;
            margin-top: 40px;
        }

        a {
            color: #fff;
            font-weight: 600;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="header">
    <h1>About EventSphere</h1>
</div>

<div class="container">
    <h2>What is EventSphere?</h2>
    <p>
        EventSphere is an internal event management platform developed exclusively for 
        <strong>St. Andrews Institute of Technology & Management, Gurgaon</strong>.
        This platform is created to simplify how students, faculty, and event organizers manage 
        and participate in college events.
    </p>

    <h2>Why We Built This</h2>
    <p>
        In most colleges, event details are scattered — WhatsApp groups, posters, multiple announcements.
        EventSphere solves this by offering a single digital platform where students can:
        <br><br>
        ✔ View all upcoming & ongoing events<br>
        ✔ Get event details in one place<br>
        ✔ Give feedback for past events<br>
        ✔ Stay updated with college activities<br>
    </p>

    <h2>For Organizers & Admins</h2>
    <p>
        EventSphere helps faculty coordinators and student organizers:
        <br><br>
        ✔ Add and manage events easily<br>
        ✔ Assign tasks to volunteers<br>
        ✔ Track feedback and engagement<br>
        ✔ Reduce workload and improve communication<br>
    </p>

    <h2>Who Created This?</h2>
    <p>
        This project is designed and developed by 
        <strong>Nikhil Kumar (CSE Department)</strong> for college use.
        The aim is to create a smooth, user-friendly system that enhances the way events are managed on campus.
    </p>

    <h2>Goal</h2>
    <p>
        The goal of EventSphere is simple — to bring all college events on one platform and make 
        the experience better for students, volunteers, and administrators.
    </p>
</div>

<div class="footer">
    <p>© <%= java.time.Year.now() %> EventSphere | Developed for SAITM</p>
    <p><a href="index.jsp">Back to Home</a></p>
</div>

</body>
</html>
