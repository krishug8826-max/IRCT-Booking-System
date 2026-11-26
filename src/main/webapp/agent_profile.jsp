<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RAILPRO | AGENT PROFILE</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Rajdhani:wght@500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root { 
            --accent: #00f2ff; 
            --neon: #ff00ea; 
            --bg: #020205; 
            --glass: rgba(0, 242, 255, 0.05);
        }

        body { 
            background: var(--bg); 
            color: white; 
            font-family: 'Rajdhani', sans-serif; 
            min-height: 100vh; 
            display: flex; 
            align-items: center; 
            justify-content: center;
            overflow: hidden;
            background-image: 
                radial-gradient(circle at 20% 30%, rgba(0, 242, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(255, 0, 234, 0.1) 0%, transparent 50%);
        }

        /* Profile Card Container */
        .profile-container {
            width: 500px;
            background: rgba(10, 15, 25, 0.9);
            border: 1px solid rgba(0, 242, 255, 0.3);
            border-radius: 20px;
            padding: 40px;
            position: relative;
            backdrop-filter: blur(15px);
            box-shadow: 0 0 50px rgba(0, 242, 255, 0.1);
        }

        /* Animated Scanner Header */
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }

        .avatar-circle {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid var(--accent);
            margin: 0 auto 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--glass);
            position: relative;
            box-shadow: 0 0 20px var(--accent);
        }

        .avatar-circle i { font-size: 60px; color: var(--accent); }

        .status-badge {
            position: absolute;
            bottom: 5px;
            right: 170px;
            background: #00ff88;
            color: black;
            font-family: 'Orbitron';
            font-size: 8px;
            padding: 3px 8px;
            border-radius: 10px;
            text-transform: uppercase;
            font-weight: 900;
        }

        h1 { 
            font-family: 'Orbitron'; 
            font-size: 24px; 
            letter-spacing: 5px; 
            color: #fff;
        }
        h1 span { color: var(--neon); }

        /* Tactical Data Grid */
        .dossier-grid {
            display: grid;
            gap: 15px;
            margin-bottom: 30px;
        }

        .data-item {
            background: rgba(255, 255, 255, 0.03);
            padding: 12px 20px;
            border-radius: 8px;
            border-left: 2px solid var(--accent);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .data-label {
            font-family: 'Orbitron';
            font-size: 10px;
            color: rgba(255,255,255,0.5);
            text-transform: uppercase;
        }

        .data-value {
            font-family: 'Rajdhani';
            font-size: 18px;
            font-weight: 700;
            color: #fff;
        }

        /* Buttons */
        .action-hub {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .btn {
            padding: 12px;
            border-radius: 10px;
            font-family: 'Orbitron';
            font-size: 10px;
            font-weight: 900;
            text-decoration: none;
            text-align: center;
            transition: 0.3s;
            cursor: pointer;
            border: none;
        }

        .btn-logs { 
            background: linear-gradient(45deg, var(--accent), #0066ff); 
            color: #000; 
        }

        .btn-logout { 
            background: transparent; 
            border: 1px solid var(--neon); 
            color: var(--neon); 
        }

        .btn:hover { transform: scale(1.05); box-shadow: 0 0 15px rgba(0, 242, 255, 0.4); }

        /* HUD Lines Decoration */
        .hud-line {
            position: absolute;
            background: var(--accent);
            opacity: 0.3;
        }
        .v-line { width: 1px; height: 100px; left: -20px; top: 50%; }
        .h-line { height: 1px; width: 100px; top: -20px; left: 50%; }

    </style>
</head>
<body>

    <div class="profile-container">
        <div class="hud-line v-line"></div>
        <div class="hud-line h-line"></div>

        <div class="profile-header">
            <div class="avatar-circle">
                <i class="fa-solid fa-user-secret"></i>
                <div class="status-badge">Online</div>
            </div>
            <h1>AGENT <span>PROFILE</span></h1>
        </div>

        <div class="dossier-grid">
            <div class="data-item">
                <span class="data-label">Agent ID</span>
                <span class="data-value">RAILP-78342</span>
            </div>
            <div class="data-item">
                <span class="data-label">Full Name</span>
                <span class="data-value">KRISHNA GUPTA</span>
            </div>
            <div class="data-item" style="border-left-color: var(--neon);">
                <span class="data-label">Rank</span>
                <span class="data-value">OPERATIVE TIER-2</span>
            </div>
            <div class="data-item">
                <span class="data-label">Total Missions</span>
                <span class="data-value">12</span>
            </div>
            <div class="data-item">
                <span class="data-label">Last Void Date</span>
                <span class="data-value">2026-02-07</span>
            </div>
        </div>

        <div class="action-hub">
            <a href="HistoryServlet" class="btn btn-logs">
                <i class="fa-solid fa- terminal"></i> MISSION LOGS
            </a>
            <a href="logout.jsp" class="btn btn-logout">
                <i class="fa-solid fa-power-off"></i> LOGOUT
            </a>
        </div>
    </div>

</body>
</html>