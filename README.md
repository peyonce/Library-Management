## Project Description
A comprehensive PostgreSQL-based Library Management System designed to manage books, authors, and patrons. The system supports full CRUD operations, advanced queries, and relational data management.

## Database Schema

### Authors Table
- id (SERIAL PRIMARY KEY)
- name (VARCHAR(100) NOT NULL)
- nationality (VARCHAR(50))
- birth_year (INTEGER)
- death_year (INTEGER)

### Books Table
- id (SERIAL PRIMARY KEY)
- title (VARCHAR(255) NOT NULL)
- author_id (INTEGER REFERENCES Authors(id))
- genres (TEXT[])
- published_year (INTEGER)
- available (BOOLEAN DEFAULT TRUE)

### Patrons Table
- id (SERIAL PRIMARY KEY)
- name (VARCHAR(100) NOT NULL)
- email (VARCHAR(100))
- borrowed_books (INTEGER[])

## SQL Code Implementation

### 1. Database and Table Creation

\`\`\`sql
-- Create Database
CREATE DATABASE LibraryDB;

-- Create Authors Table
CREATE TABLE Authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    birth_year INTEGER,
    death_year INTEGER
);

-- Create Books Table
CREATE TABLE Books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INTEGER REFERENCES Authors(id),
    genres TEXT[],
    published_year INTEGER,
    available BOOLEAN DEFAULT TRUE
);

-- Create Patrons Table
CREATE TABLE Patrons (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    borrowed_books INTEGER[]
);

-- Create indexes for better performance
CREATE INDEX idx_books_author_id ON Books(author_id);
CREATE INDEX idx_books_title ON Books(title);
CREATE INDEX idx_books_available ON Books(available);
\`\`\`

### 2. Sample Data Insertion

\`\`\`sql
-- Insert Authors
INSERT INTO Authors (id, name, nationality, birth_year, death_year) VALUES
(1, 'George Orwell', 'British', 1903, 1950),
(2, 'Harper Lee', 'American', 1926, 2016),
(3, 'F. Scott Fitzgerald', 'American', 1896, 1940),
(4, 'Aldous Huxley', 'British', 1894, 1963),
(5, 'J.D. Salinger', 'American', 1919, 2010),
(6, 'Herman Melville', 'American', 1819, 1891),
(7, 'Jane Austen', 'British', 1775, 1817),
(8, 'Leo Tolstoy', 'Russian', 1828, 1910),
(9, 'Fyodor Dostoevsky', 'Russian', 1821, 1881),
(10, 'J.R.R. Tolkien', 'British', 1892, 1973);

-- Insert Books
INSERT INTO Books (id, title, author_id, genres, published_year, available) VALUES
(1, '1984', 1, '{"Dystopian", "Political Fiction"}', 1949, TRUE),
(2, 'To Kill a Mockingbird', 2, '{"Southern Gothic", "Bildungsroman"}', 1960, TRUE),
(3, 'The Great Gatsby', 3, '{"Tragedy"}', 1925, TRUE),
(4, 'Brave New World', 4, '{"Dystopian", "Science Fiction"}', 1932, TRUE),
(5, 'The Catcher in the Rye', 5, '{"Realist Novel", "Bildungsroman"}', 1951, TRUE),
(6, 'Moby-Dick', 6, '{"Adventure Fiction"}', 1851, TRUE),
(7, 'Pride and Prejudice', 7, '{"Romantic Novel"}', 1813, TRUE),
(8, 'War and Peace', 8, '{"Historical Novel"}', 1869, TRUE),
(9, 'Crime and Punishment', 9, '{"Philosophical Novel"}', 1866, TRUE),
(10, 'The Hobbit', 10, '{"Fantasy"}', 1937, TRUE);

-- Insert Patrons
INSERT INTO Patrons (id, name, email, borrowed_books) VALUES
(1, 'Alice Johnson', 'alice@example.com', '{}'),
(2, 'Bob Smith', 'bob@example.com', '{1,2}'),
(3, 'Carol White', 'carol@example.com', '{}'),
(4, 'David Brown', 'david@example.com', '{3}'),
(5, 'Eve Davis', 'eve@example.com', '{}'),
(6, 'Frank Moore', 'frank@example.com', '{4,5}'),
(7, 'Grace Miller', 'grace@example.com', '{}'),
(8, 'Hank Wilson', 'hank@example.com', '{6}'),
(9, 'Ivy Taylor', 'ivy@example.com', '{}'),
(10, 'Jack Anderson', 'jack@example.com', '{7,8}');
\`\`\`

### 3. Basic Queries (Sprint 3)

\`\`\`sql
-- Get all books
SELECT * FROM Books;

-- Get a book by title
SELECT * FROM Books WHERE title = '1984';

-- Get all books by a specific author
SELECT b.*, a.name as author_name 
FROM Books b 
JOIN Authors a ON b.author_id = a.id 
WHERE a.name = 'George Orwell';

-- Get all available books
SELECT * FROM Books WHERE available = TRUE;

-- View books with author details
SELECT 
    b.id,
    b.title,
    a.name as author,
    b.genres,
    b.published_year,
    b.available
FROM Books b
JOIN Authors a ON b.author_id = a.id
ORDER BY b.title;
\`\`\`

### 4. Update Operations (Sprint 4)

\`\`\`sql
-- Mark a book as borrowed (set available = false)
UPDATE Books SET available = FALSE WHERE id = 1;

-- Add a new genre to an existing book
UPDATE Books 
SET genres = array_append(genres, 'Social Commentary') 
WHERE id = 1;

-- Add a borrowed book to a patron's record
UPDATE Patrons 
SET borrowed_books = array_append(borrowed_books, 1) 
WHERE id = 1;

-- Return a book (set available = true)
UPDATE Books SET available = TRUE WHERE id = 2;

-- Remove a book from patron's borrowed list
UPDATE Patrons 
SET borrowed_books = array_remove(borrowed_books, 2) 
WHERE id = 2;
\`\`\`

### 5. Delete Operations (Sprint 5)

\`\`\`sql
-- Delete a book by title
DELETE FROM Books WHERE title = 'The Hobbit';

-- Delete an author by ID
DELETE FROM Authors WHERE id = 10;
\`\`\`

### 6. Advanced Queries (Sprint 6)

\`\`\`sql
-- Find books published after 1950
SELECT * FROM Books WHERE published_year > 1950;

-- Find all American authors
SELECT * FROM Authors WHERE nationality = 'American';

-- Set all books as available
UPDATE Books SET available = TRUE;

-- Find books that are available AND published after 1950
SELECT * FROM Books 
WHERE available = TRUE AND published_year > 1950;

-- Find authors whose names contain "George"
SELECT * FROM Authors WHERE name LIKE '%George%';

-- Increment the published year 1869 by 1
UPDATE Books SET published_year = published_year + 1 
WHERE published_year = 1869;

-- Count books by author
SELECT a.name, COUNT(b.id) as book_count
FROM Authors a
LEFT JOIN Books b ON a.id = b.author_id
GROUP BY a.name
ORDER BY book_count DESC;

-- Find books by genre
SELECT title, genres
FROM Books
WHERE 'Dystopian' = ANY(genres);

-- Find patrons with their borrowed books
SELECT p.name, p.email, b.title as borrowed_book_title
FROM Patrons p
CROSS JOIN UNNEST(p.borrowed_books) AS book_id
JOIN Books b ON b.id = book_id;
\`\`\`

## Features Implemented by Sprint

### Sprint 1: Project Setup
- Created LibraryDB database
- Designed and implemented all three tables with proper relationships
- Added appropriate indexes for performance

### Sprint 2: Data Insertion
- Inserted 10 sample authors with complete biographical information
- Inserted 10 sample books with genre arrays and publication details
- Inserted 10 sample patrons with borrowed book tracking

### Sprint 3: Read Operations
- Retrieve all books
- Find books by title
- Find books by specific author
- List all available books
- Display books with author details

### Sprint 4: Update Operations
- Mark books as borrowed/returned (availability toggle)
- Add new genres to existing books using array operations
- Update patron records with borrowed books
- Manage book-loan relationships

### Sprint 5: Delete Operations
- Remove books by title
- Delete authors by ID
- Safe deletion with referential integrity

### Sprint 6: Advanced Queries
- Filter books published after 1950
- Find authors by nationality
- Bulk availability updates
- Complex filtering (available AND published after 1950)
- Pattern matching in author names
- Mathematical operations on publication years
- Genre-based searching using array operations
- Statistical analysis of book collections

## Setup Instructions

1. **Create Database**:
   \`\`\`sql
   CREATE DATABASE LibraryDB;
   \`\`\`

2. **Execute SQL Files in Order**:
   - Run table creation SQL
   - Insert sample data
   - Execute basic queries
   - Test update operations
   - Run advanced queries

## Learning Outcomes
- PostgreSQL database design and implementation
- SQL query optimization
- Array operations and data types
- Relational database management
- Complex query development

This project demonstrates comprehensive PostgreSQL skills including database design, CRUD operations, advanced queries, and data management.
 