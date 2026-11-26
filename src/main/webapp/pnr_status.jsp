<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security check - User login hona chahiye
    if (session.getAttribute("user_name") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RAILPRO | PNR SATELLITE TRACKER</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Rajdhani:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root { --primary: #00f2ff; --secondary: #ff00ea; --bg: #020205; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body { 
            background: var(--bg); color: #fff; font-family: 'Rajdhani', sans-serif; 
            min-height: 100vh; display: flex; flex-direction: column;
        }

        /* Radar Background Animation */
        .radar-container {
            position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
            width: 600px; height: 600px; border: 1px solid rgba(0, 242, 255, 0.1);
            border-radius: 50%; z-index: -1; pointer-events: none;
        }
        .radar-sweep {
            position: absolute; width: 100%; height: 100%;
            background: conic-gradient(from 0deg, transparent, rgba(0, 242, 255, 0.2));
            border-radius: 50%; animation: rotate 4s linear infinite;
        }
        @keyframes rotate { 100% { transform: rotate(360deg); } }

        header {
            padding: 20px 5%; border-bottom: 1px solid rgba(0, 242, 255, 0.2);
            display: flex; justify-content: space-between; align-items: center; background: rgba(0,0,0,0.8);
        }
        .logo { font-family: 'Orbitron'; color: var(--primary); text-decoration: none; letter-spacing: 3px; font-size: 20px; }

        .main-content {
            flex: 1; display: flex; align-items: center; justify-content: center; padding: 20px;
        }

        /* Tactical PNR Box */
        .pnr-box {
            background: rgba(10, 15, 25, 0.9); border: 1px solid var(--primary);
            padding: 50px; border-radius: 20px; width: 100%; max-width: 500px;
            text-align: center; position: relative; box-shadow: 0 0 40px rgba(0, 242, 255, 0.1);
        }
        .pnr-box::before {
            content: 'SCANNING...'; position: absolute; top: -15px; left: 20px;
            background: var(--bg); padding: 0 10px; font-family: 'Orbitron';
            font-size: 10px; color: var(--primary); letter-spacing: 2px;
        }

        .icon-header { font-size: 50px; color: var(--secondary); margin-bottom: 20px; filter: drop-shadow(0 0 10px var(--secondary)); }
        
        h2 { font-family: 'Orbitron'; margin-bottom: 10px; letter-spacing: 2px; }
        p { color: #888; margin-bottom: 30px; font-size: 14px; }

        .input-wrapper { position: relative; margin-bottom: 30px; }
        .input-wrapper input {
            width: 100%; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.2);
            padding: 18px 20px; border-radius: 10px; color: #fff; font-size: 18px;
            font-family: 'Orbitron'; letter-spacing: 5px; outline: none; text-align: center;
        }
        .input-wrapper input:focus { border-color: var(--primary); box-shadow: 0 0 20px rgba(0, 242, 255, 0.2); }

        .track-btn {
            width: 100%; padding: 18px; background: linear-gradient(90deg, #00f2ff, #0072ff);
            border: none; border-radius: 10px; color: #000; font-family: 'Orbitron';
            font-weight: 900; font-size: 16px; cursor: pointer; letter-spacing: 3px;
            transition: 0.4s;
        }
        .track-btn:hover { transform: scale(1.02); box-shadow: 0 0 30px var(--primary); }

        .back-link { margin-top: 20px; display: block; color: #555; text-decoration: none; font-size: 12px; }
        .back-link:hover { color: var(--primary); }
    </style>
</head>
<body>

    <div class="radar-container"><div class="radar-sweep"></div></div>

    <header>
        <a href="dashboard.jsp" class="logo">RAILPRO</a>
        <div style="font-family: 'Orbitron'; font-size: 12px; color: var(--secondary);">PNR_UPLINK: ACTIVE</div>
    </header>

    <div class="main-content">
        <div class="pnr-box">
            <div class="icon-header">
                <i class="fa-solid fa-satellite-dish"></i>
            </div>
            <h2>PNR STATUS</h2>
            <p>Enter your 10-digit PNR code to intercept voyage data.</p>

            <form action="PnrServlet" method="POST">
                <div class="input-wrapper">
                    <input type="text" name="pnr" placeholder="XXXXXXXXXX" maxlength="10" required>
                </div>
                <button type="submit" class="track-btn">INITIALIZE SCAN</button>
            </form>

            <a href="dashboard.jsp" class="back-link">← RETURN TO COMMAND CENTER</a>
        </div>
    </div>

</body>
</html>