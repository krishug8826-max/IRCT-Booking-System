<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SKYPRO | THE AERIAL BOSS v2.0</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700;900&family=Poppins:wght@400;600;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root { 
            --accent: #ff00ea; /* Neon Pink for Flight */
            --rail-blue: #00f2ff; 
            --btn-glow: #7000ff;
            --card-bg: rgba(15, 10, 25, 0.95);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }

        body {
            background: #000; min-height: 100vh; color: white; overflow-x: hidden;
            background: radial-gradient(circle at center, rgba(255, 0, 234, 0.1) 0%, #000 100%),
                        url('2.jpeg') no-repeat center center/cover fixed;
                        
          
          
        }

        /* --- TRAIN ICON (TOP LEFT) --- */
        .rail-link {
            position: fixed;
            left: clamp(10px, 3vw, 30px);
            top: clamp(10px, 3vw, 30px);
            width: clamp(50px, 8vw, 75px);
            height: clamp(50px, 8vw, 75px);
            background: rgba(0,0,0,0.8);
            border: 2px solid var(--rail-blue);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--rail-blue);
            font-size: clamp(20px, 4vw, 30px);
            text-decoration: none;
            z-index: 2005;
            transition: 0.4s;
            box-shadow: 0 0 20px var(--rail-blue), inset 0 0 10px var(--rail-blue);
        }
        .rail-link:hover {
            background: var(--rail-blue);
            color: black;
            box-shadow: 0 0 40px var(--rail-blue);
            transform: scale(1.1);
        }

        /* --- RESPONSIVE NAVBAR --- */
        nav {
            padding: 40px 8%; 
            display: flex; justify-content: space-between; align-items: center; 
            background: linear-gradient(to bottom, rgba(0,0,0,0.8), transparent);
            position: sticky; top:0; z-index: 1000;
            flex-wrap: wrap; gap: 20px;
        }
        .logo { 
            font-family: 'Orbitron', sans-serif; font-size: clamp(24px, 5vw, 40px); 
            letter-spacing: 8px; color: var(--accent); 
            text-shadow: 0 0 20px var(--accent), 0 0 40px var(--accent);
        }

        /* Auth Buttons Added */
        .nav-auth { display: flex; gap: clamp(10px, 2vw, 20px); }
        .auth-btn {
            text-decoration: none; font-family: 'Orbitron'; font-size: 14px; font-weight: 900;
            padding: 12px clamp(15px, 3vw, 35px); border-radius: 4px; transition: 0.5s; letter-spacing: 2px;
        }
        .login-nav { color: var(--accent); border: 2px solid var(--accent); box-shadow: inset 0 0 10px var(--accent); }
        .login-nav:hover { background: var(--accent); color: #000; box-shadow: 0 0 30px var(--accent); }
        .reg-nav { background: var(--btn-glow); color: white; border: none; box-shadow: 0 0 20px var(--btn-glow); }

        /* --- HERO SECTION --- */
        .container {
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            text-align: center; padding: clamp(60px, 10vw, 120px) 5% 80px 5%;
        }

        .hero-title h1 {
            font-family: 'Orbitron', sans-serif;
            font-size: clamp(40px, 12vw, 110px); 
            font-weight: 900; line-height: 0.85; text-transform: uppercase;
            background: linear-gradient(180deg, #fff 30%, #444 100%);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .hero-title h1 span { color: var(--accent); -webkit-text-fill-color: var(--accent); }

        /* THE "DAM" ANIMATED LINE */
        .animated-line {
            height: 8px; background: var(--accent); border-radius: 20px; margin: 40px auto;
            box-shadow: 0 0 30px var(--accent), 0 0 60px var(--accent);
            animation: expandContract 2.5s ease-in-out infinite;
        }
        @keyframes expandContract {
            0%, 100% { width: 80px; }
            50% { width: clamp(200px, 60vw, 700px); }
        }

        .hero-title p { 
            font-size: clamp(14px, 2.5vw, 26px); color: #ddd; 
            max-width: 900px; margin: 0 auto; letter-spacing: 2px;
        }

        /* --- THE MONSTER BOX --- */
        .box-wrapper {
            position: relative; padding: 6px; border-radius: 40px;
            background: linear-gradient(45deg, var(--accent), #7000ff, var(--accent), #7000ff);
            background-size: 300%; animation: flow 5s linear infinite;
            width: 100%; max-width: 850px; 
            margin-top: 70px; 
            box-shadow: 0 50px 100px rgba(0,0,0,0.9), 0 0 40px rgba(255, 0, 234, 0.2);
        }
        @keyframes flow { 0% { background-position: 0% 50%; } 100% { background-position: 300% 50%; } }

        .card { background: var(--card-bg); border-radius: 35px; padding: clamp(25px, 8vw, 80px); backdrop-filter: blur(20px); }

        /* --- INPUTS --- */
        .input-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: clamp(15px, 4vw, 40px); margin-bottom: 40px; }
        .group { text-align: left; }
        .group label { color: var(--accent); font-size: 13px; font-weight: 900; display: block; margin-bottom: 12px; letter-spacing: 2px; }
        .group input {
            width: 100%; padding: 22px; background: rgba(255,255,255,0.03); border: 2px solid rgba(255,255,255,0.1);
            border-radius: 20px; color: white; font-size: 18px; outline: none;
            box-shadow: inset 0 0 15px rgba(0,0,0,0.5);
        }
        .group input:focus { border-color: var(--accent); box-shadow: 0 0 30px rgba(255,0,234,0.3); }

        .btn-search {
            width: 100%; padding: 25px; border: none; border-radius: 20px;
            background: linear-gradient(90deg, #7000ff, #ff00ea, #7000ff); background-size: 200%;
            color: white; font-family: 'Orbitron'; font-size: clamp(18px, 3vw, 24px); font-weight: 900;
            cursor: pointer; box-shadow: 0 15px 50px rgba(112, 0, 255, 0.5); transition: 0.5s; 
            text-transform: uppercase; letter-spacing: 5px;
        }
        .btn-search:hover { transform: translateY(-8px); background-position: right center; box-shadow: 0 25px 80px rgba(255, 0, 234, 0.6); }

        /* Mobile specific fix for navbar and logo */
        @media (max-width: 768px) {
            nav { padding-top: 100px; justify-content: center; }
            .logo { width: 100%; text-align: center; margin-bottom: 10px; }
            .nav-auth { width: 100%; justify-content: center; }
            .auth-btn { padding: 10px 20px; font-size: 12px; }
        }
    </style>
</head>
<body>

    <a href="../index.jsp" class="rail-link" title="SWITCH TO RAILWAY">
        <i class="fas fa-train"></i>
    </a>

    <nav>
        <div class="logo">SKYPRO</div>
        <div class="nav-auth">
            <a href="login.html" class="auth-btn login-nav">LOGIN</a>
            <a href="registration.jsp" class="auth-btn reg-nav">JOIN NOW</a>
        </div>
    </nav>

    <div class="container">
        <div class="hero-title">
            <h1>AERIAL <span>BEYOND</span></h1>
            <div class="animated-line"></div>
            <p>THE ULTIMATE DIGITAL SKY CORRIDOR OF BHARAT</p>
        </div>

        <div class="box-wrapper">
            <div class="card">
                <form action="../SearchFlights" method="POST">
                    <div class="input-row">
                        <div class="group"><label>FROM</label><input type="text" name="from" placeholder="DEPARTURE CITY" required></div>
                        <div class="group"><label>TO</label><input type="text" name="to" placeholder="ARRIVAL CITY" required></div>

                    </div>
                    <div class="input-row">
                      <div class="group"><label>DATE</label><input type="date" name="date" required style="color-scheme: dark;"></div>
                        <div class="group"><label>PASSENGERS</label><input type="number" placeholder="1" min="1" required></div>
                    </div>
                    <button type="submit" class="btn-search">TAKE OFF</button>
                </form>
            </div>
        </div>
    </div>

</body>
</html>