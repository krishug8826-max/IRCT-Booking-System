import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.Random;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String tNo = request.getParameter("tno");
        String tName = request.getParameter("tname");
        
        // Asli count hidden field se uthao
        String countStr = request.getParameter("pCount");
        int totalAgents = (countStr != null) ? Integer.parseInt(countStr) : 1;

        StringBuilder namesBuilder = new StringBuilder();
        
        // Loop chalao jitne agents hain
        for(int i = 1; i <= totalAgents; i++) {
            String name = request.getParameter("pname" + i);
            if(name != null && !name.trim().isEmpty()) {
                if(namesBuilder.length() > 0) namesBuilder.append(", ");
                namesBuilder.append(name.trim().toUpperCase());
            }
        }
        
        String finalNames = namesBuilder.toString();
        if(finalNames.isEmpty()) finalNames = "UNKNOWN_AGENT";

        String pnr = "PNR" + (1000000 + new Random().nextInt(9000000));

        try {
            Connection con = DBConn.getConnection();
            
            String sql = "INSERT INTO bookings (PNR, P_NAMES, T_NAME, T_NO, STATUS) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, pnr);
            ps.setString(2, finalNames);
            ps.setString(3, tName);
            ps.setString(4, tNo);
            ps.setString(5, "CONFIRMED");

            if (ps.executeUpdate() > 0) {
                request.setAttribute("finalPNR", pnr);
                request.setAttribute("pNames", finalNames);
                request.setAttribute("tName", tName);
                request.setAttribute("tNo", tNo);
                request.setAttribute("status", "CONFIRMED");
                request.getRequestDispatcher("success.jsp").forward(request, response);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
