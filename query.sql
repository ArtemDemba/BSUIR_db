SELECT author_id, author_alias FROM authors;

SELECT * FROM genres
ORDER BY genre;

SELECT log_id, log_message FROM logging;

SELECT book_id, title, price FROM books
WHERE price BETWEEN 10 AND 40
ORDER BY price DESC;

SELECT * FROM orders
WHERE deliver_date IS null;

SELECT org_name, email, phone FROM suppliers
WHERE address LIKE '%Минск%';

SELECT first_name, last_name, phone FROM users
WHERE first_name LIKE 'Александр';

SELECT * FROM users
WHERE phone LIKE '%4'
ORDER BY last_name;

SELECT SUM(price) AS total_sum FROM books
WHERE order_id IS null;

SELECT * FROM books
ORDER BY title
LIMIT 10;

SELECT * FROM books
ORDER BY title
OFFSET 5 
LIMIT 10;


SELECT SUM(price) AS total_sum FROM books
WHERE order_id IS null;


SELECT COUNT(book_id) from books
WHERE production_date > '1990-01-01';


SELECT title, date_part('year', production_date) AS production_year, price FROM books
ORDER BY production_year DESC
LIMIT 20;


SELECT employee_id, address, shop_id FROM employees
WHERE address LIKE '%Дзержинского%';


SELECT * FROM employees
WHERE position_id = 1 AND salary > 1200
ORDER BY salary;


SELECT AVG(salary) AS avarage_salary FROM employees
WHERE shop_id = 1;


UPDATE books
SET price = price + 10
WHERE date_part('year', production_date) > '1995';  


