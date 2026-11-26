<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 1. Check karna ki user login hai ya nahi
    String loggedInUser = (String) session.getAttribute("user"); 
    
    if(loggedInUser == null) {
        // Agar login nahi hai toh login page par bhej do
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings - Voyage Pro</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&family=Poppins:wght@300;400;600&display=swap');
        body { background: #020205; font-family: 'Poppins', sans-serif; color: white; padding: 40px; }
        .ticket-list { display: flex; flex-direction: column; gap: 25px; align-items: center; }
        
        .ticket { 
            display: flex; width: 850px; background: #0a0f19; border-radius: 15px; 
            border: 1px solid rgba(0, 242, 255, 0.3); overflow: hidden;
            box-shadow: 0 0 20px rgba(0,242,255,0.1);
        }
        .pnr-side { 
            background: linear-gradient(135deg, #ff00ea, #7000ff); 
            padding: 25px; min-width: 150px; text-align: center; 
            font-family: 'Orbitron'; display: flex; flex-direction: column; justify-content: center;
        }
        .main-info { padding: 25px; flex-grow: 1; display: grid; grid-template-columns: 1.5fr 1fr 1fr; gap: 15px; }
        .label { color: #00f2ff; font-size: 0.7rem; font-family: 'Orbitron'; letter-spacing: 1px; }
        .val { font-size: 1.1rem; font-weight: 600; margin-top: 5px; }
    </style>
</head>
<body>

<h2 style="text-align:center; font-family:'Orbitron'; color:#ff00ea;">WELCOME, <%= loggedInUser.toUpperCase() %></h2>
<p style="text-align:center; color:#888;">Showing your personal travel history</p>

<div class="ticket-list">
    <%
    try {
        Class.forName("org.postgresql.Driver");
        String dbUrl = System.getenv("DB_URL");
        String dbUser = System.getenv("DB_USER");
        String dbPassword = System.getenv("DB_PASSWORD");
        if (dbUrl == null || dbUser == null || dbPassword == null) throw new SQLException("Database environment variables are missing.");
        Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        
        // 2. Query mein WHERE clause lagaya hai (p_name = loggedInUser)
        // Note: Yahan 'p_name' tumhari table ka column hai jo photo mein dikha tha
        String sql = "SELECT * FROM bookings WHERE p_name = ? ORDER BY pnr DESC";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, loggedInUser);
        
        ResultSet rs = ps.executeQuery();
        boolean found = false;

        while(rs.next()) {
            found = true;
    %>
    <div class="ticket">
        <div class="pnr-side">
            <div style="font-size: 0.7rem;">PNR</div>
            <div style="font-size: 1.4rem; font-weight:bold;"><%= rs.getString("PNR") %></div>
            <div style="margin-top:10px; font-size:0.7rem; border:1px solid white; border-radius:10px;"><%= rs.getString("STATUS") %></div>
        </div>
        
        <div class="main-info">
            <div>
                <div class="label">PASSENGER</div>
                <div class="val"><%= rs.getString("P_NAME") %></div>
            </div>
            <div>
                <div class="label">TRAIN</div>
                <div class="val"><%= rs.getString("T_NAME") %></div>
                <div style="color:#ff00ea; font-size:0.8rem;">#<%= rs.getString("T_NO") %></div>
            </div>
            <div style="text-align: right;">
                <div class="label">SEAT / COACH</div>
                <div class="val"><%= rs.getString("COACH") %>-<%= rs.getString("SEAT_NO") %></div>
            </div>
        </div>
    </div>
    <%
        }
        if(!found) {
            out.println("<div style='margin-top:50px; text-align:center;'>");
            out.println("<h3>Bhai, abhi tak koi ticket book nahi ki tune!</h3>");
            out.println("<a href='all_trains.jsp' style='color:#00f2ff;'>Book Now ➔</a></div>");
        }
        con.close();
    } catch(Exception e) { out.print("Error: " + e.getMessage()); }
    %>
</div>

</body>
</html>