# Library Management System

## Overview
This is a simple Library Management System project using **PostgreSQL** on **Supabase**. It allows tracking of authors, books, and patrons, along with basic CRUD operations.


## Project Structure
**setup.sql** - Creates the database tables ('authors', 'books', 'patrons').  
**insert_data.sql** - Inserts sample data into the tables.  
**queries.sql** - Example CRUD operations (SELECT, UPDATE, DELETE) to test the database.

### 'authors'
| Column     | Type    | Description                  |
|------------|---------|------------------------------|
| id         | SERIAL  | Primary key                  |
| name       | VARCHAR | Name of the author           |
| nationality| VARCHAR | Nationality of the author    |
| birth_year | INT     | Year of birth                |
| death_year | INT     | Year of death (if applicable)|

### 'books'
| Column         | Type    | Description                        |
|----------------|---------|------------------------------------|
| id             | SERIAL  | Primary key                        |
| title          | VARCHAR | Title of the book                  |
| author_id      | INT     | Foreign key referencing authors.id |
| genres         | TEXT[]  | List of genres                     |
| published_year | INT     | Year of publication                |
| available      | BOOLEAN | Availability status (default True)|


### 'patrons'
| Column         | Type     | Description                     |
|----------------|----------|---------------------------------|
| id             | SERIAL   | Primary key                     |
| name           | VARCHAR  | Name of the patron              |
| email          | VARCHAR  | Email address (unique)          |
| borrowed_books | INT[]    | Array of borrowed book IDs      |

## Setup Instructions

1. **Sign up / Log in to Supabase**
   - Go to [https://supabase.com](https://supabase.com)
   - Create a new project (choose your region, database password, etc.)

2. **Run SQL Scripts**
   - Open the Supabase SQL editor for your project.
   - Run `setup.sql` first to create tables.
   - Then run `insert_data.sql` to populate the tables.

3. **Verify Data**
   - Run the following queries in Supabase SQL editor:

```sql
SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM patrons;
