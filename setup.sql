DROP TABLE IF EXISTS patrons;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL, 
    nationality VARCHAR(50),
    birth_year INT,
    death_year INT
);


CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT REFERENCES authors(id) ON DELETE CASCADE,
    genres TEXT[],
    published_year INT,
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE patrons (
    id SERIAL PRIMARY KEY,
     name VARCHAR(100) NOT NULL,
     email VARCHAR(100) UNIQUE,
     borrowed_books INT[] DEFAULT ARRAY[]::INT[]
);