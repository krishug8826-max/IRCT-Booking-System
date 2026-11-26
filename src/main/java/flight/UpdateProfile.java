package flight;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        try (Connection con = DBConnection.getConnection()) {
            // Tumhare DESC users ke hisaab se update
            String sql = "UPDATE users SET fname=?, lname=?, phone=? WHERE email=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, fname);
            pst.setString(2, lname);
            pst.setString(3, phone);
            pst.setString(4, email);

            int rows = pst.executeUpdate();
            if(rows > 0) {
                // Redirect is important for fresh data!
                response.sendRedirect("ProfileServlet?status=success");
            } else {
                response.sendRedirect("ProfileServlet?status=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Update Engine Failure: " + e.getMessage());
        }
    }
}