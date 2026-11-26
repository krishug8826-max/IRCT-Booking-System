import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/BookingHistoryServlet")
public class BookingHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String agentName = (String) session.getAttribute("agentName"); 

        if (agentName == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, String>> ticketList = new ArrayList<>();

        try {
            Connection con = DBConn.getConnection();

            // Hum Agent Name ke basis par saari tickets nikal rahe hain
            // Note: Agar 'P_NAMES' mein multiple names hain toh 'LIKE' query best hai
            String sql = "SELECT * FROM bookings WHERE P_NAMES LIKE ? ORDER BY PNR DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + agentName + "%");
            
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> ticket = new HashMap<>();
                ticket.put("pnr", rs.getString("PNR"));
                ticket.put("names", rs.getString("P_NAMES"));
                ticket.put("tname", rs.getString("T_NAME"));
                ticket.put("tno", rs.getString("T_NO"));
                ticket.put("status", rs.getString("STATUS"));
                ticketList.add(ticket);
            }
            
            request.setAttribute("ticketList", ticketList);
            request.getRequestDispatcher("all_tickets.jsp").forward(request, response);
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
