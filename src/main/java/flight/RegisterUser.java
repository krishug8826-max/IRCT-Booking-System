package flight;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/RegisterUser")
public class RegisterUser extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Form parameters (HTML names se match hone chahiye)
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String phone = request.getParameter("phone");

        try (Connection con = DBConnection.getConnection()) {
            // Sequence aur Trigger table mein set hai, toh hume ID ki tension nahi
            String sql = "INSERT INTO users (fname, lname, email, password, phone) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, fname);
            pst.setString(2, lname);
            pst.setString(3, email);
            pst.setString(4, pass);
            pst.setString(5, phone);

            int status = pst.executeUpdate();

            if (status > 0) {
                // Success: Login page pe redirect (Jo webapp folder mein hai)
                response.sendRedirect("flight/login.html?reg=success");
            } else {
                response.sendRedirect("registration.jsp?error=fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("Technical Error: " + e.getMessage());
        }
    }
}