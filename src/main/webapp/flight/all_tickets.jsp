<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>SKYPRO | MISSION LOGS</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Poppins:wght@300;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --accent: #ff00ea; --neon: #00f2ff; --card-bg: rgba(15, 10, 25, 0.95); }
        body { background: #050505; color: white; font-family: 'Poppins', sans-serif; padding: 40px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .header h1 { font-family: 'Orbitron'; color: var(--accent); letter-spacing: 4px; margin: 0; }

        .ticket-card {
            background: var(--card-bg); border-radius: 20px; margin-bottom: 25px;
            display: flex; border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 10px 30px rgba(0,0,0,0.5); position: relative;
        }
        .ticket-main { flex: 3; padding: 30px; border-right: 2px dashed #333; }
        .ticket-stub { flex: 1; padding: 30px; background: rgba(255, 0, 234, 0.03); display: flex; flex-direction: column; justify-content: center; align-items: center; }

        .route { display: flex; align-items: center; gap: 25px; margin-bottom: 25px; }
        .city { font-family: 'Orbitron'; font-size: 24px; color: var(--neon); }
        .plane-icon { color: var(--accent); font-size: 22px; }

        .info-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .label { font-size: 10px; color: #777; text-transform: uppercase; font-family: 'Orbitron'; margin-bottom: 5px; }
        .val { font-size: 15px; font-weight: 600; color: #eee; }

        .seat-box { 
            background: var(--accent); color: white; padding: 12px 25px; 
            border-radius: 12px; font-family: 'Orbitron'; font-size: 22px;
            box-shadow: 0 0 20px var(--accent); margin-bottom: 10px;
        }
        
        .qr-code { margin-top: 15px; filter: invert(1); border: 5px solid white; border-radius: 5px; }
        .no-tickets { text-align: center; padding: 100px; font-family: 'Orbitron'; color: #444; }
    </style>
</head>
<body>

    <div class="header">
        <h1>BOARDING PASS LOG</h1>
        <button onclick="window.print()" style="background:none; border:1px solid var(--neon); color:var(--neon); padding:10px 20px; cursor:pointer; font-family:'Orbitron';">
            <i class="fas fa-print"></i> PRINT ARCHIVE
        </button>
    </div>

    <%
        List<Map<String, String>> tickets = (List<Map<String, String>>) request.getAttribute("userTickets");
        if(tickets != null && !tickets.isEmpty()) {
            for(Map<String, String> t : tickets) {
    %>
        <div class="ticket-card">
            <div class="ticket-main">
                <div class="route">
                    <span class="city"><%= t.get("from") %></span>
                    <i class="fas fa-plane-departure plane-icon"></i>
                    <span class="city"><%= t.get("to") %></span>
                </div>
                
                <div class="info-grid">
                    <div>
                        <div class="label">Passenger</div>
                        <div class="val"><%= t.get("p_name") %></div>
                    </div>
                    <div>
                        <div class="label">Airline</div>
                        <div class="val"><%= t.get("airline") %></div>
                    </div>
                    <div>
                        <div class="label">Mission ID</div>
                        <div class="val" style="color:var(--accent);">#TKT-<%= t.get("id") %></div>
                    </div>
                    <div>
                        <div class="label">Logged At</div>
                        <div class="val"><%= t.get("time") %></div>
                    </div>
                    <div>
                        <div class="label">Terminal</div>
                        <div class="val">SKY-T3</div>
                    </div>
                    <div>
                        <div class="label">Status</div>
                        <div class="val" style="color:#00ff00;">● CONFIRMED</div>
                    </div>
                </div>
            </div>
            
            <div class="ticket-stub">
                <div class="label">Assigned Seat</div>
                <div class="seat-box"><%= t.get("seat") %></div>
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=70x70&data=SKY-<%= t.get("id") %>" class="qr-code">
            </div>
        </div>
    <% 
            }
        } else {
    %>
        <div class="no-tickets">
            <i class="fas fa-satellite-dish" style="font-size:40px; margin-bottom:20px;"></i>
            <p>NO ACTIVE MISSIONS FOUND</p>
        </div>
    <% } %>

</body>
</html>