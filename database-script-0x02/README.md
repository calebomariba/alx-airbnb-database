# Airbnb Database Seed Data

This directory (`database-script-0x02`) contains the SQL script to populate the Airbnb database with sample data, as part of the `alx-airbnb-database` project. The sample data reflects real-world usage, including multiple users, properties, bookings, payments, reviews, and messages.

## Files

- **`seed.sql`**: SQL script to insert sample data into the database tables.
- **`README.md`**: This file, documenting the directory and usage instructions.

## Seed Data Overview

The `seed.sql` script populates the following tables with realistic sample data:

- **users**: 5 users (2 hosts, 2 guests, 1 admin) with unique emails and roles.
- **locations**: 3 locations (New York, Nairobi, London) with city, state, and country.
- **properties**: 4 properties owned by hosts, in different locations with varied prices.
- **bookings**: 5 bookings with different statuses (pending, confirmed, canceled).
- **payments**: 3 payments for confirmed bookings, using credit card, PayPal, and Stripe.
- **reviews**: 4 reviews for properties, with ratings (3–5) and comments.
- **messages**: 3 messages between users (e.g., booking inquiries, responses).

The data respects all schema constraints (e.g., foreign keys, ENUM values, rating checks) and uses realistic values (e.g., total_price calculated from pricepernight and stay duration).

## Prerequisites

- **Database**: PostgreSQL (version 10 or later recommended).
- **Schema**: The database schema must be created using `database-script-0x01/schema.sql`.
- **Extensions**: The `uuid-ossp` extension for UUID generation.
- **Permissions**: User with privileges to insert data.

## Usage

To populate the database with sample data:

1. **Set up PostgreSQL**:
   - Ensure PostgreSQL is installed and running.
   - Create a database if not already created: `CREATE DATABASE airbnb;`

2. **Apply the schema**:
   - Run the schema script from `database-script-0x01`:
     ```bash
     psql -U your_username -d airbnb -f ../database-script-0x01/schema.sql
     ```

3. **Connect to the database**:
   - Use a PostgreSQL client (e.g., `psql`, pgAdmin).
   - Connect to the `airbnb` database: `\c airbnb`

4. **Run the seed script**:
   - Execute the `seed.sql` script:
     ```bash
     psql -U your_username -d airbnb -f database-script-0x02/seed.sql
     ```
   - Alternatively, copy and paste the script into your SQL client.

5. **Verify the data**:
   - Check the inserted data:
     ```sql
     SELECT * FROM users;
     SELECT * FROM properties;
     ```
   - Verify row counts: `SELECT count(*) FROM table_name;`

## Notes

- **SQL Dialect**: The script uses PostgreSQL syntax. For other databases (e.g., MySQL), modifications may be needed (e.g., ENUM types, UUID support).
- **Dependencies**: Run `schema.sql` before `seed.sql` to create the tables and constraints.
- **Error Handling**: Ensure the `uuid-ossp` extension is enabled. If foreign key errors occur, verify that `schema.sql` was applied correctly.
- **Customization**: Adjust the sample data (e.g., add more users, change dates) based on specific testing needs.

## Repository Structure

- **Repository**: `alx-airbnb-database`
- **Directory**: `database-script-0x02`
- **Files**:
  - `seed.sql`
  - `README.md`

For additional documentation, see:
- `database-script-0x01/README.md` for schema creation.
- `normalization.md` in the repository root for normalization details.

## Contact

For questions or issues, please open an issue in the `alx-airbnb-database` repository or contact the repository owner.