# Airbnb Database Normalization

This file outlines the process of normalizing the Airbnb database schema to ensure it adheres to the **Third Normal Form (3NF)**. The goal is to eliminate data redundancy, avoid anomalies during data operations, and ensure all tables comply with normalization principles. Below, we review the original schema, analyze it against the First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF), and describe the changes made to achieve 3NF.

## Original Schema

The original schema includes the following tables:

### User
- **user_id**: UUID (Primary Key, Indexed)
- **first_name**: VARCHAR (NOT NULL)
- **last_name**: VARCHAR (NOT NULL)
- **email**: VARCHAR (UNIQUE, NOT NULL)
- **password_hash**: VARCHAR (NOT NULL)
- **phone_number**: VARCHAR (NULL)
- **role**: ENUM (guest, host, admin) (NOT NULL)
- **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

### Property
- **property_id**: UUID (Primary Key, Indexed)
- **host_id**: UUID (Foreign Key, references User(user_id))
- **name**: VARCHAR (NOT NULL)
- **description**: TEXT (NOT NULL)
- **location**: VARCHAR (NOT NULL)
- **pricepernight**: DECIMAL (NOT NULL)
- **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
- **updated_at**: TIMESTAMP (ON UPDATE CURRENT_TIMESTAMP)

### Booking
- **booking_id**: UUID (Primary Key, Indexed)
- **property_id**: UUID (Foreign Key, references Property(property_id))
- **user_id**: UUID (Foreign Key, references User(user_id))
- **start_date**: DATE (NOT NULL)
- **end_date**: DATE (NOT NULL)
- **total_price**: DECIMAL (NOT NULL)
- **status**: ENUM (pending, confirmed, canceled) (NOT NULL)
- **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

### Payment
- **payment_id**: UUID (Primary Key, Indexed)
- **booking_id**: UUID (Foreign Key, references Booking(booking_id))
- **amount**: DECIMAL (NOT NULL)
- **payment_date**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
- **payment_method**: ENUM (credit_card, paypal, stripe) (NOT NULL)

### Review
- **review_id**: UUID (Primary Key, Indexed)
- **property_id**: UUID (Foreign Key, references Property(property_id))
- **user_id**: UUID (Foreign Key, references User(user_id))
- **rating**: INTEGER (CHECK: rating >= 1 AND rating <= 5, NOT NULL)
- **comment**: TEXT (NOT NULL)
- **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

### Message
- **message_id**: UUID (Primary Key, Indexed)
- **sender_id**: UUID (Foreign Key, references User(user_id))
- **recipient_id**: UUID (Foreign Key, references User(user_id))
- **message_body**: TEXT (NOT NULL)
- **sent_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

## Normalization Process

Normalization ensures the database adheres to the following normal forms:

- **First Normal Form (1NF)**: Atomic attributes, primary keys, and no repeating groups.
- **Second Normal Form (2NF)**: 1NF plus no partial dependencies (all non-key attributes depend on the entire primary key).
- **Third Normal Form (3NF)**: 2NF plus no transitive dependencies (non-key attributes depend only on the primary key).

### 1NF Analysis
- **Atomic Attributes**: All attributes (e.g., `first_name`, `location`, `rating`) are atomic, with no multi-valued or composite fields.
- **Primary Keys**: Each table has a unique primary key (e.g., `user_id`, `property_id`).
- **No Repeating Groups**: No attributes contain lists or arrays (e.g., `phone_number` stores a single value).
- **Conclusion**: The schema is in 1NF.

### 2NF Analysis
- **Single Primary Keys**: All tables have single-column primary keys (e.g., `user_id`, `booking_id`), so partial dependencies are not applicable.
- **Functional Dependencies**: All non-key attributes depend fully on the primary key (e.g., `email` depends on `user_id`, `pricepernight` depends on `property_id`).
- **Conclusion**: The schema is in 2NF, as there are no composite keys or partial dependencies.

### 3NF Analysis
- **Transitive Dependencies**: We checked for non-key attributes depending on other non-key attributes.
- **Table-by-Table Analysis**:
  - **User**: All attributes (e.g., `first_name`, `email`) depend on `user_id`. No transitive dependencies. **3NF compliant**.
  - **Property**: Attributes depend on `property_id`. The `location` attribute (VARCHAR) could imply transitive dependencies if it contains structured data (e.g., city → state → country). **Action needed**.
  - **Booking**: Attributes depend on `booking_id`. `total_price` is a snapshot value (not dynamically calculated), so it does not introduce redundancy. **3NF compliant**.
  - **Payment**: Attributes depend on `payment_id`. No transitive dependencies. **3NF compliant**.
  - **Review**: Attributes depend on `review_id`. No transitive dependencies. **3NF compliant**.
  - **Message**: Attributes depend on `message_id`. No transitive dependencies. **3NF compliant**.

#### Issue Identified
- **Property.location**: If `location` contains structured data (e.g., “New York, NY, USA”), it could introduce transitive dependencies (e.g., city determines state). To ensure 3NF, we split `location` into a separate `Location` table.

### Normalization Changes
To achieve 3NF, we made the following changes:

1. **Created a `Location` Table**:
   - **Purpose**: Store structured location data (`city`, `state`, `country`) to eliminate potential transitive dependencies.
   - **Schema**:
     - **location_id**: UUID (Primary Key, Indexed)
     - **city**: VARCHAR (NOT NULL)
     - **state**: VARCHAR (NULL, for countries without states)
     - **country**: VARCHAR (NOT NULL)
     - **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

