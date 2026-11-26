package flight;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user_email");
        
        if(email == null) {
            response.sendRedirect("flight/login.html");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT fname, lname, email, phone FROM users WHERE email = ?"; 
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                request.setAttribute("fname", rs.getString("fname")); 
                request.setAttribute("lname", rs.getString("lname"));
                request.setAttribute("u_name", rs.getString("fname") + " " + rs.getString("lname"));
                request.setAttribute("u_email", rs.getString("email"));
                request.setAttribute("u_phone", rs.getString("phone"));
                
                // Status message check (Redirect ke baad wala)
                String status = request.getParameter("status");
                if("success".equals(status)) {
                    request.setAttribute("msg", "PROFILE SYNCED SUCCESSFULLY");
                }

                request.getRequestDispatcher("flight/profile.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Taaki UpdateProfile se data yahan aa sake
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}