package flight;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBConnection {
    public static Connection getConnection() throws SQLException {
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");
        if (url == null || url.isBlank() || user == null || password == null) {
            throw new SQLException("Database configuration missing. Set DB_URL, DB_USER and DB_PASSWORD.");
        }
        try {
            // Tomcat may load WAR-local JDBC drivers after its global driver scan.
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL JDBC driver is missing from WEB-INF/lib.", e);
        }
        return DriverManager.getConnection(url, user, password);
    }
}
