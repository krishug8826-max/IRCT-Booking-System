# IRCT Booking Demo
Java 17, Jakarta Servlet 6, JSP, Tomcat 10.1 and PostgreSQL.

## Database setup
Create a PostgreSQL database and run `database/schema-postgresql.sql` in its SQL console. The sample train and flight schedules are demo records only, not real-time railway or airline inventory.

Set these environment variables in the hosting dashboard:
- `DB_URL`: JDBC URL such as `jdbc:postgresql://HOST:PORT/DATABASE?sslmode=require`
- `DB_USER`: database username
- `DB_PASSWORD`: database password

Do not commit credentials or put them in source code.

## Build and deploy
Local build: `mvn -B clean package` (creates `target/ROOT.war`). The Dockerfile performs its own Maven build and runs the WAR on Tomcat 10.1 / Java 17.

## Important
Educational booking simulation only; not an official railway/airline booking service. Login currently uses the legacy plain-text password comparison and needs password hashing, CSRF protection, stronger session settings and additional validation before production use. Sample schedules are not live inventory.
