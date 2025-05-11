# Airbnb Database Entity-Relationship Diagram (ERD)

This document describes the Entity-Relationship Diagram (ERD) for the Airbnb database, including entities, attributes, relationships, constraints, and a visual layout. A Mermaid syntax representation is provided for rendering the diagram in compatible tools.

## Entity-Relationship Diagram Description

### Entities and Attributes

The ERD includes the following entities, each with their attributes. Primary keys are underlined, foreign keys are italicized, and constraints are noted.

#### User
- `_user_id_`: UUID (Primary Key, Indexed)
- `first_name`: VARCHAR (NOT NULL)
- `last_name`: VARCHAR (NOT NULL)
- `email`: VARCHAR (UNIQUE, NOT NULL)
- `password_hash`: VARCHAR (NOT NULL)
- `phone_number`: VARCHAR (NULL)
- `role`: ENUM (guest, host, admin) (NOT NULL)
- `created_at`: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

#### Property
- `_property_id_`: UUID (Primary Key, Indexed)
- `_host_id_`: UUID (Foreign Key, references User(user_id))
- `name`: VARCHAR (NOT NULL)
- `description`: TEXT (NOT NULL)
- `location`: VARCHAR (NOT NULL)
- `pricepernight`: DECIMAL (NOT NULL)
- `created_at`: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
- `updated_at`: TIMESTAMP (ON UPDATE CURRENT_TIMESTAMP)

#### Booking
- `_booking_id_`: UUID (Primary Key, Indexed)
- `_property_id_`: UUID (Foreign Key, references Property(property_id))
- `_user_id_`: UUID (Foreign Key, references User(user_id))
- `start_date`: DATE (NOT NULL)
- `end_date`: DATE (NOT NULL)
- `total_price`: DECIMAL (NOT NULL)
- `status`: ENUM (pending, confirmed, canceled) (NOT NULL)
- `created_at`: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

#### Payment
- `_payment_id_`: UUID (Primary Key, Indexed)
- `_booking_id_`: UUID (Foreign Key, references Booking(booking_id))
- `amount`: DECIMAL (NOT NULL)
- `payment_date`: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
- `payment_method`: ENUM (credit_card, paypal, stripe) (NOT NULL)

#### Review
- `_review_id_`: UUID (Primary Key, Indexed)
- `_property_id_`: UUID (Foreign Key, references Property(property_id))
- `_user_id_`: UUID (Foreign Key, references User(user_id))
- `rating`: INTEGER (CHECK: rating >= 1 AND rating <= 5, NOT NULL)
- `comment`: TEXT (NOT NULL)
- `created_at`: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

#### Message
- `_message_id_`: UUID (Primary Key, Indexed)
- `_sender_id_`: UUID (Foreign Key, references User(user_id))
- `_recipient_id_`: UUID (Foreign Key, references User(user_id))
- `message_body`: TEXT (NOT NULL)
- `sent_at`: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

### Relationships

The relationships between entities are based on foreign key constraints and logical connections in the Airbnb system. Each relationship is described with cardinality (e.g., one-to-many, many-to-one).

#### User - Property (Host)
- **Relationship**: A User (with role 'host') can host multiple Properties, but each Property is associated with exactly one User (host).
- **Cardinality**: One-to-Many (1:N)
- **Foreign Key**: Property.host_id references User.user_id
- **Representation**: A line from User to Property with a crow’s foot (many) on the Property side.

#### User - Booking (Guest)
- **Relationship**: A User (typically with role 'guest') can make multiple Bookings, but each Booking is associated with exactly one User.
- **Cardinality**: One-to-Many (1:N)
- **Foreign Key**: Booking.user_id references User.user_id
- **Representation**: A line from User to Booking with a crow’s foot on the Booking side.

#### Property - Booking
- **Relationship**: A Property can have multiple Bookings, but each Booking is associated with exactly one Property.
- **Cardinality**: One-to-Many (1:N)
- **Foreign Key**: Booking.property_id references Property.property_id
- **Representation**: A line from Property to Booking with a crow’s foot on the Booking side.

