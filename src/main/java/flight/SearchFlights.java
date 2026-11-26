package flight;

import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/SearchFlights")
public class SearchFlights extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        
        List<Map<String, String>> searchResult = new ArrayList<>();
        
        try (Connection con = DBConnection.getConnection()) {
            // Dam wala Search Query: Case-insensitive search
            String sql = "SELECT * FROM flights WHERE LOWER(source) = LOWER(?) AND LOWER(destination) = LOWER(?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, from);
            pst.setString(2, to);
            
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Map<String, String> f = new HashMap<>();
                f.put("id", rs.getString("flight_id"));
                f.put("name", rs.getString("f_name"));
                f.put("source", rs.getString("source"));
                f.put("dest", rs.getString("destination"));
                f.put("time", rs.getString("departure_time"));
                f.put("price", rs.getString("price"));
                f.put("seats", rs.getString("seats_available"));
                searchResult.add(f);
            }
            
            request.setAttribute("allFlights", searchResult); // Reuse existing list JSP
            request.getRequestDispatcher("flight/all_flights_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Search Engine Failure: " + e.getMessage());
        }
    }
}