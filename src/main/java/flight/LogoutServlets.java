package flight;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LogoutServlets") // Check karo ye naam unique ho
public class LogoutServlets extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Session khatam
        }
        
        // Direct login page pe bhej do
        response.sendRedirect("flight/login.html");
    }
}