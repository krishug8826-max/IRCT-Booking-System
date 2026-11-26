package flight;

import java.io.*;

import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginUser")
public class LoginUser extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Form se data nikalna
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        
        HttpSession session = request.getSession();

        try (Connection con = DBConnection.getConnection()) {
            // 2. Oracle SQL Query: Email aur Password check karne ke liye
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, pass);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // SUCCESS: Agar record mil gaya
                // User ka data session mein save kar lo taki dashboard pe dikha sakein
                session.setAttribute("user_id", rs.getInt("id"));
                session.setAttribute("user_name", rs.getString("fname"));
                session.setAttribute("user_email", rs.getString("email"));
               
                // Dashboard pe bhej do
                response.sendRedirect("flight/dashboard.jsp");
            } else {
                // FAILURE: Galat credentials
                // Login page pe wapas bhej do error message ke sath
                response.sendRedirect("flight/login.html?error=invalid_credentials");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("System Error: " + e.getMessage());
        }
    }
}