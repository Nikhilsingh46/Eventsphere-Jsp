<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Register - EventSphere</title>
  <link rel="stylesheet" href="css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #dbeafe, #e0f2fe);
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .register-container {
      background: white;
      padding: 40px;
      border-radius: 20px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 450px;
      text-align: center;
    }

    .register-container h1 {
      margin-bottom: 30px;
      font-size: 28px;
      color: #1f1f1f;
    }

    .register-container input {
      width: 100%;
      padding: 12px 15px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 10px;
      font-size: 15px;
    }

    .register-container button {
      margin-top: 20px;
      width: 100%;
      background-color: #1e40af;
      color: white;
      padding: 12px;
      border: none;
      border-radius: 10px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .register-container button:hover {
      background-color: #1c3faa;
    }

    .register-container p {
      margin-top: 15px;
      font-size: 14px;
    }

    .register-container a {
      color: #1e40af;
      text-decoration: none;
    }

    .register-container a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <div class="register-container">
    <h1>Create Your Account</h1>
    
      <% 
            String msg = request.getParameter("msg");
            String error = request.getParameter("error");
            if ("registered".equals(msg)) {
        %>
            <p class="message">Registration successful! Please login.</p>
        <% } else if ("fail".equals(error)) { %>
            <p class="error">Registration failed. Try again.</p>
        <% } else if ("exception".equals(error)) { %>
            <p class="error">An error occurred during registration.</p>
        <% } %>
        
    <form action="register" method="post">
      <input type="text" name="fullname" placeholder="Full Name" required />
      <input type="email" name="email" placeholder="Email" required />
      <input type="password" name="password" placeholder="Password" required />
         <input type="text" name="college" placeholder="College Name" required />
      <button type="submit">Register</button>
    </form>
    <p>Already have an account? <a href="login.jsp">Login here</a></p>
  </div>

</body>
</html>
