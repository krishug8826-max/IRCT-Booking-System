<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SKYPRO | FLIGHT TERMINAL</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root { --accent: #ff00ea; --neon: #00f2ff; --bg: #050505; }
        
        * { box-sizing: border-box; } /* Layout fix karne ke liye */

        body { 
            background: var(--bg); color: white; font-family: 'Poppins', sans-serif; 
            padding: 20px; margin: 0; min-height: 100vh;
        }

        .terminal-title { 
            text-align: center; font-family: 'Orbitron'; color: var(--accent); 
            letter-spacing: 3px; margin: 30px 0; text-shadow: 0 0 15px var(--accent);
            font-size: clamp(18px, 5vw, 32px); /* Font size screen ke hisab se */
        }
        
        .ticket-container { 
            display: flex; flex-direction: column; align-items: center; gap: 25px; 
            width: 100%; max-width: 800px; margin: 0 auto; 
        }
        
        .ticket-card {
            width: 100%; /* Fixed width hatakar 100% kar diya */
            background: rgba(255, 255, 255, 0.02);
            border: 2px solid var(--accent); border-radius: 20px;
            display: flex; flex-wrap: wrap; /* Mobile pe niche shift hone ke liye */
            overflow: hidden; position: relative;
            box-shadow: 0 0 25px rgba(255, 0, 234, 0.15);
        }
        
        .ticket-main { 
            flex: 1 1 400px; padding: 25px; 
            border-right: 2px dashed rgba(255, 0, 234, 0.5); 
        }

        .ticket-stub { 
            flex: 1 1 200px; padding: 25px; 
            background: rgba(255, 0, 234, 0.05); text-align: center; 
            display: flex; flex-direction: column; justify-content: center; 
        }
        
        .flight-id { font-family: 'Orbitron'; font-size: 22px; color: white; margin-bottom: 5px; }
        .manifest-id { font-size: 10px; color: var(--accent); font-family: 'Orbitron'; }
        
        .details-grid { 
            display: grid; grid-template-columns: repeat(auto-fit, minmax(140px, 1fr)); 
            gap: 15px; margin-top: 25px; 
        }

        .label { font-size: 9px; color: var(--neon); font-family: 'Orbitron'; letter-spacing: 1px; }
        .value { font-size: 14px; font-weight: 600; text-transform: uppercase; }
        
        .barcode { width: 100%; height: 40px; background: repeating-linear-gradient(90deg, #fff, #fff 2px, transparent 2px, transparent 4px); margin-top: 20px; opacity: 0.7; }
        
        .seat-highlight { font-family: 'Orbitron'; font-size: clamp(25px, 6vw, 40px); color: var(--accent); text-shadow: 0 0 10px var(--accent); }
        .boarding-status { font-size: 9px; color: #00ff88; font-family: 'Orbitron'; margin-top: 10px; }
        
        /* Mobile View Fix */
        @media (max-width: 600px) {
            .ticket-main { border-right: none; border-bottom: 2px dashed rgba(255, 0, 234, 0.5); }
            .ticket-card { border-radius: 15px; }
            body { padding: 10px; }
        }

        .btn-back {
            display: inline-block; margin-top: 40px; color: var(--neon); 
            text-decoration: none; font-family: 'Orbitron'; font-size: 12px;
            padding: 10px 20px; border: 1px solid var(--neon); border-radius: 5px;
            transition: 0.3s;
        }
        .btn-back:hover { background: var(--neon); color: black; box-shadow: 0 0 15px var(--neon); }
    </style>
</head>
<body>

    <h1 class="terminal-title">SKYPRO FLIGHT TERMINAL</h1>

    <div class="ticket-container">
        <% 
            List<Map<String, String>> tickets = (List<Map<String, String>>) request.getAttribute("tickets");
            if(tickets != null && !tickets.isEmpty()) {
                for(Map<String, String> t : tickets) {
        %>
            <div class="ticket-card">
                <div class="ticket-main">
                    <div class="flight-id"><%= t.get("flight_name") %></div>
                    <div class="manifest-id">MANIFEST ID: #<%= t.get("res_id") %></div>
                    
                    <div class="details-grid">
                        <div>
                            <div class="label">COMMANDER / PASSENGER</div>
                            <div class="value"><%= t.get("passenger") %></div>
                        </div>
                        <div>
                            <div class="label">VESSEL (FLIGHT)</div>
                            <div class="value">SKYPRO-X1</div>
                        </div>
                    </div>
                    
                    <div class="barcode"></div>
                </div>
                
                <div class="ticket-stub">
                    <div class="label">DOCKING GATE</div>
                    <div class="value" style="margin-bottom: 10px;">G-24</div>
                    
                    <div class="label">ASSIGNED SEAT</div>
                    <div class="seat-highlight"><%= t.get("seat") %></div>
                    
                    <div class="boarding-status">● SYSTEM READY</div>
                </div>
            </div>
        <%      } 
            } else { %>
                <div class="no-data" style="text-align: center; margin-top: 50px;">
                    <p style="font-family: 'Orbitron'; color: #555;">NO ACTIVE FLIGHT MANIFESTS FOUND</p>
                </div>
        <%  } %>
    </div>

    <div style="text-align: center; margin-bottom: 50px;">
        <a href="flight/dashboard.jsp" class="btn-back">← RETURN TO COMMAND CENTRE</a>
    </div>

</body>
</html>