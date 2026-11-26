<%@ page import="java.util.*" %>

    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
    <style>
        /* DAM WALE EFFECTS - NEON CYBERPUNK THEME */
        body {
          
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #fff;
            background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)), url('https://wallpaperaccess.com/full/9331576.jpg') no-repeat center center/cover fixed;
            
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
        }

        .flight-row {
            border: 1px solid rgba(255, 0, 234, 0.3);
            margin: 20px 0;
            padding: 25px;
            background: rgba(15, 15, 15, 0.8);
            backdrop-filter: blur(10px); /* Glassmorphism effect */
            border-radius: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            
        }

        /* Hover karne pe glow aayega */
        .flight-row:hover {
            border-color: #ff00ea;
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 0 25px rgba(255, 0, 234, 0.4);
        }

        .flight-info {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .flight-name {
            font-size: 22px;
            color: #ff00ea;
            text-shadow: 0 0 10px rgba(255, 0, 234, 0.5);
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .route {
            color: #00f2ff;
            font-size: 14px;
            font-weight: bold;
        }

        .details {
            font-size: 13px;
            color: #bbb;
        }

        /* DAM WALA BUTTON */
        .btn-reserve {
            background: linear-gradient(45deg, #ff00ea, #8a00ff);
            color: #fff;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            text-transform: uppercase;
            cursor: pointer;
            transition: 0.3s;
            box-shadow: 0 0 15px rgba(255, 0, 234, 0.5);
        }

        .btn-reserve:hover {
            box-shadow: 0 0 30px #ff00ea;
            letter-spacing: 2px;
        }

        .btn-disabled {
            background: #222;
            color: #555;
            padding: 12px 25px;
            border: 1px solid #333;
            border-radius: 8px;
            cursor: not-allowed;
        }

        .seats-tag {
            font-size: 12px;
            padding: 4px 10px;
            border-radius: 20px;
            background: rgba(0, 255, 0, 0.1);
            border: 1px solid #00ff00;
        }

        .sold-tag {
            font-size: 12px;
            padding: 4px 10px;
            border-radius: 20px;
            background: rgba(255, 0, 0, 0.1);
            border: 1px solid #ff0000;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 style="text-align:center; color:#00f2ff; text-shadow: 0 0 20px #00f2ff55; margin-bottom:40px;"> ✈️ SKYPRO HANGAR </h1>
    
    <% 
    List<Map<String, String>> flights = (List)request.getAttribute("allFlights");
    if(flights != null) {
        for(Map<String, String> f : flights) { 
            int seats = Integer.parseInt(f.get("seats"));
    %>
    <div class="flight-row">
        <div class="flight-info">
            <span class="flight-name"><%= f.get("name") %></span>
            <span class="route"><%= f.get("source") %> <span style="color:#fff;">➔</span> <%= f.get("dest") %></span>
            <span class="details">Departure: <b style="color:#fff;"><%= f.get("time") %></b> | Price: <b style="color:#00ff00;">₹<%= f.get("price") %></b></span>
        </div>
        
        <div style="text-align: right;">
            <div style="margin-bottom: 10px;">
                <% if(seats > 0) { %>
                    <span class="seats-tag" style="color:#00ff00;"><%= seats %> SLOTS LEFT</span>
                <% } else { %>
                    <span class="sold-tag" style="color:#ff4d4d;">GRID FULL</span>
                <% } %>
            </div>

            <% if(seats > 0) { %>
                <a href="flight/booking.jsp?fid=<%= f.get("id") %>" style="text-decoration:none;">
                    <button class="btn-reserve">RESERVE NOW</button>
                </a>
            <% } else { %>
                <button class="btn-disabled" disabled>SOLD OUT</button>
            <% } %>
        </div>
    </div>
    <% 
        } 
    } else { %>
        <p style="text-align:center; color:#666;">No expeditions found in the database.</p>
    <% } %>
</div>

</body>
</html>