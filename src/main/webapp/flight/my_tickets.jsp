<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>SKYPRO | MY TICKETS</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root { --accent: #ff00ea; --neon: #00f2ff; --bg: #0d0d12; }
        body { background: var(--bg); color: white; font-family: 'Poppins', sans-serif; margin: 0; padding: 20px; 
        		 background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)), url('https://wallpaperaccess.com/full/15742552.jpg') no-repeat center center/cover fixed;}
        
        .header { text-align: center; margin-bottom: 40px; }
        .header h1 { font-family: 'Orbitron'; color: var(--accent); text-transform: uppercase; letter-spacing: 4px; text-shadow: 0 0 15px var(--accent); }

        .ticket-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 25px; max-width: 1200px; margin: 0 auto; }

        /* DAM WALA TICKET CARD */
        .ticket-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 0, 234, 0.3);
            border-radius: 20px;
            padding: 20px;
            position: relative;
            overflow: hidden;
            transition: 0.3s;
            backdrop-filter: blur(10px);
        }

        .ticket-card:hover {
            transform: translateY(-5px);
            border-color: var(--accent);
            box-shadow: 0 0 25px rgba(255, 0, 234, 0.2);
        }

        .ticket-id { font-family: 'Orbitron'; font-size: 10px; color: var(--neon); margin-bottom: 10px; }
        .flight-name { font-size: 20px; font-weight: bold; color: #fff; margin-bottom: 5px; }
        .route { font-size: 14px; color: #bbb; margin-bottom: 15px; }
        
        .details-row { display: flex; justify-content: space-between; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 15px; }
        .detail-item { display: flex; flex-direction: column; }
        .label { font-size: 9px; text-transform: uppercase; color: var(--neon); font-family: 'Orbitron'; }
        .value { font-size: 14px; font-weight: 600; }

        .seat-badge {
            position: absolute; top: 20px; right: 20px;
            background: var(--accent); color: white;
            padding: 5px 12px; border-radius: 8px;
            font-family: 'Orbitron'; font-size: 12px;
            box-shadow: 0 0 10px var(--accent);
        }

        .status { margin-top: 15px; font-size: 10px; color: #00ff00; font-weight: bold; text-transform: uppercase; letter-spacing: 1px; }
    </style>
</head>
<body>

    <div class="header">
        <h1>Active Manifests</h1>
        <p style="color: #666;">Clearance Level: Alpha-9</p>
         <button onclick="window.print()" style="background:none; border:1px solid var(--neon); color:var(--neon); padding:10px 20px; cursor:pointer; font-family:'Orbitron';">
            <i class="fas fa-print"></i> PRINT ARCHIVE
        </button>
    </div>

    <div class="ticket-grid">
        <% 
        List<Map<String, String>> tickets = (List)request.getAttribute("myTickets");
        if(tickets != null && !tickets.isEmpty()) {
            for(Map<String, String> t : tickets) { 
        %>
            <div class="ticket-card">
                <div class="ticket-id">RES-ID: #<%= t.get("res_id") %></div>
                <div class="seat-badge">SEAT <%= t.get("seat") %></div>
                
                <div class="flight-name"><%= t.get("f_name") %></div>
                <div class="route"><%= t.get("source") %> ➔ <%= t.get("dest") %></div>
                
                <div class="details-row">
                    <div class="detail-item">
                        <span class="label">Passenger</span>
                        <span class="value"><%= t.get("passenger") %></span>
                    </div>
                    <div class="detail-item" style="text-align: right;">
                        <span class="label">Departure</span>
                        <span class="value"><%= t.get("time") %></span>
                    </div>
                </div>
                
                <div class="status">● System Confirmed</div>
            </div>
        <% 
            }
        } else { 
        %>
            <div style="grid-column: 1/-1; text-align: center; padding: 50px; border: 1px dashed #333; border-radius: 20px;">
                <p style="color: #555; font-family: 'Orbitron';">NO DATA DETECTED IN YOUR CLEARANCE ZONE</p>
                <a href="AllFlights" style="color: var(--neon); text-decoration: none; font-size: 12px;">Initiate New Booking ➔</a>
            </div>
        <% } %>
    </div>

    <div style="text-align: center; margin-top: 40px;">
        <a href="flight/dashboard.jsp" style="color: #666; text-decoration: none; font-size: 12px;">← Back to Command Center</a>
    </div>

</body>
</html>