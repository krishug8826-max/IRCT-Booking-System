package flight;

import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/MyTickets")
public class MyTickets extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("user_email");

        // Agar session mein email nahi hai toh login pe bhej do
        if (userEmail == null) {
            response.sendRedirect("flight/login.html");
            return;
        }

        List<Map<String, String>> ticketList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            // Hum 'flights' table ke saath JOIN kar rahe hain taaki Flight Name aur Time bhi dikha sakein
            String sql = "SELECT r.res_id, f.f_name, f.source, f.destination, f.departure_time, r.passenger_name, r.seat_no " +
                         "FROM flight_reservations r " +
                         "JOIN flights f ON r.flight_id = f.flight_id " +
                         "WHERE r.user_email = ? ORDER BY r.created_at DESC";
            
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, userEmail);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Map<String, String> ticket = new HashMap<>();
                ticket.put("res_id", rs.getString("res_id"));
                ticket.put("f_name", rs.getString("f_name"));
                ticket.put("source", rs.getString("source"));
                ticket.put("dest", rs.getString("destination"));
                ticket.put("time", rs.getString("departure_time"));
                ticket.put("passenger", rs.getString("passenger_name"));
                ticket.put("seat", rs.getString("seat_no"));
                ticketList.add(ticket);
            }

            request.setAttribute("myTickets", ticketList);
            request.getRequestDispatcher("flight/my_tickets.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error fetching tickets: " + e.getMessage());
        }
    }
}