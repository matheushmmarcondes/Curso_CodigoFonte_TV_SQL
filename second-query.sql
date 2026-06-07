-- Clientes
CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (100) NOT NULL,
    email VARCHAR (100) UNIQUE NOT NULL,
    city VARCHAR (200),
    birth_date DATE
)

-- Pedidos
CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    date_order DATE DEFAULT (NOW()),
    id_customer INTEGER,
    total_price REAL,
    FOREIGN KEY (id_customer) REFERENCES customers (id) 
)

-- Itens do pedido
CREATE TABLE order_items (
    id_order INTEGER,
    id_produto INTEGER,
    quantity INTEGER,
    price_unit REAL,
    FOREIGN KEY (id_order) REFERENCES orders(id),
    FOREIGN KEY (id_produto) REFERENCES produtos (id),
    PRIMARY KEY (id_order, id_produto)
)

INSERT INTO customers (name, email, city) VALUES
('John Doe', 'john.doe@example.com', 'New York'),
('Jane Smith', 'jane.smith@example.com', 'Los Angeles'),
('Alice Johnson', 'alice.johnson@example.com', 'Chicago');

INSERT INTO customers (name, email, city) VALUES
('Bob Brown', 'bob.brown@example.com', 'Chicago'),
('Charlie Davis', 'charlie.davis@example.com', 'Los Angeles'),
('Eve Wilson', 'eve.wilson@example.com', 'Los Angeles');


INSERT INTO orders (id_customer, total_price) VALUES
(1, 199.99),
(2, 899.99),
(3, 499.99);

INSERT INTO order_items (id_order, id_produto, quantity, price_unit) VALUES
(1, 3, 1, 199.99),
(2, 2, 1, 899.99),
(3, 5, 1, 499.99);

SELECT
    customers.name,
    orders.total_price
FROM
    customers
    INNER JOIN orders ON customers.id = orders.id_customer

--subquery
SELECT
    name, price
FROM
    produtos
WHERE
    id_marca = IN (Select id FROM marcas WHERE name = 'Apple');


SELECT customers.name,
    orders.total_price
FROM 
    customers
    LEFT JOIN orders ON
    customers.id = orders.id_customer;

UNION

SELECT customers.name,
    orders.total_price
FROM 
    customers
    RIGHT JOIN orders ON
    customers.id = orders.id_customer;


select * from customers;

select 
    city,
    COUNT(1) as customers_count
FROM
    customers
GROUP BY city;

SELECT
    DATE_FORMAT(date_order, '%Y-%m') AS month,
    AVG(total_price) AS media_vendas
FROM 
    orders
GROUP BY month


SELECT
    c.city,
    SUM(p.total_price) AS total_vendas
FROM
    customers as c
    INNER JOIN orders as p ON c.id = p.id_customer
WHERE
c.city in ('New York', 'Los Angeles')
GROUP BY c.city
having totaal_vendas > 500;