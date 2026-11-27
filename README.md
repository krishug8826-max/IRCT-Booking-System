# IRCT Booking System

A Java-based railway and flight booking demonstration application built with Jakarta Servlets, JSP, Apache Tomcat and PostgreSQL. The project brings train search and booking workflows together with a separate flight search and reservation flow.

> **Important:** This is an educational/demo project. Train and flight schedules are sample records, not live railway or airline inventory. It is not connected to IRCTC or any airline reservation network, and bookings do not create real-world tickets.

## Live Demo

- **Application:** https://irct-booking-system.onrender.com
- Hosting may take a short time to wake up when using a free service. Availability depends on the hosting provider and configured database.

## Features

### Railway module
- User registration and login
- Search and view available train schedules
- Submit train booking details
- View booking history and PNR-related information

### Flight module
- Flight registration and login flow
- Browse available demo flights
- Submit passenger details and reserve seats
- View confirmed flight tickets
- View and update profile details

### Technical features
- Java Servlets and JSP
- PostgreSQL database using the irct schema for this application's tables
- JDBC database access
- Maven WAR packaging
- Docker-based deployment on Apache Tomcat

## Technology Stack

| Layer | Technology |
|---|---|
| Backend | Java 17, Jakarta Servlet 6 |
| Frontend | JSP, HTML, CSS |
| Application server | Apache Tomcat 10.1 |
| Database | PostgreSQL |
| Database access | JDBC, PostgreSQL JDBC driver |
| Build | Maven |
| Deployment | Docker, Render |

## Project Structure

```text
IRCT/
├── database/
│   └── schema-postgresql.sql
├── src/
│   └── main/
│       ├── java/
│       │   ├── Railway servlet classes
│       │   └── flight/       Flight servlet classes
│       └── webapp/
│           ├── flight/       Flight JSP and HTML pages
│           └── WEB-INF/
├── Dockerfile
├── render.yaml
├── pom.xml
└── README.md
```

## Run Locally

### Requirements
- JDK 17
- Maven 3.8+
- PostgreSQL
- Apache Tomcat 10.1 (if deploying the WAR manually)

### 1. Clone the repository

```bash
git clone https://github.com/krishug8826-max/IRCT-Booking-System.git
cd IRCT-Booking-System
```

### 2. Create and prepare the database

Create a PostgreSQL database, then execute:

```text
database/schema-postgresql.sql
```

The application's tables are organized under the PostgreSQL irct schema. If you are using an existing database that contains unrelated applications' tables, keep those tables separate and do not drop or overwrite them.

The schema includes sample train and flight schedules for demonstration. They are not live schedules.

### 3. Configure environment variables

Set these environment variables for the application process:

| Variable | Description |
|---|---|
| DB_URL | PostgreSQL JDBC URL |
| DB_USER | PostgreSQL username |
| DB_PASSWORD | PostgreSQL password |

Example JDBC URL:

```text
jdbc:postgresql://HOST:PORT/DATABASE?sslmode=require&currentSchema=irct
```

Use the connection details supplied by your PostgreSQL provider. Do not commit database passwords, API keys, or other secrets to Git.

### 4. Build the application

```bash
mvn -B clean package
```

The build creates:

```text
target/ROOT.war
```

### 5. Deploy to Tomcat

Copy target/ROOT.war into the Tomcat webapps directory and start Tomcat. Configure the three database environment variables in the Tomcat hosting environment before starting the application.

## Deploy on Render

This repository includes a Dockerfile and render.yaml for deployment.

1. Push the project to GitHub.
2. In Render, create a new Blueprint or Web Service from this repository.
3. Configure DB_URL, DB_USER, and DB_PASSWORD in the service environment.
4. Keep secrets such as DB_PASSWORD in Render's environment settings; do not add them to source files.
5. Deploy and check the service logs if the application or database connection does not start.

A successful code deployment does not automatically execute SQL scripts in the database. Run the schema or any additional SQL scripts manually in the intended PostgreSQL database when required.

## Booking and Ticket Notes

- A successful flight reservation is stored in the irct.flight_reservations table and is associated with the selected flight.
- The flight ticket view is served through the application's ViewTickets flow after login.
- /ConfirmBooking is a form-submission endpoint; it is not intended to be opened directly as a ticket display page.
- Demo seat counts and schedules are for testing only. They do not guarantee actual travel availability.

## Security and Production Readiness

This repository is a learning project and should not be treated as a production booking platform without further security work. In particular:

- Review and migrate legacy password handling to a strong one-way password hash such as BCrypt or Argon2.
- Add CSRF protection to state-changing forms.
- Apply secure session-cookie settings and session renewal after authentication.
- Validate and encode all user-controlled data before displaying it.
- Add authorization checks to every booking, profile, and ticket operation.
- Use database constraints and transactions to prevent overbooking and inconsistent reservations.
- Configure HTTPS and keep all credentials outside the repository.

## Repository

GitHub: https://github.com/krishug8826-max/IRCT-Booking-System

## License

No license has been specified yet. Unless a license is added to this repository, all rights remain with the copyright holder.
