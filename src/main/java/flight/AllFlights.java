package flight;

import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AllFlights")
public class AllFlights extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, String>> flightList = new ArrayList<>();
        // Connection handling: try-with-resources
        try (Connection con = DBConnection.getConnection()) {
            // Updated Query matching your schema
            String sql = "SELECT * FROM flights";
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                Map<String, String> f = new HashMap<>();
                f.put("id", rs.getString("flight_id"));
                f.put("name", rs.getString("f_name"));
                f.put("source", rs.getString("source"));
                f.put("dest", rs.getString("destination"));
                f.put("time", rs.getString("departure_time")); // F_DATE error fix
                f.put("price", rs.getString("price"));
                f.put("seats", rs.getString("seats_available"));
                flightList.add(f);
            }
            
            request.setAttribute("allFlights", flightList);
            // Path fix: direct flight folder ke andar
            request.getRequestDispatcher("flight/all_flights_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Error handling jo problem bata sake
            response.setContentType("text/html");
            response.getWriter().println("<h3 style='color:red;'>System Fault: " + e.getMessage() + "</h3>");
        }
    }
}