2. **Updated the `Property` Table**:
   - Replaced `location` (VARCHAR) with:
     - **location_id**: UUID (Foreign Key, references Location(location_id))
   - **Updated Schema**:
     - **property_id**: UUID (Primary Key, Indexed)
     - **host_id**: UUID (Foreign Key, references User(user_id))
     - **location_id**: UUID (Foreign Key, references Location(location_id))
     - **name**: VARCHAR (NOT NULL)
     - **description**: TEXT (NOT NULL)
     - **pricepernight**: DECIMAL (NOT NULL)
     - **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
     - **updated_at**: TIMESTAMP (ON UPDATE CURRENT_TIMESTAMP)

3. **Booking Table**:
   - Retained `total_price` as a snapshot value (not dynamically calculated) to preserve historical pricing data, which is common in booking systems. This avoids redundancy while maintaining auditability.

### Rationale
- **Location Table**: Splitting `location` into `city`, `state`, and `country` and storing them in a separate table ensures that each attribute depends only on `location_id`, eliminating transitive dependencies (e.g., city → state). It also reduces redundancy if multiple properties share the same location.
- **Booking.total_price**: Storing `total_price` as a fixed value (snapshot) is acceptable in 3NF, as it does not depend on other non-key attributes and serves a business purpose (audit trail).

## Final Normalized Schema

The normalized schema is as follows:

### User
- **user_id**: UUID (Primary Key, Indexed)
- **first_name**: VARCHAR (NOT NULL)
- **last_name**: VARCHAR (NOT NULL)
- **email**: VARCHAR (UNIQUE, NOT NULL)
- **password_hash**: VARCHAR (NOT NULL)
- **phone_number**: VARCHAR (NULL)
- **role**: ENUM (guest, host, admin) (NOT NULL)
- **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

### Location
- **location_id**: UUID (Primary Key, Indexed)
- **city**: VARCHAR (NOT NULL)
- **state**: VARCHAR (NULL)
- **country**: VARCHAR (NOT NULL)
- **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

### Property
- **property_id**: UUID (Primary Key, Indexed)
- **host_id**: UUID (Foreign Key, references User(user_id))
- **location_id**: UUID (Foreign Key, references Location(location_id))
- **name**: VARCHAR (NOT NULL)
- **description**: TEXT (NOT NULL)
- **pricepernight**: DECIMAL (NOT NULL)
- **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
- **updated_at**: TIMESTAMP (ON UPDATE CURRENT_TIMESTAMP)

### Booking
- **booking_id**: UUID (Primary Key, Indexed)
- **property_id**: UUID (Foreign Key, references Property(property_id))
- **user_id**: UUID (Foreign Key, references User(user_id))
- **start_date**: DATE (NOT NULL)
- **end_date**: DATE (NOT NULL)
- **total_price**: DECIMAL (NOT NULL, snapshot value)
- **status**: ENUM (pending, confirmed, canceled) (NOT NULL)
- **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

### Payment
- **payment_id**: UUID (Primary Key, Indexed)
- **booking_id**: UUID (Foreign Key, references Booking(booking_id))
- **amount**: DECIMAL (NOT NULL)
- **payment_date**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
- **payment_method**: ENUM (credit_card, paypal, stripe) (NOT NULL)

### Review
- **review_id**: UUID (Primary Key, Indexed)
- **property_id**: UUID (Foreign Key, references Property(property_id))
- **user_id**: UUID (Foreign Key, references User(user_id))
- **rating**: INTEGER (CHECK: rating >= 1 AND rating <= 5, NOT NULL)
- **comment**: TEXT (NOT NULL)
- **created_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

### Message
- **message_id**: UUID (Primary Key, Indexed)
- **sender_id**: UUID (Foreign Key, references User(user_id))
- **recipient_id**: UUID (Foreign Key, references User(user_id))
- **message_body**: TEXT (NOT NULL)
- **sent_at**: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

## Updated Constraints
- **New Foreign Key**:
  - `Property.location_id` references `Location(location_id)`.
- **Indexes**:
  - Added index on `Property.location_id` for efficient queries.
  - Existing indexes (e.g., primary keys, `User.email`) remain unchanged.

## Updated ERD (Mermaid Syntax)

The following Mermaid code reflects the normalized schema:

```mermaid
erDiagram
    USER ||--o{ PROPERTY : hosts
    USER ||--o{ BOOKING : books
    USER ||--o{ REVIEW : writes
    USER ||--o{ MESSAGE : sends
    USER ||--o{ MESSAGE : receives
    LOCATION ||--o{ PROPERTY : located_at
    PROPERTY ||--o{ BOOKING : booked
    PROPERTY ||--o{ REVIEW : reviewed
    BOOKING ||--o{ PAYMENT : paid

    USER {
        UUID user_id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR email UK
        VARCHAR password_hash
        VARCHAR phone_number
        ENUM role
        TIMESTAMP created_at
    }
    LOCATION {
        UUID location_id PK
        VARCHAR city
        VARCHAR state
        VARCHAR country
        TIMESTAMP created_at
    }
    PROPERTY {
        UUID property_id PK
        UUID host_id FK
        UUID location_id FK
        VARCHAR name
        TEXT description
        DECIMAL pricepernight
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    BOOKING {
        UUID booking_id PK
        UUID property_id FK
        UUID user_id FK
        DATE start_date
        DATE end_date
        DECIMAL total_price
        ENUM status
        TIMESTAMP created_at
    }
    PAYMENT {
        UUID payment_id PK
        UUID booking_id FK
        DECIMAL amount
        TIMESTAMP payment_date
        ENUM payment_method
    }
    REVIEW {
        UUID review_id PK
        UUID property_id FK
        UUID user_id FK
        INTEGER rating
        TEXT comment
        TIMESTAMP created_at
    }
    MESSAGE {
        UUID message_id PK
        UUID sender_id FK
        UUID recipient_id FK
        TEXT message_body
        TIMESTAMP sent_at
    }