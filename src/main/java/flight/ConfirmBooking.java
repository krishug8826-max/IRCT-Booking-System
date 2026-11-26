package flight;

import java.io.*;
import java.sql.*;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ConfirmBooking")
public class ConfirmBooking extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fid = request.getParameter("flight_id");
        String uEmail = request.getParameter("u_email");
        String[] names = request.getParameterValues("p_name");
        String[] ages = request.getParameterValues("p_age");

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false); //  Transaction start

            // 1. Seat check and deduct in one go
            String updateSql = "UPDATE flights SET seats_available = seats_available - ? WHERE flight_id = ? AND seats_available >= ?";
            PreparedStatement pst1 = con.prepareStatement(updateSql);
            pst1.setInt(1, names.length);
            pst1.setString(2, fid);
            pst1.setInt(3, names.length);

            if (pst1.executeUpdate() > 0) {
                // 2. Insert reservations (Sequence handle karega res_id)
                String insSql = "INSERT INTO flight_reservations (user_email, flight_id, passenger_name, seat_no) VALUES (?, ?, ?, ?)";
                PreparedStatement pst2 = con.prepareStatement(insSql);
                Random r = new Random();
                
                for(int i=0; i<names.length; i++) {
                    pst2.setString(1, uEmail);
                    pst2.setString(2, fid);
                    pst2.setString(3, names[i] + " (" + ages[i] + ")");
                    pst2.setString(4, "N-" + (r.nextInt(150) + 1));
                    pst2.addBatch(); // Batch processing for speed
                }
                pst2.executeBatch();
                con.commit(); // Sab sahi toh Save!
                response.sendRedirect("ViewTickets");
            } else {
                con.rollback(); // Seats nahi hain toh cancel!
                response.getWriter().println("<script>alert('SOLD OUT! Capacity reached.'); window.location='AllFlights';</script>");
            }
        } catch (Exception e) { e.printStackTrace(); }
    }
}