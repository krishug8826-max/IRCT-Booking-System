import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Session uthao
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            session.invalidate(); // Saara data delete (Session Destroyed)
        }
        
        // Seedha logout success page par bhej do
        response.sendRedirect("logout.jsp");
    }
}