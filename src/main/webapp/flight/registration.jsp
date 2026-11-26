<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SKYPRO | CREW REGISTRATION</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700;900&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root { 
            --accent: #ff00ea; 
            --neon-blue: #00f2ff;
            --btn-glow: #7000ff;
            --card-bg: rgba(10, 5, 20, 0.9);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }

        body {
            background: #000;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow-x: hidden;
            background: radial-gradient(circle at center, rgba(112, 0, 255, 0.15) 0%, #000 100%);
            padding: 20px;
        }

        /* Animated Background Particles Effect */
        body::before {
            content: "";
            position: absolute;
            width: 100%; height: 100%;
            background: url('https://www.transparenttextures.com/patterns/stardust.png');
            opacity: 0.3;
            pointer-events: none;
        }

        .reg-container {
            width: 100%;
            max-width: 600px;
            position: relative;
            z-index: 1;
        }

        /* The Neon Border Box */
        .form-wrapper {
            background: var(--card-bg);
            padding: 40px;
            border-radius: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 0 50px rgba(0, 0, 0, 1), 
                        inset 0 0 20px rgba(112, 0, 255, 0.2);
            backdrop-filter: blur(15px);
            position: relative;
        }

        .form-wrapper::after {
            content: "";
            position: absolute;
            top: -2px; left: -2px; right: -2px; bottom: -2px;
            background: linear-gradient(45deg, var(--accent), transparent, var(--neon-blue));
            z-index: -1;
            border-radius: 32px;
            opacity: 0.5;
        }

        .header { text-align: center; margin-bottom: 40px; }
        .header h2 { 
            font-family: 'Orbitron'; color: #fff; font-size: 28px; letter-spacing: 4px; 
            text-transform: uppercase; margin-bottom: 10px;
        }
        .header .line {
            width: 60px; height: 4px; background: var(--accent); margin: 0 auto;
            box-shadow: 0 0 15px var(--accent);
        }

        /* Form Grid */
        .input-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .full-width { grid-column: span 2; }

        .field { position: relative; margin-bottom: 25px; }
        .field i {
            position: absolute; left: 15px; top: 48px;
            color: var(--accent); font-size: 18px;
        }

        label {
            display: block; color: var(--neon-blue); font-family: 'Orbitron';
            font-size: 11px; font-weight: 900; margin-bottom: 8px; letter-spacing: 2px;
        }

        input {
            width: 100%;
            padding: 15px 15px 15px 45px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: #white;
            font-size: 15px;
            transition: 0.3s;
            outline: none;
        }

        input:focus {
            border-color: var(--accent);
            background: rgba(255, 255, 255, 0.1);
            box-shadow: 0 0 15px rgba(255, 0, 234, 0.2);
        }

        .btn-reg {
            width: 100%;
            padding: 20px;
            margin-top: 10px;
            border: none;
            border-radius: 15px;
            background: linear-gradient(90deg, var(--btn-glow), var(--accent));
            color: white;
            font-family: 'Orbitron';
            font-size: 18px;
            font-weight: 900;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 3px;
            transition: 0.5s;
            box-shadow: 0 10px 30px rgba(112, 0, 255, 0.4);
        }

        .btn-reg:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(255, 0, 234, 0.5);
            filter: brightness(1.2);
        }

        .footer-link {
            text-align: center; margin-top: 25px; font-size: 14px; color: #aaa;
        }
        .footer-link a { color: var(--accent); text-decoration: none; font-weight: 600; }

        /* Responsive Fix */
        @media (max-width: 600px) {
            .input-grid { grid-template-columns: 1fr; }
            .full-width { grid-column: span 1; }
            .form-wrapper { padding: 25px; }
        }
    </style>
</head>
<body>

    <div class="reg-container">
        <div class="form-wrapper">
            <div class="header">
                <h2>JOIN THE FLEET</h2>
                <div class="line"></div>
            </div>

            <form action="../RegisterUser" method="POST">
                <div class="input-grid">
                    <div class="field">
                        <label>FIRST NAME</label>
                        <i class="fas fa-user-pilot"></i>
                        <input type="text" name="fname" placeholder="Maverick" required>
                    </div>

                    <div class="field">
                        <label>LAST NAME</label>
                        <i class="fas fa- user"></i>
                        <input type="text" name="lname" placeholder="Skywalker" required>
                    </div>

                    <div class="field full-width">
                        <label>DIGITAL CORRIDOR ID (EMAIL)</label>
                        <i class="fas fa-envelope"></i>
                        <input type="email" name="email" placeholder="pilot@skypro.com" required>
                    </div>

                    <div class="field">
                        <label>ENCRYPTION KEY</label>
                        <i class="fas fa-lock"></i>
                        <input type="password" name="pass" placeholder="••••••••" required>
                    </div>

                    <div class="field">
                        <label>COMMS LINK</label>
                        <i class="fas fa-phone"></i>
                        <input type="tel" name="phone" placeholder="+91 XXXXX XXXXX" required>
                    </div>
                </div>

                <button type="submit" class="btn-reg">INITIALIZE CREW ID</button>
            </form>

            <div class="footer-link">
                ALREADY IN THE FLEET? <a href="login.html">LOGIN HERE</a>
            </div>
        </div>
    </div>

</body>
</html>