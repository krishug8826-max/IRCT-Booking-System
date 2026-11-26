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
    <title>SKYPRO | SECURE RESERVATION</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700;900&family=Rajdhani:wght@500;700&display=swap" rel="stylesheet">
    
    <style>
        :root { 
            --accent: #ff00ea; 
            --neon: #00f2ff; 
            --dark: #050505;
            --glass: rgba(20, 20, 30, 0.85);
        }

        body { 
            background: url('https://img.freepik.com/free-vector/dark-hexagonal-background-with-gradient-color_79603-1409.jpg') no-repeat center center fixed; /* Optional Texture */
            background-color: var(--dark);
            background-size: cover;
            color: white; 
            font-family: 'Rajdhani', sans-serif; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh;
            margin: 0;
        }

        /* DAM WALA CARD */
        .booking-card { 
            background: var(--glass);
            backdrop-filter: blur(15px); /* Blurry Glass Effect */
            padding: 40px; 
            border-radius: 20px; 
            border: 1px solid rgba(255, 0, 234, 0.3); 
            width: 480px; 
            box-shadow: 0 0 50px rgba(255, 0, 234, 0.15), inset 0 0 20px rgba(0,0,0,0.8);
            position: relative;
            overflow: hidden;
        }

        /* Top Neon Bar */
        .booking-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon), var(--accent));
            box-shadow: 0 0 15px var(--accent);
        }

        h2 { 
            font-family: 'Orbitron'; 
            color: #fff; 
            text-align: center; 
            margin-bottom: 30px; 
            letter-spacing: 3px;
            text-transform: uppercase;
            text-shadow: 0 0 10px var(--accent);
        }

        label { 
            display: block; 
            font-size: 12px; 
            color: var(--neon); 
            font-family: 'Orbitron'; 
            margin-bottom: 8px; 
            letter-spacing: 1px;
        }

        /* INPUT FIELDS with GLOW */
        input { 
            width: 100%; 
            padding: 15px; 
            background: rgba(0, 0, 0, 0.6); 
            border: 1px solid #333; 
            border-left: 3px solid #555;
            border-radius: 5px; 
            color: white; 
            font-family: 'Rajdhani'; 
            font-size: 18px; 
            outline: none; 
            box-sizing: border-box; 
            transition: all 0.3s ease;
        }

        input:focus { 
            border-color: var(--neon); 
            border-left-color: var(--accent);
            box-shadow: 0 0 15px rgba(0, 242, 255, 0.3);
            background: rgba(0, 242, 255, 0.05);
        }

        /* Dynamic Passenger Box Styling */
        .passenger-box { 
            background: rgba(255, 255, 255, 0.03);
            border: 1px dashed rgba(255, 0, 234, 0.3);
            padding: 15px; 
            border-radius: 8px; 
            margin-bottom: 15px; 
            animation: slideIn 0.4s ease-out;
            position: relative;
        }
        
        .passenger-box::after {
            content: 'PASSENGER DATA';
            position: absolute;
            top: -8px; right: 10px;
            font-size: 9px;
            background: var(--dark);
            color: #666;
            padding: 0 5px;
            font-family: 'Orbitron';
        }

        /* BUTTON STYLE */
        .btn-confirm { 
            width: 100%; 
            padding: 18px; 
            margin-top: 20px;
            background: linear-gradient(45deg, var(--accent), #aa00cc); 
            border: none; 
            border-radius: 5px; 
            color: white; 
            font-family: 'Orbitron'; 
            font-weight: 900;
            font-size: 16px;
            cursor: pointer; 
            text-transform: uppercase;
            letter-spacing: 2px;
            box-shadow: 0 0 20px rgba(255, 0, 234, 0.4);
            transition: 0.3s;
            position: relative;
            overflow: hidden;
        }

        .btn-confirm:hover { 
            transform: scale(1.02);
            box-shadow: 0 0 40px var(--accent);
        }

        .btn-confirm::after {
            content: '';
            position: absolute;
            top: 0; left: -100%;
            width: 100%; height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: 0.5s;
        }
        
        .btn-confirm:hover::after {
            left: 100%;
        }

        /* Layout Utilities */
        .row-inputs { display: flex; gap: 10px; }
        .row-inputs input { width: 100%; }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="booking-card">
        <h2>Initiate Booking</h2>
        
        <form action="../ConfirmBooking" method="POST">
            <input type="hidden" name="flight_id" value="<%= request.getParameter("fid") %>">
            
            <div style="margin-bottom: 20px;">
                <label>SEAT CONFIGURATION (Max 5)</label>
                <input type="number" id="sc" name="seat_count" min="1" max="5" value="1" onchange="addFields()" onkeyup="addFields()">
            </div>
            
            <div id="p_container">
                <div class="passenger-box">
                    <div class="row-inputs">
                        <div style="flex: 2;">
                            <label>PASSENGER 1 NAME</label>
                            <input type="text" name="p_name" placeholder="E.g. ROGER" required>
                        </div>
                        <div style="flex: 1;">
                            <label>AGE</label>
                            <input type="number" name="p_age" placeholder="25" required>
                        </div>
                    </div>
                </div>
            </div>

            <div style="margin-top: 25px;">
                <label>CONTACT UPLINK (EMAIL)</label>
                <input type="email" name="u_email" 
                       value="<%= (session.getAttribute("user_email") != null) ? session.getAttribute("user_email") : "" %>" 
                       style="border-color: #333; color: #aaa;" readonly>
            </div>

            <button type="submit" class="btn-confirm">CONFIRM & AUTO-ALLOT</button>
        </form>
    </div>

<script>
function addFields(){
    let n = document.getElementById("sc").value;
    // Limit to 5 strictly
    if(n > 5) { n = 5; document.getElementById("sc").value = 5; }
    if(n < 1) { n = 1; document.getElementById("sc").value = 1; }

    let container = document.getElementById("p_container");
    container.innerHTML = "";
    
    for(let i=1; i<=n; i++){
        // Using backticks for cleaner HTML injection matching the CSS style
        container.innerHTML += `
            <div class="passenger-box">
                <div class="row-inputs">
                    <div style="flex: 2;">
                        <label>PASSENGER ${i} NAME</label>
                        <input type="text" name="p_name" placeholder="FULL NAME" required>
                    </div>
                    <div style="flex: 1;">
                        <label>AGE</label>
                        <input type="number" name="p_age" placeholder="18+" required>
                    </div>
                </div>
            </div>`;
    }
}
</script>

</body>
</html>