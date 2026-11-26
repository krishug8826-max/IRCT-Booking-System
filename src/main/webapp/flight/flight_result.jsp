<%@ page import="java.util.*" %>
<div class="results-container">
    <h2 style="color:#ff00ea; font-family:'Orbitron';">AVAILABLE FLIGHTS</h2>
    <%
        ArrayList<Map<String, String>> flights = (ArrayList<Map<String, String>>) request.getAttribute("availableFlights");
        if(flights != null && !flights.isEmpty()) {
            for(Map<String, String> f : flights) {
    %>
        <div style="background:rgba(255,255,255,0.1); padding:20px; border-radius:15px; margin-bottom:10px; border-left:5px solid #00f2ff;">
            <h3><%= f.get("name") %></h3>
            <p>Price: ₹<%= f.get("price") %> | Seats: <%= f.get("seats") %></p>
            <button style="background:#7000ff; color:white; border:none; padding:10px 20px; border-radius:5px;">BOOK NOW</button>
        </div>
    <% 
            }
        } else {
    %>
        <p>No flights found for this route/date.</p>
    <% } %>
</div>