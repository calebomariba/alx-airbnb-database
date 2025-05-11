# Airbnb Database Schema

This directory (`database-script-0x01`) contains the SQL schema definition for the Airbnb database, as part of the `alx-airbnb-database` project. The schema is designed to support the core functionality of an Airbnb-like platform, including users, properties, bookings, payments, reviews, and messages.

## Files

- **`schema.sql`**: SQL script to create the database tables, constraints, and indexes.
- **`README.md`**: This file, documenting the directory and usage instructions.

## Schema Overview

The schema defines the following tables, normalized to the Third Normal Form (3NF):

- **users**: Stores user information (e.g., name, email, role).
- **locations**: Stores structured location data (city, state, country).
- **properties**: Stores property details (e.g., name, price per night, host, location).
- **bookings**: Stores booking details (e.g., user, property, dates, total price).
- **payments**: Stores payment records for bookings.
- **reviews**: Stores user reviews for properties (rating, comment).
- **messages**: Stores messages between users (sender, recipient, message body).

The schema includes:
- **Primary and Foreign Keys**: To ensure referential integrity.
- **Unique Constraints**: On `users.email`.
- **Check Constraints**: On `reviews.rating` (1–5) and `bookings` dates.
- **ENUM Types**: For `role`, `status`, and `payment_method`.
- **Indexes**: For performance optimization on frequently queried columns.
- **Trigger**: To update `properties.updated_at` on row updates.

## Prerequisites

- **Database**: PostgreSQL (version 10 or later recommended).
- **Extensions**: The `uuid-ossp` extension for UUID generation.
- **Permissions**: User with privileges to create tables, types, and indexes.

## Usage

To create the database schema:

1. **Set up PostgreSQL**:
   - Ensure PostgreSQL is installed and running.
   - Create a database: `CREATE DATABASE airbnb;`

2. **Connect to the database**:
   - Use a PostgreSQL client (e.g., `psql`, pgAdmin).
   - Connect to the `airbnb` database: `\c airbnb`

3. **Run the schema script**:
   - Execute the `schema.sql` script:
     ```bash
     psql -U your_username -d airbnb -f schema.sql
     ```
   - Alternatively, copy and paste the script into your SQL client.

4. **Verify the schema**:
   - Check that all tables, constraints, and indexes were created:
     ```sql
     \dt
     \d+ table_name
     ```

## Notes

- **SQL Dialect**: The script uses PostgreSQL syntax. For other databases (e.g., MySQL), modifications may be needed (e.g., ENUM types, UUID support).
- **Data Population**: The script only creates the schema. To add sample data, create separate INSERT statements.
- **Error Handling**: Ensure the `uuid-ossp` extension is enabled before running the script (`CREATE EXTENSION "uuid-ossp";`).
- **Customization**: Adjust VARCHAR lengths or DECIMAL precision based on specific requirements.

## Repository Structure

- **Repository**: `alx-airbnb-database`
- **Directory**: `database-script-0x01`
- **Files**:
  - `schema.sql`
  - `README.md`

For additional documentation, see the `normalization.md` file in the repository root for details on the normalization process.

## Contact

For questions or issues, please open an issue in the `alx-airbnb-database` repository.