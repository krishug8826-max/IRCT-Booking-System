package flight;

import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ViewTickets")
public class ViewTickets extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Login ke waqt jo email session mein save kiya tha
        String email = (String) session.getAttribute("user_email");

        if (email == null) {
            response.sendRedirect("login.html");
            return;
        }

        List<Map<String, String>> ticketList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            // Sirf current user ki tickets fetch karo
            // Hum 'flights' table se join kar rahe hain taaki flight ka naam dikh sake
            String sql = "SELECT r.res_id, r.passenger_name, r.seat_no, f.f_name " +
                         "FROM flight_reservations r " +
                         "JOIN flights f ON r.flight_id = f.flight_id " +
                         "WHERE r.user_email = ? " +
                         "ORDER BY r.res_id DESC";
            
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Map<String, String> t = new HashMap<>();
                t.put("res_id", rs.getString("res_id"));
                t.put("flight_name", rs.getString("f_name"));
                t.put("passenger", rs.getString("passenger_name"));
                t.put("seat", rs.getString("seat_no"));
                ticketList.add(t);
            }
            
            request.setAttribute("tickets", ticketList);
            request.getRequestDispatcher("flight/view_tickets.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("System Error: " + e.getMessage());
        }
    }
}