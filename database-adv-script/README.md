# Airbnb Clone Backend SQL Queries

This directory (`sql-queries/`) contains SQL queries for the Airbnb Clone project backend, as part of the `alx-airbnb-project-documentation` repository. The queries demonstrate complex operations using different types of joins, based on the database schema defined in `alx-airbnb-database`.

## Files

- **`README.md`**: This file, documenting the directory and its contents.
- **`complex_queries.sql`**: SQL file containing three complex queries using INNER JOIN, LEFT JOIN, and FULL OUTER JOIN.

## Overview

The `complex_queries.sql` file includes the following queries:

1. **INNER JOIN Query**:
   - **Purpose**: Retrieves all bookings and the respective users who made those bookings.
   - **Tables**: `bookings`, `users`.
   - **Description**: Joins `bookings` and `users` on `user_id` to fetch booking details (e.g., booking_id, start_date, total_price) and user details (e.g., first_name, email) for bookings with associated users.

2. **LEFT JOIN Query**:
   - **Purpose**: Retrieves all properties and their reviews, including properties that have no reviews.
   - **Tables**: `properties`, `reviews`.
   - **Description**: Uses a LEFT JOIN to include all properties, with review details (e.g., rating, comment) where available, and NULLs for properties without reviews.

3. **FULL OUTER JOIN Query**:
   - **Purpose**: Retrieves all users and all bookings, even if a user has no bookings or a booking is not linked to a user.
   - **Tables**: `users`, `bookings`.
   - **Description**: Uses a FULL OUTER JOIN to include all users and bookings, with NULLs for non-matching records (e.g., users without bookings or bookings without users, if applicable).

## Repository Structure

- **Repository**: `alx-airbnb-project-documentation`
- **Directory**: `sql-queries/`
- **Files**:
  - `README.md`
  - `complex_queries.sql`

## Usage

- **Execution**: Run the queries in `complex_queries.sql` against the Airbnb Clone database to retrieve data for analysis or application logic.
- **Development**: Use these queries as a reference for building backend API endpoints (e.g., GET /api/v1/bookings, GET /api/v1/properties).
- **Documentation**: Combine with `features-and-functionalities/`, `use-case-diagram/`, `user-stories/`, `data-flow-diagram/`, and `requirements.md` for comprehensive project documentation.

## Related Documentation
- **Database Schema**: `alx-airbnb-database/database-script-0x01/schema.sql`
- **Features and Functionalities**: `features-and-functionalities/README.md`
- **Requirement Specifications**: `requirements.md`

## Contact

For questions or issues, please open an issue in the `alx-airbnb-project-documentation` repository or contact the repository owner.