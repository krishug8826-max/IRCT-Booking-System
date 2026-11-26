<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("user_name") == null) {
        response.sendRedirect("login.html");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SKYPRO | COMMAND CENTRE</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Poppins:wght@300;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --accent: #ff00ea; --neon-blue: #00f2ff; }
        
        * { box-sizing: border-box; }

        body {
            margin: 0; background: #050505; color: white; font-family: 'Poppins', sans-serif;
            background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)), url('3.jpeg') no-repeat center center/cover fixed;
            display: flex; /* Screen auto-set karne ke liye */
            min-height: 100vh;
        }

        /* Responsive Sidebar */
        .sidebar {
            width: 260px; background: rgba(15, 10, 25, 0.95);
            border-right: 1px solid var(--accent); padding: 30px 20px;
            display: flex; flex-direction: column;
            flex-shrink: 0; /* Sidebar size fix rahega */
        }

        /* Main Content jo bachi hui screen le lega */
        .main-content {
            flex-grow: 1;
            padding: 40px;
            overflow-y: auto;
        }

        .user-badge {
            padding: 20px; border: 1px solid var(--neon-blue); border-radius: 15px;
            background: rgba(0, 242, 255, 0.05); margin-bottom: 30px;
            width: 100%;
        }

        .welcome-text { font-family: 'Orbitron'; font-size: clamp(18px, 4vw, 24px); color: var(--accent); }
        
        /* Grid auto-adjust (Bade screen pe 3, chote pe 1) */
        .grid-stats { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); 
            gap: 20px; 
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.03); padding: 30px; border-radius: 20px;
            border-bottom: 4px solid var(--accent); transition: 0.3s;
            text-align: center;
        }

        .nav-link {
            display: block; padding: 15px; color: #ccc; text-decoration: none;
            font-family: 'Orbitron'; font-size: 12px; letter-spacing: 2px;
            border-radius: 10px; margin-bottom: 10px; transition: 0.3s;
        }

        .nav-link:hover, .nav-link.active { background: var(--accent); color: white; box-shadow: 0 0 15px var(--accent); }
        
        .logout-section { margin-top: auto; padding-top: 20px; }
        .logout-btn { color: #ff4444 !important; border: 1px solid #ff4444; text-align: center; }
        .logout-btn:hover { background: #ff4444 !important; color: white !important; }

        /* Mobile Optimization */
        @media (max-width: 768px) {
            body { flex-direction: column; }
            .sidebar { width: 100%; height: auto; border-right: none; border-bottom: 1px solid var(--accent); }
            .main-content { padding: 20px; }
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2 style="font-family: 'Orbitron'; color: var(--accent); letter-spacing: 5px; margin: 0;">SKYPRO</h2>
        <p style="font-size: 10px; color: var(--neon-blue); margin-bottom: 40px;">FLIGHT CONTROL V2.0</p>
        
        <nav>
            <a href="dashboard.jsp" class="nav-link active"><i class="fas fa-th-large"></i> DASHBOARD</a>
            <a href="../AllFlights" class="nav-link"><i class="fas fa-plane"></i> ALL FLIGHTS</a>
            <a href="../MyTickets" class="nav-link"><i class="fas fa-ticket-alt"></i> MY TICKETS</a>
            <a href="../ProfileServlet" class="nav-link"><i class="fas fa-user-shield"></i> PROFILE</a>
             <a href="flight.jsp" class="nav-link"><i class="fas fa-user-shield"></i> SEARCH FLIGHTS</a>
        </nav>
        
        <div class="logout-section">
            <a href="../LogoutServlets" class="nav-link logout-btn" onclick="return confirm('Aur You Sure ?')">
                <i class="fas fa-power-off"></i> LOGOUT
            </a>
        </div>
    </div>
    
    <div class="main-content">
        <div class="user-badge">
            <span class="welcome-text">WELCOME, PILOT <%= session.getAttribute("user_name").toString().toUpperCase() %></span>
            <p style="color: #888; margin: 5px 0 0 0;">Clearance Level: Alpha-1 | Location: Bharat Airspace</p>
        </div>

        <div class="grid-stats">
            <div class="stat-card">
                <i class="fas fa-plane" style="font-size: 30px; color: var(--neon-blue); margin-bottom: 15px;"></i>
                <h3 style="margin: 10px 0;">Active Bookings</h3>
                <p style="font-size: 28px; font-weight: bold; margin: 0;">04</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-coins" style="font-size: 30px; color: #ffcc00; margin-bottom: 15px;"></i>
                <h3 style="margin: 10px 0;">Sky Credits</h3>
                <p style="font-size: 28px; font-weight: bold; margin: 0;">12,450</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-route" style="font-size: 30px; color: #00ff88; margin-bottom: 15px;"></i>
                <h3 style="margin: 10px 0;">Miles Flown</h3>
                <p style="font-size: 28px; font-weight: bold; margin: 0;">850 KM</p>
            </div>
        </div>
    </div>

</body>
</html>