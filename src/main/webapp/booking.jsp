

<form action="FinalBooking" method="post" style="background: #0a0f19; padding: 20px; border: 1px solid #00f2ff; color: white; border-radius: 10px; width: 300px;">
    <h3 style="color: #00f2ff; font-family: 'Orbitron';">BOOK VOYAGE</h3>
    
    <label>Passenger Name:</label><br>
    <input type="text" name="pname" required style="width: 100%; margin-bottom: 10px;"><br>
    
    <label>Train Name:</label><br>
    <input type="text" name="tname" required style="width: 100%; margin-bottom: 10px;"><br>
    
    <label>Age:</label><br>
    <input type="number" name="age" required style="width: 100%; margin-bottom: 10px;"><br>
    
    <label>Gender:</label><br>
    <select name="gender" style="width: 100%; margin-bottom: 20px;">
        <option value="Male">Male</option>
        <option value="Female">Female</option>
        <option value="Other">Other</option>
    </select><br>
    
    <button type="submit" style="background: #00f2ff; color: black; border: none; padding: 10px; width: 100%; cursor: pointer; font-weight: bold;">CONFIRM BOOKING</button>
</form>