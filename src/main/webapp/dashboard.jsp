<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

// Session se 'user_name' nikalna
String name = (String) session.getAttribute("user_name");

// Agar login nahi kiya toh wapas bhej do
if (name == null) {
    response.sendRedirect("login.html");
    return; 
}
%>

<div class="auth-chip">
<i class="fa-solid fa-shield-halved" style="color:var(--primary)"></i>
IDENTIFIED: <%= name.toUpperCase() %> 
</div>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RAILPRO | COMMAND CENTER</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Rajdhani:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root { --primary: #00f2ff; --secondary: #ff00ea; --bg-dark: #020205; --card-bg: rgba(10, 15, 25, 0.8); }
        
        * { margin: 0; padding: 0; box-sizing: border-box; cursor: crosshair; }
        body { 
            background: var(--bg-dark); color: #fff; font-family: 'Rajdhani', sans-serif; 
            overflow-x: hidden; min-height: 100vh;
        }

        /* Scanline Effect */
        body::before {
            content: " "; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.25) 50%), 
                        linear-gradient(90deg, rgba(255, 0, 0, 0.06), rgba(0, 255, 0, 0.02), rgba(0, 0, 255, 0.06));
            background-size: 100% 2px, 3px 100%; z-index: 1000; pointer-events: none;
        }

        /* Hero Header */
        header {
            height: 120px; padding: 0 5%; display: flex; justify-content: space-between; align-items: center;
            border-bottom: 2px solid var(--primary); box-shadow: 0 0 20px rgba(0, 242, 255, 0.2);
            background: rgba(0,0,0,0.9); position: sticky; top: 0; z-index: 100;
        }

        .brand { display: flex; align-items: center; gap: 15px; }
        .logo-box {
            width: 60px; height: 60px; border: 2px solid var(--primary); border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            box-shadow: inset 0 0 10px var(--primary), 0 0 15px var(--primary);
            animation: pulse 2s infinite;
        }
        @keyframes pulse { 0% { opacity: 0.8; } 50% { opacity: 1; } 100% { opacity: 0.8; } }

        .brand-text h1 { font-family: 'Orbitron'; font-size: 28px; letter-spacing: 4px; color: #fff; }
        .brand-text span { color: var(--primary); font-size: 12px; display: block; letter-spacing: 2px; }

        .user-status { display: flex; align-items: center; gap: 20px; }
        .auth-chip {
            background: rgba(0, 242, 255, 0.1); border: 1px solid var(--primary);
            padding: 8px 20px; border-radius: 5px; font-family: 'Orbitron'; font-size: 12px;
        }
        .logout-ico { color: var(--secondary); font-size: 20px; transition: 0.3s; }
        .logout-ico:hover { transform: scale(1.2); text-shadow: 0 0 10px var(--secondary); }

        /* Dashboard Content */
        .main-stage { padding: 50px 5%; max-width: 1400px; margin: 0 auto; }
        
        .sys-info { margin-bottom: 40px; border-left: 4px solid var(--secondary); padding-left: 20px; }
        .sys-info h2 { font-family: 'Orbitron'; font-size: 35px; text-transform: uppercase; }
        .sys-info p { color: var(--primary); letter-spacing: 5px; font-weight: bold; }

        .tactical-grid {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px;
        }

        /* Glass Cards with Corner Borders */
        .t-card {
            background: var(--card-bg); border: 1px solid rgba(0, 242, 255, 0.1);
            height: 250px; position: relative; padding: 40px;
            transition: 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: flex; flex-direction: column; justify-content: center; align-items: center;
            text-decoration: none; backdrop-filter: blur(10px);
        }

        .t-card::before, .t-card::after {
            content: ''; position: absolute; width: 20px; height: 20px; transition: 0.3s;
        }
        .t-card::before { top: -2px; left: -2px; border-top: 3px solid var(--primary); border-left: 3px solid var(--primary); }
        .t-card::after { bottom: -2px; right: -2px; border-bottom: 3px solid var(--secondary); border-right: 3px solid var(--secondary); }

        .t-card:hover {
            background: rgba(0, 242, 255, 0.05); transform: translateY(-10px) scale(1.02);
            border-color: var(--primary); box-shadow: 0 0 30px rgba(0, 242, 255, 0.2);
        }
        
        .t-card i { font-size: 60px; margin-bottom: 20px; color: #fff; transition: 0.4s; }
        .t-card:hover i { color: var(--primary); transform: rotateY(360deg); }
        
        .t-card h3 { font-family: 'Orbitron'; font-size: 18px; color: var(--primary); margin-bottom: 10px; }
        .t-card p { font-size: 14px; color: #888; text-align: center; line-height: 1.4; }

        /* Footer Status */
        footer {
            position: fixed; bottom: 0; width: 100%; padding: 10px 5%;
            background: rgba(0,0,0,0.9); border-top: 1px solid rgba(0,242,255,0.3);
            display: flex; justify-content: space-between; font-size: 12px; font-family: 'Orbitron';
        }
        .blinker { width: 10px; height: 10px; background: #00ff00; border-radius: 50%; display: inline-block; margin-right: 10px; box-shadow: 0 0 10px #00ff00; animation: blink 1s infinite; }
        @keyframes blink { 50% { opacity: 0; } }
    </style>
</head>
<body>

    <header>
        <div class="brand">
            <div class="logo-box">
                <i class="fa-solid fa-train-subway" style="font-size: 30px; color: var(--primary);"></i>
            </div>
            <div class="brand-text">
                <h1>RAILPRO</h1>
                <span>VERSION 4.0 // NEURAL LINK</span>
            </div>
        </div>
        
        <div class="user-status">
            <div class="auth-chip">
                <i class="fa-solid fa-shield-halved" style="color:var(--primary)"></i> 
                IDENTIFIED: <%= name.toUpperCase() %>
            </div>
            <a href="LogoutServlet" class="logout-ico"><i class="fa-solid fa-power-off"></i></a>
        </div>
    </header>

    <div class="main-stage">
        <div class="sys-info">
            <p>// STATUS: ONLINE</p>
            <h2>COMMAND CENTER</h2>
        </div>

        <div class="tactical-grid">
            <a href="index.jsp" class="t-card">
                <i class="fa-solid fa- receipt"></i>
                <h3>BOOKINGS</h3>
                <p>Deploy ticketing protocol and secure your voyage assets.</p>
            </a>

            <a href="pnr_status.jsp" class="t-card">
                <i class="fa-solid fa-radar"></i>
                <h3>PNR TRACKING</h3>
                <p>Initialize deep-scan to locate vessel coordinates.</p>
            </a>

            <a href="all_trains.jsp" class="t-card">
                <i class="fa-solid fa-database"></i>
                <h3>ALL TRAINS</h3>
                <p>Access encrypted data of all active locomotive units.</p>
            </a>

            <a href="agent_profile.jsp" class="t-card">
                <i class="fa-solid fa-user-shield"></i>
                <h3>AGENT PROFILE</h3>
                <p>Modify clearance levels and review mission history.</p>
            </a>
            
           
        </div>
    </div>

    <footer>
        <div><span class="blinker"></span> SYSTEM UPTIME: 99.99%</div>
        <div style="color: var(--primary)">ENCRYPTION: AES-256 BIT // SECURE TERMINAL</div>
    </footer>

</body>
</html>