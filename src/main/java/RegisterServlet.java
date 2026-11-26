import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // HTML form se saari details nikalna
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        
        try {
            // Database connection lena
            Connection con = DBConn.getConnection();
            
            // SQL Query: Table 'userss' mein data insert karne ke liye
            String query = "INSERT INTO userss (NAME, EMAIL, USERNAME, PASSWORD, PHONE, GENDER) VALUES (?, ?, ?, ?, ?, ?)";
            
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, user);
            ps.setString(4, pass);
            ps.setString(5, phone);
            ps.setString(6, gender);
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                // Registration successful! Login page par bhej do success message ke saath
                response.sendRedirect("login.html?status=registered");
            } else {
                // Kuch gadbad hui
                response.sendRedirect("register.html?error=failed");
            }
            
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            // Agar username pehle se hai ya koi database error hai
            response.sendRedirect("register.html?error=db_error");
        }
    }
}