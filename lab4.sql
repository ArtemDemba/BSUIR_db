SELECT position_id, AVG(salary) FROM employees
GROUP BY position_id
ORDER BY AVG(salary) DESC;


SELECT publisher_id, COUNT(*) FROM books
GROUP BY publisher_id
HAVING COUNT(*) > 10
ORDER BY COUNT(*);


SELECT order_id, SUM(price) FROM books
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


SELECT * FROM books
LIMIT (SELECT COUNT(*) FROM customers);


INSERT INTO genres(genre)
SELECT first_name FROM users
LIMIT 10;


SELECT title, price,
CASE WHEN price >= 90 THEN 'exspensive'
	 WHEN price BETWEEN 50 and 90 THEN 'avarage'
	 ELSE 'cheep'
END as price_level
FROM books
ORDER BY price DESC;


SELECT title, production_date,
CASE WHEN date_part('years', production_date) > 1990 THEN 'new'
	 ELSE 'old'
END AS age_level, 
price
FROM books
ORDER BY age_level;


SELECT CASE WHEN date_part('years', production_date) > 1990 THEN 'new'
			ELSE 'old'
		END AS age_level,
AVG(price)
FROM books
GROUP BY age_level;


SELECT title, price, orders.create_date, orders.deliver_date FROM books
LEFT JOIN orders USING(order_id)
ORDER BY create_date;


SELECT shops.shop_id, shops.address, COUNT(employees.user_id) FROM shops
JOIN employees USING(shop_id)
GROUP BY shops.address, shop_id
ORDER BY shop_id;


SELECT last_name, first_name, title FROM book_author
JOIN books USING(book_id)
JOIN authors USING(author_id)
JOIN users USING(user_id)
WHERE order_id=5;