import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn {
    public static Connection getConnection() throws SQLException {
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");
        if (url == null || url.isBlank() || user == null || password == null) {
            throw new SQLException("Database configuration missing. Set DB_URL, DB_USER and DB_PASSWORD.");
        }
        return DriverManager.getConnection(url, user, password);
    }
}
