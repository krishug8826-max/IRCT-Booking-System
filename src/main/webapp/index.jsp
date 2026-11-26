<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RAILPRO | THE FINAL BOSS v2.0</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700;900&family=Poppins:wght@400;600;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root { 
            --accent: #00f2ff; 
            --neon: #ff00ea; 
            --btn-glow: #ff6a00;
            --card-bg: rgba(13, 15, 20, 0.95);
        }

        /* Responsive Setup */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }

        body {
            background: #000; min-height: 100vh; color: white; overflow-x: hidden;
            background: radial-gradient(circle at center, rgba(0, 242, 255, 0.1) 0%, #000 100%),
                        url('1.jpeg') no-repeat center center/cover fixed;
        }

        /* --- NEW FLIGHT ICON (TOP LEFT & RESPONSIVE) --- */
        .flight-link {
            position: fixed;
            left: clamp(10px, 3vw, 30px);
            top: clamp(10px, 3vw, 30px);
            width: clamp(50px, 8vw, 75px);
            height: clamp(50px, 8vw, 75px);
            background: rgba(0,0,0,0.8);
            border: 2px solid var(--neon);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--neon);
            font-size: clamp(20px, 4vw, 30px);
            text-decoration: none;
            z-index: 2005;
            transition: 0.4s;
            box-shadow: 0 0 20px var(--neon), inset 0 0 10px var(--neon);
        }
        .flight-link:hover {
            background: var(--neon);
            color: black;
            box-shadow: 0 0 40px var(--neon);
            transform: scale(1.1) rotate(-15deg);
        }

        /* --- HEAVY NAVBAR --- */
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

        .nav-auth { display: flex; gap: 20px; }
        .auth-btn {
            text-decoration: none; font-family: 'Orbitron'; font-size: 14px; font-weight: 900;
            padding: 12px 35px; border-radius: 4px; transition: 0.5s; letter-spacing: 2px;
        }
        .login-nav { color: var(--accent); border: 2px solid var(--accent); box-shadow: inset 0 0 10px var(--accent); }
        .login-nav:hover { background: var(--accent); color: #000; box-shadow: 0 0 30px var(--accent); }
        .reg-nav { background: var(--btn-glow); color: white; border: none; box-shadow: 0 0 20px var(--btn-glow); }

        /* --- GIANT HERO SECTION --- */
        .container {
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            text-align: center; padding: clamp(60px, 10vw, 120px) 5% 80px 5%;
        }

        .hero-title { max-width: 1200px; width: 100%; }
        .hero-title h1 {
            font-family: 'Orbitron', sans-serif;
            font-size: clamp(45px, 12vw, 110px); 
            font-weight: 900; line-height: 0.85; text-transform: uppercase;
            background: linear-gradient(180deg, #fff 30%, #444 100%);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            filter: drop-shadow(0 10px 20px rgba(0,0,0,1));
        }
        .hero-title h1 span { color: var(--accent); -webkit-text-fill-color: var(--accent); }

        /* THE  ANIMATED LINE - RESTORED */
        .animated-line {
            height: 8px; background: var(--accent); border-radius: 20px; margin: 40px auto;
            box-shadow: 0 0 30px var(--accent), 0 0 60px var(--accent);
            animation: expandContract 2.5s ease-in-out infinite;
        }
        @keyframes expandContract {
            0%, 100% { width: 80px; filter: hue-rotate(0deg); }
            50% { width: clamp(250px, 60vw, 700px); filter: hue-rotate(90deg); }
        }

        .hero-title p { 
            font-size: clamp(16px, 2.5vw, 26px); color: #ddd; 
            max-width: 900px; margin: 0 auto; line-height: 1.4; font-weight: 400;
            text-transform: uppercase; letter-spacing: 2px;
        }

        /* --- THE MONSTER BOX --- */
        .box-wrapper {
            position: relative; padding: 6px; border-radius: 40px;
            background: linear-gradient(45deg, var(--accent), var(--neon), var(--accent), var(--neon));
            background-size: 300%; animation: flow 5s linear infinite;
            width: 100%; max-width: 850px; 
            margin-top: 70px; 
            box-shadow: 0 50px 100px rgba(0,0,0,0.9), 0 0 40px rgba(0, 242, 255, 0.2);
        }
        @keyframes flow { 0% { background-position: 0% 50%; } 100% { background-position: 300% 50%; } }

        .card { background: var(--card-bg); border-radius: 35px; padding: clamp(30px, 8vw, 80px); backdrop-filter: blur(20px); }

        /* --- HEAVY TABS --- */
        .tabs { display: flex; justify-content: center; gap: clamp(15px, 6vw, 70px); margin-bottom: 50px; }
        .tab-btn {
            background: none; border: none; color: #444; padding: 20px 0; cursor: pointer;
            font-family: 'Orbitron'; font-size: clamp(12px, 2.5vw, 20px); font-weight: 900; 
            transition: 0.4s; position: relative; letter-spacing: 3px;
        }
        .tab-btn.active { color: var(--accent); text-shadow: 0 0 15px var(--accent); }
        .tab-btn.active::after { 
            content: ''; position: absolute; bottom: 0; left: 0; width: 100%; height: 5px; 
            background: var(--accent); box-shadow: 0 0 20px var(--accent);
        }

        .tab-content { display: none; animation: heavySlide 0.6s cubic-bezier(0.23, 1, 0.32, 1); }
        .tab-content.active { display: block; }
        @keyframes heavySlide { from { opacity: 0; transform: scale(0.9) translateY(40px); } to { opacity: 1; transform: scale(1) translateY(0); } }

        /* --- HEAVY INPUTS --- */
        .input-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: clamp(20px, 4vw, 40px); margin-bottom: 40px; }
        .group { text-align: left; }
        .group label { color: var(--accent); font-size: 14px; font-weight: 900; display: block; margin-bottom: 15px; letter-spacing: 3px; }
        .group input {
            width: 100%; padding: 25px; background: rgba(255,255,255,0.03); border: 2px solid rgba(255,255,255,0.1);
            border-radius: 20px; color: white; font-size: 20px; outline: none; transition: 0.4s;
            box-shadow: inset 0 0 15px rgba(0,0,0,0.5);
        }
        .group input:focus { border-color: var(--accent); box-shadow: 0 0 30px rgba(0,242,255,0.3), inset 0 0 10px rgba(0,242,255,0.1); background: rgba(255,255,255,0.07); }

        /* --- THE NUCLEAR BUTTON --- */
        .btn-search {
            width: 100%; padding: 28px; border: none; border-radius: 20px;
            background: linear-gradient(90deg, #ff6a00, #ee0979, #ff6a00); background-size: 200%;
            color: white; font-family: 'Orbitron'; font-size: clamp(18px, 3vw, 24px); font-weight: 900;
            cursor: pointer; box-shadow: 0 15px 50px rgba(238, 9, 121, 0.5); transition: 0.5s; 
            text-transform: uppercase; letter-spacing: 5px;
        }
        .btn-search:hover { 
            transform: translateY(-8px) scale(1.02); 
            background-position: right center;
            box-shadow: 0 25px 80px rgba(238, 9, 121, 0.8); 
        }

        /* Mobile Adjustments */
        @media (max-width: 600px) {
            nav { justify-content: center; padding-top: 80px; }
            .logo { font-size: 28px; letter-spacing: 4px; }
            .card { padding: 30px 15px; }
            .auth-btn { padding: 10px 20px; font-size: 12px; }
        }

    </style>
</head>
<body>

    <a href="flight/flight.jsp" class="flight-link" title="SWITCH TO FLIGHTS">
        <i class="fas fa-plane"></i>
    </a>

    <nav>
        <div class="logo">RAILPRO</div>
        <div class="nav-auth">
            <a href="login.html" class="auth-btn login-nav">LOGIN</a>
            <a href="register.html" class="auth-btn reg-nav">JOIN NOW</a>
        </div>
    </nav>

    <div class="container">
        <div class="hero-title">
            <h1>NEXT-GEN <span>BEYOND</span></h1>
            <div class="animated-line"></div> <p>The Ultimate Digital Rail Corridor of Bharat</p>
        </div>

        <div class="box-wrapper">
            <div class="card">
                <div class="tabs">
                    <button class="tab-btn active" onclick="switchTab(event, 'book')">BOOKING</button>
                    <button class="tab-btn" onclick="switchTab(event, 'pnr')">PNR TRACK</button>
                    <button class="tab-btn" onclick="switchTab(event, 'sched')">DATA</button>
                </div>

               <div id="book" class="tab-content active">
    <form action="SearchTrainServlet" method="POST">
        <div class="input-row">
            <div class="group">
                <label>ORIGIN</label>
                <input type="text" name="source" placeholder="DEPARTURE STATION" required>
            </div>
            <div class="group">
                <label>DESTINATION</label>
                <input type="text" name="destination" placeholder="ARRIVAL STATION" required>
            </div>
        </div>
        <div class="group" style="margin-bottom:40px;">
            <label>DEPARTURE DATE</label>
            <input type="date" name="date" required style="color-scheme: dark;">
        </div>
        <button type="submit" class="btn-search">INITIALIZE VOYAGE</button>
    </form>
</div>

                <div id="pnr" class="tab-content">
    <form action="PnrServlet" method="POST"> 
        <div class="group" style="margin-bottom:40px;">
            <label>ENTER 10-DIGIT PNR</label>
            <input type="text" name="pnr" placeholder="XXXXXXXXXX" maxlength="10" required>
        </div>
        <button type="submit" class="btn-search">TRACK JOURNEY</button>
    </form>
</div>

                <div id="sched" class="tab-content">
                    <p style="margin-bottom: 30px; font-size: 18px; color: #888; letter-spacing: 2px;">ACCESSING RAILWAY DATABASE v2.6...</p>
                    <button class="btn-search" onclick="location.href='all_trains.jsp'">OPEN DATABASE</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function switchTab(evt, id) {
            let contents = document.getElementsByClassName("tab-content");
            for (let c of contents) c.classList.remove("active");
            let btns = document.getElementsByClassName("tab-btn");
            for (let b of btns) b.classList.remove("active");
            document.getElementById(id).classList.add("active");
            evt.currentTarget.classList.add("active");
        }
    </script>
</body>
</html>