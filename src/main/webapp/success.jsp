<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>DATA INTERCEPTED | RAILPRO</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Rajdhani:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --primary: #00f2ff; --secondary: #00ff41; --bg: #020205; }
        body { background: var(--bg); color: white; font-family: 'Rajdhani', sans-serif; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        
        .result-box {
            background: rgba(10, 15, 25, 0.95); border: 1px solid var(--primary);
            padding: 40px; border-radius: 20px; width: 600px; text-align: left;
            box-shadow: 0 0 50px rgba(0, 242, 255, 0.15); border-left: 5px solid var(--primary);
        }
        
        .header { font-family: 'Orbitron'; color: var(--secondary); border-bottom: 1px solid #222; padding-bottom: 15px; margin-bottom: 25px; display: flex; justify-content: space-between; }
        .data-row { margin-bottom: 20px; }
        .label { font-family: 'Orbitron'; font-size: 10px; color: var(--primary); letter-spacing: 2px; display: block; }
        .value { font-size: 20px; font-weight: 700; color: #fff; text-transform: uppercase; }
        
        .passenger-list { background: rgba(0, 255, 65, 0.05); padding: 15px; border-radius: 10px; border: 1px dashed var(--secondary); margin-top: 15px; }
        .back-btn { margin-top: 30px; display: inline-block; color: #555; text-decoration: none; font-family: 'Orbitron'; font-size: 12px; }
    </style>
</head>
<body>

    <div class="result-box">
        <div class="header">
            <span><i class="fa-solid fa-microchip"></i> DATA_FOUND</span>
            <span style="font-size: 12px;">ENCRYPTION: AES-256</span>
        </div>

        <div class="data-row">
            <span class="label">VOYAGE_ID (PNR)</span>
            <span class="value" style="color: var(--primary); letter-spacing: 3px;"><%= request.getAttribute("finalPNR") %></span>
        </div>

        <div style="display: flex; justify-content: space-between;">
            <div class="data-row">
                <span class="label">LOCOMOTIVE</span>
                <span class="value"><%= request.getAttribute("tName") %></span>
            </div>
            <div class="data-row" style="text-align: right;">
                <span class="label">UNIT_NO</span>
                <span class="value"><%= request.getAttribute("tNo") %></span>
            </div>
        </div>

        <div class="data-row">
    <span class="label">OPERATIVES (PASSENGERS)</span>
    <div class="passenger-list">
    <i class="fa-solid fa-user-shield"></i> 
    <%= (request.getAttribute("pNames") != null) ? request.getAttribute("pNames") : "NO_DATA_FETCHED" %>
</div>
</div>

<div class="data-row">
    <span class="label">MISSION_STATUS</span>
    <span class="value" style="color: #00ff41;">
        [ <%= (request.getAttribute("status") != null) ? request.getAttribute("status") : "ACTIVE" %> ]
    </span>
</div>
        <a href="index.jsp" class="back-btn">← RETURN TO HUB</a>
    </div>

</body>
</html>