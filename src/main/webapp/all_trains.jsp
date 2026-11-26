<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RAILPRO | TRAIN REGISTRY DAM v2.0</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700;900&family=Rajdhani:wght@500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root { 
            --accent: #00f2ff; 
            --neon: #ff00ea; 
            --bg: #020205;
            --glass: rgba(255, 255, 255, 0.03);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body { 
            background: var(--bg); 
            background-image: 
                radial-gradient(circle at 50% 50%, rgba(0, 242, 255, 0.05) 0%, transparent 70%);
            color: white; 
            font-family: 'Rajdhani', sans-serif; 
            min-height: 100vh;
            padding: 40px 5%;
        }

        /* DAM Glowing Border Container */
        .dam-wrapper {
            position: relative;
            padding: 2px;
            border-radius: 20px;
            background: linear-gradient(90deg, var(--accent), var(--neon), var(--accent));
            background-size: 200%;
            animation: borderFlow 4s linear infinite;
            max-width: 1200px;
            margin: auto;
        }

        @keyframes borderFlow {
            0% { background-position: 0% 50%; }
            100% { background-position: 200% 50%; }
        }

        .registry-card {
            background: rgba(10, 15, 25, 0.98);
            border-radius: 19px;
            padding: 40px;
            backdrop-filter: blur(20px);
        }

        .header-section {
            text-align: center;
            margin-bottom: 40px;
        }

        h1 {
            font-family: 'Orbitron';
            font-size: clamp(24px, 5vw, 45px);
            letter-spacing: 8px;
            color: var(--accent);
            text-shadow: 0 0 20px var(--accent);
            text-transform: uppercase;
        }

        .animated-line {
            height: 4px;
            background: var(--accent);
            width: 100px;
            margin: 15px auto;
            border-radius: 10px;
            box-shadow: 0 0 15px var(--accent);
            animation: lineExpand 2s infinite ease-in-out;
        }

        @keyframes lineExpand {
            0%, 100% { width: 50px; opacity: 0.5; }
            50% { width: 200px; opacity: 1; }
        }

        /* Tactical Table Styling */
        .table-responsive { overflow-x: auto; }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
            margin-top: 20px;
        }

        th {
            font-family: 'Orbitron';
            font-size: 12px;
            color: #555;
            text-transform: uppercase;
            padding: 15px;
            letter-spacing: 2px;
            text-align: left;
            border-bottom: 1px solid #222;
        }

        tr {
            transition: 0.3s ease;
        }

        td {
            padding: 20px 15px;
            background: var(--glass);
            font-size: 18px;
            border-top: 1px solid rgba(255,255,255,0.05);
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }

        /* Rounding first and last td for row effect */
        td:first-child { border-left: 1px solid rgba(255,255,255,0.05); border-radius: 12px 0 0 12px; }
        td:last-child { border-right: 1px solid rgba(255,255,255,0.05); border-radius: 0 12px 12px 0; }

        tr:hover td {
            background: rgba(0, 242, 255, 0.08);
            color: var(--accent);
            border-color: var(--accent);
            transform: scale(1.01);
        }

        .t-no { font-family: 'Orbitron'; color: var(--neon); font-weight: 900; }
        .price { color: #00ff41; font-weight: bold; font-family: 'Orbitron'; }

        /* Action Button DAM Style */
        .btn-initiate {
            display: inline-block;
            padding: 10px 20px;
            background: transparent;
            border: 1px solid var(--accent);
            color: var(--accent);
            text-decoration: none;
            font-family: 'Orbitron';
            font-size: 10px;
            border-radius: 5px;
            transition: 0.4s;
            position: relative;
            overflow: hidden;
        }

        .btn-initiate:hover {
            background: var(--accent);
            color: black;
            box-shadow: 0 0 20px var(--accent);
        }

        .status-dot {
            height: 8px; width: 8px; background: #00ff41;
            border-radius: 50%; display: inline-block;
            margin-right: 10px; box-shadow: 0 0 10px #00ff41;
        }

        .back-link {
            display: block; text-align: center; margin-top: 30px;
            color: #444; text-decoration: none; font-family: 'Orbitron'; font-size: 12px;
            transition: 0.3s;
        }
        .back-link:hover { color: var(--accent); }

    </style>
</head>
<body>

    <div class="header-section">
        <h1>TRAIN REGISTRY</h1>
        <div class="animated-line"></div>
        <p style="letter-spacing: 2px; color: #888;">REAL-TIME DATABASE ACCESS v2.6</p>
    </div>

    <div class="dam-wrapper">
        <div class="registry-card">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>IDENTIFIER</th>
                            <th>LOCOMOTIVE</th>
                            <th>ROUTE (SOURCE - DEST)</th>
                            <th>SCHEDULE</th>
                            <th>FARE</th>
                            <th>TERMINAL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "system");
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM trains ORDER BY T_NO ASC");
                                
                                while(rs.next()) {
                        %>
                        <tr>
                            <td class="t-no"><%= rs.getString("T_NO") %></td>
                            <td style="font-weight: 700;"><%= rs.getString("T_NAME") %></td>
                            <td>
                                <span style="color: #bbb;"><%= rs.getString("SOURCE_STN") %></span> 
                                <i class="fa-solid fa-angles-right" style="font-size: 12px; margin: 0 10px; color: var(--accent);"></i> 
                                <span style="color: #bbb;"><%= rs.getString("DEST_STN") %></span>
                            </td>
                            <td><i class="fa-regular fa-clock" style="margin-right: 8px;"></i><%= rs.getString("DEP_TIME") %></td>
                            <td class="price">₹<%= rs.getString("PRICE") %></td>
                            <td>
                                <a href="book_ticket.jsp?tno=<%= rs.getString("T_NO") %>&tname=<%= rs.getString("T_NAME") %>" class="btn-initiate">
                                    <span class="status-dot"></span>BOOK
                                </a>
                            </td>
                        </tr>
                        <%
                                }
                                con.close();
                            } catch(Exception e) {
                                out.println("<tr><td colspan='6' style='color:red; text-align:center;'>CRITICAL_ERROR: " + e.getMessage() + "</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <a href="index.jsp" class="back-link">[ DISCONNECT FROM DATABASE ]</a>

</body>
</html>