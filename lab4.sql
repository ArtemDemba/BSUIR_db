SELECT position_id, AVG(salary) FROM employees
GROUP BY position_id
ORDER BY AVG(salary) DESC;


SELECT publisher_id, COUNT(*) FROM books
GROUP BY publisher_id
HAVING COUNT(*) > 10
ORDER BY COUNT(*);


select order_id, SUM(price) from books
GROUP BY order_id
HAVING order_id IS NOT NULL
ORDER BY SUM(price) DESC;


SELECT price FROM books
UNION 
SELECT salary FROM employees
ORDER BY price DESC;


SELECT book_id, title, org_name, address FROM books
JOIN publishers ON books.publisher_id=publishers.publisher_id
LIMIT 15;


SELECT books.book_id, title, genre FROM books
JOIN book_genre ON books.book_id=book_genre.book_id
JOIN genres ON book_genre.genre_id=genres.genre_id;


SELECT org_name, SUM(price) FROM books
JOIN suppliers USING(supplier_id)
WHERE price > 25
GROUP BY org_name
ORDER BY SUM(price) DESC;


SELECT first_name, last_name, positions.position_name, salary  FROM employees
JOIN users USING(user_id)
JOIN positions USING(position_id);


SELECT first_name, last_name, create_date, deliver_date, address FROM orders
JOIN customers USING(customer_id)
JOIN users USING(user_id)
WHERE deliver_date IS NULL
ORDER BY create_date;


