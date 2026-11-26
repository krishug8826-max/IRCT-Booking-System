<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>RAILPRO | SESSION TERMINATED</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Rajdhani:wght@500&display=swap" rel="stylesheet">
    <meta http-equiv="refresh" content="3;url=index.jsp">
    
    <style>
        :root { --accent: #ff00ea; --bg: #020205; }
        body { 
            background: var(--bg); color: white; font-family: 'Rajdhani', sans-serif; 
            height: 100vh; display: flex; align-items: center; justify-content: center; margin: 0;
        }
        .logout-box {
            text-align: center; padding: 40px; border: 1px solid var(--accent);
            border-radius: 15px; box-shadow: 0 0 30px rgba(255, 0, 234, 0.2);
            background: rgba(255, 255, 255, 0.02);
        }
        h1 { font-family: 'Orbitron'; letter-spacing: 5px; color: var(--accent); }
        .loader {
            margin: 20px auto; width: 40px; height: 40px;
            border: 3px solid rgba(255,255,255,0.1); border-top: 3px solid var(--accent);
            border-radius: 50%; animation: spin 1s linear infinite;
        }
        @keyframes spin { 100% { transform: rotate(360deg); } }
        p { opacity: 0.6; letter-spacing: 2px; }
    </style>
</head>
<body>

    <div class="logout-box">
        <h1>SESSION TERMINATED</h1>
        <div class="loader"></div>
        <p>AGENT DATA ENCRYPTED & DELETED...</p>
        <p style="font-size: 10px; margin-top: 10px;">RETURNING TO LOGIN INTERFACE IN 3 SECONDS</p>
    </div>

</body>
</html>