#### Booking - Payment
- **Relationship**: A Booking can have multiple Payments (e.g., partial payments or refunds), but each Payment is associated with exactly one Booking.
- **Cardinality**: One-to-Many (1:N)
- **Foreign Key**: Payment.booking_id references Booking.booking_id
- **Representation**: A line from Booking to Payment with a crow’s foot on the Payment side.

#### Property - Review
- **Relationship**: A Property can have multiple Reviews, but each Review is associated with exactly one Property.
- **Cardinality**: One-to-Many (1:N)
- **Foreign Key**: Review.property_id references Property.property_id
- **Representation**: A line from Property to Review with a crow’s foot on the Review side.

#### User - Review
- **Relationship**: A User can write multiple Reviews, but each Review is written by exactly one User.
- **Cardinality**: One-to-Many (1:N)
- **Foreign Key**: Review.user_id references User.user_id
- **Representation**: A line from User to Review with a crow’s foot on the Review side.

#### User - Message (Sender and Recipient)
- **Relationship**: A User can send multiple Messages and receive multiple Messages. Each Message has exactly one sender and one recipient, both of which are Users.
- **Cardinality**:
  - One-to-Many (1:N) for sender (User to Message via sender_id)
  - One-to-Many (1:N) for recipient (User to Message via recipient_id)
- **Foreign Keys**:
  - Message.sender_id references User.user_id
  - Message.recipient_id references User.user_id
- **Representation**:
  - A line from User to Message (labeled “sends”) with a crow’s foot on the Message side for sender_id.
  - A line from User to Message (labeled “receives”) with a crow’s foot on the Message side for recipient_id.

### Constraints

- **Unique Constraints**:
  - User.email is UNIQUE.
- **Non-Null Constraints**:
  - Applied to all NOT NULL fields as specified (e.g., User.first_name, Property.name, etc.).
- **Check Constraints**:
  - Review.rating must be between 1 and 5.
- **Enum Constraints**:
  - User.role: (guest, host, admin)
  - Booking.status: (pending, confirmed, canceled)
  - Payment.payment_method: (credit_card, paypal, stripe)
- **Foreign Key Constraints**:
  - Enforce referential integrity (e.g., Property.host_id must reference a valid User.user_id).
- **Indexes**:
  - Primary keys (user_id, property_id, etc.) are automatically indexed.
  - Additional indexes on:
    - User.email
    - Property.property_id (in Property and Booking tables)
    - Booking.booking_id (in Booking and Payment tables)

### Visual Layout

In the ERD:
- **Entities** are represented as rectangles with the entity name at the top and attributes listed inside.
- **Primary Keys** are underlined.
- **Foreign Keys** are italicized or marked with an asterisk.
- **Relationships** are shown as lines connecting entities:
  - A single line on the “one” side and a crow’s foot (three-pronged) on the “many” side.
  - Relationship names (e.g., “hosts”, “books”, “pays”) may be labeled on the lines for clarity.
- **Constraints** (e.g., UNIQUE, CHECK) are noted near the relevant attributes or relationships.

The layout could be organized as follows:
- Place **User** centrally, as it connects to most entities.
- Position **Property** and **Booking** nearby, forming a cluster for the core booking functionality.
- Place **Payment** and **Review** adjacent to **Booking** and **Property**, respectively.
- Position **Message** slightly apart, connected to **User** via two relationships (sender and recipient).



erDiagram
    USER ||--o{ PROPERTY : hosts
    USER ||--o{ BOOKING : books
    USER ||--o{ REVIEW : writes
    USER ||--o{ MESSAGE : sends
    USER ||--o{ MESSAGE : receives
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
    PROPERTY {
        UUID property_id PK
        UUID host_id FK
        VARCHAR name
        TEXT description
        VARCHAR location
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
