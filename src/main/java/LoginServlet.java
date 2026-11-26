import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        try {
        	Connection con = DBConn.getConnection();

            // Hum 'userss' table se data nikal rahe hain jaisa tumne DESC me dikhaya tha
            String sql = "SELECT NAME FROM userss WHERE USERNAME=? AND PASSWORD=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // SUCCESS: Create Session
                HttpSession session = request.getSession();
                
                // DASHBOARD FIX: 'user_name' set karna zaroori hai
                session.setAttribute("user_name", rs.getString("NAME")); 
                
                // Redirect to Dashboard
                response.sendRedirect("dashboard.jsp");
            } else {
                // FAILURE: DAM Style Error Page
                out.println("<html><head><style>");
                out.println("body { background: #000; color: #ff00ea; font-family: 'Orbitron', sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; text-align: center; }");
                out.println(".error-box { border: 2px solid #ff00ea; padding: 40px; border-radius: 20px; box-shadow: 0 0 30px #ff00ea; background: rgba(10,0,10,0.9); }");
                out.println(".btn { color: #00f2ff; text-decoration: none; border: 1px solid #00f2ff; padding: 10px 20px; margin-top: 20px; display: inline-block; border-radius: 5px; }");
                out.println("</style></head><body>");
                out.println("<div class='error-box'>");
                out.println("<h1>ACCESS DENIED</h1>");
                out.println("<p>INVALID CREDENTIALS DETECTED IN THE DATABASE</p>");
                out.println("<a href='login.html' class='btn'>RE-AUTHENTICATE</a>");
                out.println("</div></body></html>");
            }
            con.close();

        } catch (Exception e) {
            out.println("<div style='color:red; background:black; padding:20px; border:1px solid red;'>");
            out.println("<h3>DATABASE CONNECTION FAILURE</h3>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("</div>");
        }
    }
}