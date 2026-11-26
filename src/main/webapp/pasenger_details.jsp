<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // SESSION PROTECTION
    String user = (String) session.getAttribute("user_name");
    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }
    String tno = request.getParameter("tno");
    String tname = request.getParameter("tname");
%>
<html>
<head>
    <style>
        body{background:#020205; color:white; font-family:sans-serif; text-align:center; padding:50px;}
        .box{border:1px solid #00f2ff; padding:30px; width:500px; margin:auto; border-radius:20px; background:#0a0f19;}
        input, select{width:90%; padding:10px; margin:10px 0; background:#000; border:1px solid #333; color:white;}
    </style>
    <script>
        function updateForms() {
            let n = document.getElementById("tc").value;
            let d = document.getElementById("p_inputs");
            d.innerHTML = "";
            for(let i=1; i<=n; i++) {
                d.innerHTML += `<div style='border-top:1px solid #333; padding:10px;'>
                    <label>Passenger \${i}</label>
                    <input name='pname_\${i}' placeholder='Name' required>
                    <input type='number' name='age_\${i}' placeholder='Age' required>
                    <select name='gender_\${i}'><option>Male</option><option>Female</option></select>
                </div>`;
            }
        }
    </script>
</head>
<body onload="updateForms()">
    <div class="box">
        <h2 style="color:#00f2ff;">VOYAGE REGISTRATION</h2>
        <p>Welcome, Agent <%= user %></p>
        <p>Vessel: <%= tname %> (#<%= tno %>)</p>
        <form action="FinalBooking" method="post">
            <input type="hidden" name="tno" value="<%= tno %>">
            <input type="hidden" name="tname" value="<%= tname %>">
            <label>Tickets:</label>
            <select name="total_tickets" id="tc" onchange="updateForms()">
                <option value="1">1</option><option value="2">2</option><option value="3">3</option>
            </select>
            <div id="p_inputs"></div>
            <button type="submit" style="width:95%; background:#ff00ea; color:white; padding:15px; border:none; cursor:pointer;">CONFIRM BOOKING</button>
        </form>
    </div>
</body>
</html>