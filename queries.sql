SELECT * FROM books;

SELECT * FROM books WHERE title = '1984';

 SELECT b.title, a.name AS author
 FROM books b
 JOIN authors a ON b.author_id = a.id
 WHERE a.name = 'George Orwell';

 SELECT * FROM books WHERE available = TRUE;

 UPDATE books SET available = FALSE WHERE id = 1 ;

 UPDATE patrons
 SET borrowed_books = array_append(borrowed_books, 1)
 WHERE id = 2;

 UPDATE books
 SET genres = array_append(genres, 'Classic')
 WHERE id = 2;

 DELETE FROM books WHERE title = 'Moby Dick';

 DELETE FROM authors WHERE id = 6;

 SELECT * FROM books WHERE published_year > 1950;  
 
 SELECT * FROM authors WHERE nationality = 'American';

 UPDATE books SET available = TRUE;

 SELECT * FROM books WHERE available = TRUE AND published_year > 1950;

 SELECT * FROM authors WHERE name LIKE '%George%';

 UPDATE books SET published_year = published_year + 1 WHERE published_year = 1869;

