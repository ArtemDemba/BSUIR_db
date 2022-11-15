CREATE TABLE IF NOT EXISTS publishers
(
    publisher_id serial PRIMARY KEY,
    org_name varchar(127) UNIQUE NOT NULL, 
    address text UNIQUE NOT NULL,
    country varchar(255) NOT NULL,
    email text UNIQUE,
    phone varchar(13) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS suppliers
(
    supplier_id serial PRIMARY KEY,
    org_name varchar(127) UNIQUE NOT NULL, 
    address text UNIQUE NOT NULL,
    email text UNIQUE,
    phone varchar(13) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS users
(
    user_id serial PRIMARY KEY,
    first_name varchar(127) NOT NULL,
    last_name varchar(127) NOT NULL,
    phone varchar(13) UNIQUE NOT NULL,
    email text
);


CREATE TABLE IF NOT EXISTS customers
(
    customer_id serial PRIMARY KEY,
    user_id int UNIQUE NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    address text UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS orders
(
    order_id serial PRIMARY KEY,
    create_date date NOT NULL,
    deliver_date date default NULL,
    customer_id int NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE	
);


CREATE TABLE IF NOT EXISTS shops
(
    shop_id serial PRIMARY KEY,
    address text UNIQUE NOT NULL,
    phone varchar(13) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS books
(
    book_id serial PRIMARY KEY,
    title text UNIQUE NOT NULL,
    production_date date NOT NULL,
    price decimal, 
    order_id int default NULL REFERENCES orders(order_id) ON DELETE RESTRICT,
    publisher_id int NOT NULL REFERENCES publishers(publisher_id) ON DELETE SET NULL,
    supplier_id int NOT NULL REFERENCES suppliers(supplier_id) ON DELETE SET NULL,
);


CREATE TABLE IF NOT EXISTS positions
(
    position_id serial PRIMARY KEY,
    position_name varchar(127) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS employees
(
    employee_id serial PRIMARY KEY,
    user_id int UNIQUE NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    birth_date date NOT NULL,
    address text NOT NULL,
    position_id int REFERENCES positions(position_id),
    salary decimal NOT NULL CHECK(salary >= 0),
    shop_id int NOT NULL REFERENCES shops(shop_id) ON DELETE SET NULL
);


CREATE TABLE IF NOT EXISTS authors
(
    author_id serial PRIMARY KEY,
    user_id int UNIQUE NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    author_alias varchar(255) default NULL
);


CREATE TABLE IF NOT EXISTS genres
(
    genre_id serial PRIMARY KEY,
    genre varchar(63)
);


CREATE TABLE IF NOT EXISTS book_genre
(
    book_id int REFERENCES books(book_id) ON DELETE CASCADE,
    genre_id int REFERENCES genres(genre_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS author_genre
(
    author_id int REFERENCES authors(author_id) ON DELETE CASCADE,
    genre_id int REFERENCES genres(genre_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS book_author
(
    book_id int REFERENCES books(book_id) ON DELETE CASCADE,
    author_id int REFERENCES authors(author_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS order_book
(
    order_id int REFERENCES orders(order_id) ON DELETE CASCADE,
    book_id int REFERENCES books(book_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS book_shop
(
    shop_id int REFERENCES shops(shop_id) ON DELETE CASCADE,
    book_id int REFERENCES books(book_id) ON DELETE CASCADE,
    book_amount int CHECK(book_amount >= 0)
);


CREATE TABLE IF NOT EXISTS logging
(
    log_id serial PRIMARY KEY,
    log_message varchar(255) NOT NULL,
    user_id int REFERENCES users(user_id) ON DELETE SET NULL
);


ALTER TABLE IF EXISTS public.logging
    ALTER COLUMN user_id SET NOT NULL;