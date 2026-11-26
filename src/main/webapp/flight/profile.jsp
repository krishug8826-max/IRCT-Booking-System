<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Agar session nahi hai toh seedha login pe fenko
    if (session.getAttribute("user_email") == null) {
        response.sendRedirect("login.html");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>SKYPRO | PROFILE</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root { --accent: #ff00ea; --neon: #00f2ff; --bg: #0d0d12; }
        body { background: var(--bg); color: white; font-family: 'Poppins', sans-serif; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0;}
        .profile-card { background: #15151e; width: 480px; padding: 40px; border-radius: 30px; border: 2px solid var(--accent); box-shadow: 0 0 40px rgba(255, 0, 234, 0.2); text-align: center; }
        .avatar { width: 80px; height: 80px; border-radius: 50%; border: 3px solid var(--neon); margin: 0 auto 20px; display: flex; align-items: center; justify-content: center; font-size: 35px; 
        font-family: 'Orbitron'; color: var(--neon); box-shadow: 0 0 20px var(--neon); }
        .input-group { text-align: left; margin-bottom: 20px; }
        label { font-family: 'Orbitron'; font-size: 10px; color: var(--neon); letter-spacing: 2px; display: block; margin-bottom: 8px; }
        input { width: 100%; padding: 14px; background: rgba(255,255,255,0.05); border: 1px solid #333; border-radius: 12px; color: white; outline: none; box-sizing: border-box; }
        .btn-update { width: 100%; padding: 18px; background: var(--accent); border: none; border-radius: 15px; color: white; font-family: 'Orbitron'; cursor: pointer; transition: 0.3s; letter-spacing: 2px; }
        .btn-update:hover { box-shadow: 0 0 30px var(--accent); transform: scale(1.02); }
        .status-msg { color: #00ff00; font-family: 'Orbitron'; font-size: 10px; margin-bottom: 20px; }
    </style>
</head>
<body>
<div class="profile-card">
    <div class="avatar"><%= ((String)request.getAttribute("u_name")).substring(0,1).toUpperCase() %></div>
    <h2 style="font-family:'Orbitron'; color:var(--accent); margin-bottom: 5px;">PILOT PROFILE</h2>
    
    <% if(request.getAttribute("msg") != null) { %>
        <div class="status-msg">● <%= request.getAttribute("msg") %></div>
    <% } %>

    <form action="UpdateProfile" method="POST">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
            <div class="input-group">
                <label>FIRST NAME</label>
                <input type="text" name="fname" value="<%= request.getAttribute("fname") %>" required>
            </div>
            <div class="input-group">
                <label>LAST NAME</label>
                <input type="text" name="lname" value="<%= request.getAttribute("lname") %>" required>
            </div>
        </div>
        <div class="input-group">
            <label>CORE EMAIL</label>
            <input type="email" name="email" value="<%= request.getAttribute("u_email") %>" readonly style="color:#555;">
        </div>
        <div class="input-group">
            <label>CONTACT PHONE</label>
            <input type="text" name="phone" value="<%= request.getAttribute("u_phone") %>" required>
        </div>
        <button type="submit" class="btn-update">SYNC PROFILE DATA</button>
    </form>
    <a href="flight/dashboard.jsp" style="display:block; margin-top:20px; color:#666; text-decoration:none; font-size:11px; font-family:'Orbitron';">← RETURN TO HANGAR</a>
</div>
</body>
</html>