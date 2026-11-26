<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%
                // Agar session nahi hai toh seedha login pe fenko
                if (session.getAttribute("user_name") == null) {
                    response.sendRedirect("login.html");
                }
            %>
<!DOCTYPE html>
<html>
<head>
    <title>RAILPRO | VOYAGE MANIFEST</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Rajdhani:wght@500;700&display=swap" rel="stylesheet">
    <style>
        :root { --accent: #00f2ff; --neon: #ff00ea; --bg: #020205; }
        body { background: var(--bg); color: white; font-family: 'Rajdhani', sans-serif; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .dam-card { width: 650px; background: rgba(10, 15, 25, 0.95); border-radius: 20px; padding: 30px; border: 1px solid var(--accent); box-shadow: 0 0 30px rgba(0, 242, 255, 0.2); }
        h2 { font-family: 'Orbitron'; color: var(--accent); text-align: center; letter-spacing: 4px; }
        .info-grid { display: flex; gap: 20px; margin-bottom: 20px; background: rgba(255,255,255,0.05); padding: 15px; border-radius: 10px; border-left: 4px solid var(--neon); }
        .label { font-family: 'Orbitron'; font-size: 10px; color: #666; display: block; }
        .val { font-size: 16px; font-weight: bold; }
        input, select { background: rgba(255,255,255,0.05); border: 1px solid #333; color: white; padding: 10px; border-radius: 5px; outline: none; }
        .passenger-row { display: grid; grid-template-columns: 3fr 1fr 1fr; gap: 10px; margin-bottom: 10px; }
        .btn-execute { width: 100%; padding: 15px; background: linear-gradient(90deg, #ff6a00, #ee0979); border: none; border-radius: 10px; color: white; font-family: 'Orbitron'; font-weight: 900; cursor: pointer; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="dam-card">
        <h2>VOYAGE MANIFEST</h2>
        <div class="info-grid">
            <div><span class="label">UNIT_NO</span><span class="val"><%= request.getParameter("tno") %></span></div>
            <div><span class="label">LOCOMOTIVE</span><span class="val"><%= request.getParameter("tname") %></span></div>
        </div>

        <form action="BookingServlet" method="POST">
            <input type="hidden" name="tno" value="<%= request.getParameter("tno") %>">
            <input type="hidden" name="tname" value="<%= request.getParameter("tname") %>">
            
            <input type="hidden" id="pCountHidden" name="pCount" value="1">

            <div style="margin-bottom: 20px;">
                <label class="label">AGENT COUNT (MAX 10)</label>
                <input type="number" id="pCountInput" value="1" min="1" max="10" oninput="generateInputs()" style="width: 70px; border-color: var(--neon); text-align: center;">
            </div>

            <div id="passenger_inputs">
                </div>

            <button type="submit" class="btn-execute">EXECUTE MULTI-BOOKING</button>
        </form>
    </div>

    <script>
        function generateInputs() {
            let count = document.getElementById('pCountInput').value;
            if (count > 10) count = 10;
            if (count < 1) count = 1;
            
            // Hidden value update karo taaki Servlet ko loop ka size mile
            document.getElementById('pCountHidden').value = count;
            
            const container = document.getElementById('passenger_inputs');
            container.innerHTML = '';
            
            for(let i=1; i<=count; i++) {
                container.innerHTML += `
                    <div class="passenger-row">
                        <input type="text" name="pname\${i}" placeholder="AGENT \${i} NAME" required autocomplete="off">
                        <input type="number" name="page\${i}" placeholder="AGE" required>
                        <select name="pgen\${i}"><option>MALE</option><option>FEMALE</option></select>
                    </div>`;
            }
        }
        // Initial call taaki page load par 1st field dikhe
        window.onload = generateInputs;
    </script>
</body>
</html>