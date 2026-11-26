import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/PnrServlet")
public class PnrServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pnrInput = request.getParameter("pnr"); 

        try {
        	Connection con = DBConn.getConnection();

            String sql = "SELECT * FROM bookings WHERE PNR = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, pnrInput); 
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("finalPNR", rs.getString("PNR"));
                request.setAttribute("pNames", rs.getString("P_NAMES")); 
                request.setAttribute("tName", rs.getString("T_NAME"));
                request.setAttribute("tNo", rs.getString("T_NO"));
                request.setAttribute("status", rs.getString("STATUS"));
                
                request.getRequestDispatcher("success.jsp").forward(request, response);
            } else {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('PNR NOT FOUND IN DATABASE'); window.location='index.jsp';</script>");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}