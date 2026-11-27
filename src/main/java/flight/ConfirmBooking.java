package flight;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ConfirmBooking")
public class ConfirmBooking extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String userEmail = session == null ? null : (String) session.getAttribute("user_email");
        String flightIdText = request.getParameter("flight_id");
        String[] names = request.getParameterValues("p_name");
        String[] ages = request.getParameterValues("p_age");

        if (userEmail == null || userEmail.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/flight/login.html");
            return;
        }

        final long flightId;
        try {
            flightId = Long.parseLong(flightIdText);
        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid flight selection. Please choose the flight again.");
            return;
        }

        if (names == null || ages == null || names.length == 0 || names.length != ages.length || names.length > 5) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Please enter valid passenger details (maximum 5 passengers).");
            return;
        }
        for (int i = 0; i < names.length; i++) {
            if (names[i] == null || names[i].isBlank() || ages[i] == null || !ages[i].matches("\\d{1,3}")) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Please enter a valid name and age for every passenger.");
                return;
            }
        }

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);
            try {
                String updateSql = "UPDATE flights SET seats_available = seats_available - ? "
                        + "WHERE flight_id = ? AND seats_available >= ?";
                try (PreparedStatement update = con.prepareStatement(updateSql)) {
                    update.setInt(1, names.length);
                    // PostgreSQL flight_id is BIGINT; bind it as a number, not VARCHAR.
                    update.setLong(2, flightId);
                    update.setInt(3, names.length);

                    if (update.executeUpdate() != 1) {
                        con.rollback();
                        response.sendError(HttpServletResponse.SC_CONFLICT,
                                "This flight is sold out or no longer available. Please choose another flight.");
                        return;
                    }
                }

                String insertSql = "INSERT INTO flight_reservations "
                        + "(user_email, flight_id, passenger_name, seat_no) VALUES (?, ?, ?, ?)";
                try (PreparedStatement insert = con.prepareStatement(insertSql)) {
                    for (int i = 0; i < names.length; i++) {
                        insert.setString(1, userEmail);
                        // Keep the BIGINT type consistent with flights.flight_id.
                        insert.setLong(2, flightId);
                        insert.setString(3, names[i].trim() + " (" + ages[i].trim() + ")");
                        insert.setString(4, "N-" + (int) (Math.random() * 150 + 1));
                        insert.addBatch();
                    }
                    insert.executeBatch();
                }

                con.commit();
            } catch (Exception ex) {
                con.rollback();
                throw ex;
            }
        } catch (Exception ex) {
            getServletContext().log("Flight ticket confirmation failed for flight_id=" + flightId, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Your ticket could not be confirmed. No booking was saved. Please try again.");
            return;
        }

        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/ViewTickets"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED,
                "This is a booking form endpoint. Submit the flight booking form to confirm a ticket.");
    }
}
