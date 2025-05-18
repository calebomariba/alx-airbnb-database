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


# Airbnb Clone Backend Advanced SQL Scripts

This directory (`database-adv-script/`) contains advanced SQL scripts for the Airbnb Clone project backend, as part of the `alx-airbnb-database` repository. The scripts demonstrate complex SQL operations, including subqueries, based on the database schema defined in `database-script-0x01/schema.sql`.

## Files

- **`README.md`**: This file, documenting the directory and its contents.
- **`subqueries.sql`**: SQL file containing two subqueries (non-correlated and correlated).

## Overview

The `subqueries.sql` file includes:

1. **Non-Correlated Subquery**:
   - **Purpose**: Finds all properties with an average rating greater than 4.0.
   - **Tables**: `properties`, `reviews`.
   - **Description**: Uses a subquery to identify properties with an average rating > 4.0, then selects matching property details.

2. **Correlated Subquery**:
   - **Purpose**: Finds users who have made more than 3 bookings.
   - **Tables**: `users`, `bookings`.
   - **Description**: Uses a correlated subquery to count bookings per user, filtering for those with more than 3 bookings.

## Repository Structure

- **Repository**: `alx-airbnb-database`
- **Directory**: `database-adv-script/`
- **Files**:
  - `README.md`
  - `subqueries.sql`

## Usage

- **Execution**: Run the queries in `subqueries.sql` against the Airbnb Clone database.
- **Development**: Use these queries for backend API endpoints (e.g., GET /api/v1/properties, GET /api/v1/users).
- **Documentation**: Combine with `database-script-0x01/` and `alx-airbnb-project-documentation`.

## Related Documentation
- **Database Schema**: `database-script-0x01/schema.sql`
- **Project Documentation**: `alx-airbnb-project-documentation` (e.g., `requirements.md`)

## Contact

For questions or issues, please open an issue in the `alx-airbnb-database` repository or contact the repository owner.



# Airbnb Clone Backend Advanced SQL Scripts

This directory (`database-adv-script/`) contains advanced SQL scripts for the Airbnb Clone project backend, as part of the `alx-airbnb-database` repository. The scripts demonstrate complex SQL operations, including subqueries, aggregations, and window functions, based on the database schema defined in `database-script-0x01/schema.sql`.

## Files

- **`README.md`**: This file, documenting the directory and its contents.
- **`subqueries.sql`**: SQL file containing non-correlated and correlated subqueries.
- **`aggregations_and_window_functions.sql`**: SQL file containing queries with aggregation and window functions.

## Overview

### subqueries.sql
Contains two subqueries:
1. **Non-Correlated Subquery**: Finds properties with an average rating > 4.0 using `IN` and `AVG`.
2. **Correlated Subquery**: Finds users with more than 3 bookings using a correlated `COUNT`.

### aggregations_and_window_functions.sql
Contains two queries:
1. **Aggregation Query**:
   - **Purpose**: Finds the total number of bookings per user.
   - **Tables**: `users`, `bookings`.
   - **Description**: Uses `COUNT` and `GROUP BY` to tally bookings, including users with zero bookings via `LEFT JOIN`.
2. **Window Function Query**:
   - **Purpose**: Ranks properties by the total number of bookings.
   - **Tables**: `properties`, `bookings`.
   - **Description**: Uses `RANK` over booking counts to assign rankings, with `LEFT JOIN` to include all properties.

## Repository Structure

- **Repository**: `alx-airbnb-database`
- **Directory**: `database-adv-script/`
- **Files**:
  - `README.md`
  - `subqueries.sql`
  - `aggregations_and_window_functions.sql`

## Usage

- **Execution**: Run the queries in `subqueries.sql` and `aggregations_and_window_functions.sql` against the Airbnb Clone database to retrieve data for analysis or application logic.
- **Development**: Use these queries as a reference for building backend API endpoints (e.g., GET /api/v1/users with booking counts, GET /api/v1/properties with rankings).
- **Documentation**: Combine with `database-script-0x01/` and `alx-airbnb-project-documentation` (e.g., `requirements.md`, `data-flow-diagram/`) for comprehensive project documentation.

## Related Documentation
- **Database Schema**: `database-script-0x01/schema.sql`
- **Project Documentation**: `alx-airbnb-project-documentation` (e.g., `features-and-functionalities/`, `requirements.md`)

## Contact

For questions or issues, please open an issue in the `alx-airbnb-database` repository or contact the repository owner.