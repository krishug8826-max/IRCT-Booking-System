import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/SearchTrainServlet")
public class SearchTrainServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Form se data lena
        String source = request.getParameter("source").toUpperCase();
        String destination = request.getParameter("destination").toUpperCase();

        try {
            // 1. Database Connection
        	Connection con = DBConn.getConnection();

            // 2. SQL Query (Tumhare DESC trains ke column names ke sath)
            // Dhyaan do: SOURCE_STN aur DEST_STN use kiya hai yahan
            String sql = "SELECT * FROM trains WHERE SOURCE_STN=? AND DEST_STN=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, source);
            ps.setString(2, destination);
            
            ResultSet rs = ps.executeQuery();

            // 3. UI Design (DAM Style)
            out.println("<html><head>");
            out.println("<link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Rajdhani:wght@500&display=swap' rel='stylesheet'>");
            out.println("<style>");
            out.println("body { background: #020205; color: white; font-family: 'Rajdhani'; padding: 40px; text-align: center; }");
            out.println(".container { max-width: 900px; margin: auto; }");
            out.println("table { width: 100%; border-collapse: collapse; margin-top: 20px; background: rgba(255,255,255,0.02); }");
            out.println("th { font-family: 'Orbitron'; color: #00f2ff; border-bottom: 2px solid #00f2ff; padding: 15px; }");
            out.println("td { padding: 15px; border-bottom: 1px solid #222; }");
            out.println(".btn-book { background: #ff00ea; color: white; padding: 8px 15px; text-decoration: none; border-radius: 5px; font-family: 'Orbitron'; font-size: 10px; }");
            out.println("</style></head><body>");
            out.println("<div class='container'>");
            out.println("<h1 style='font-family:Orbitron; color:#00f2ff;'>AVAILABLE LOCOMOTIVES</h1>");
            out.println("<p>ROUTE: " + source + " TO " + destination + "</p>");

            out.println("<table>");
            out.println("<tr><th>TRAIN NO</th><th>NAME</th><th>DEPARTURE</th><th>PRICE</th><th>ACTION</th></tr>");

            boolean found = false;
            while (rs.next()) {
                found = true;
                out.println("<tr>");
                out.println("<td>" + rs.getString("T_NO") + "</td>");
                out.println("<td>" + rs.getString("T_NAME") + "</td>");
                out.println("<td>" + rs.getString("DEP_TIME") + "</td>");
                out.println("<td>₹" + rs.getString("PRICE") + "</td>");
                // Booking page par Train No aur Name bhejne ka link
                out.println("<td><a href='book_ticket.jsp?tno=" + rs.getString("T_NO") + "&tname=" + rs.getString("T_NAME") + "' class='btn-book'>INITIATE</a></td>");
                out.println("</tr>");
            }

            if (!found) {
                out.println("<tr><td colspan='5' style='color:red;'>NO TRAINS FOUND FOR THIS ROUTE</td></tr>");
            }

            out.println("</table>");
            out.println("<br><a href='dashboard.jsp' style='color:#888; text-decoration:none;'>[ BACK TO DASHBOARD ]</a>");
            out.println("</div></body></html>");

            con.close();

        } catch (Exception e) {
            // Error handling jo tumhare screenshot mein help karegi
            out.println("<div style='color:red; background:black; padding:20px; border:2px solid red;'>");
            out.println("<h2>SYSTEM ERROR</h2>");
            out.println("<p>Error Detail: " + e.getMessage() + "</p>");
            out.println("<p>Check: 1. Oracle Password 2. Table Column Names</p>");
            out.println("</div>");
        }
    }
}