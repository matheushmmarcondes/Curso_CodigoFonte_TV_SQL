CREATE TABLE produtos (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (100) NOT NULL, 
    price REAL, 
    stock INTEGER DEFAULT 0
);


CREATE TABLE marcas (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (100) NOT NULL UNIQUE,
    site VARCHAR (100),
    telephone VARCHAR (15)
);

ALTER TABLE produtos ADD COLUMN id_marca INTEGER NOT NULL;

ALTER TABLE produtos MODIFY name VARCHAR (150);
ALTER TABLE produtos ADD FOREIGN KEY (id_marca) REFERENCES marcas (id);

create table controle (
    id integer primary key,
    data_entrada DATE
    );

drop table IF EXISTS controle;

CREATE INDEX idx_produtos_name ON produtos (name);

INSERT into marcas
    (name, site, telephone) 
VALUES
    ('Apple', 'apple.com', '0800-761-0867'),
    ('Samsung', 'samsung.com', '0800-124-421'),
    ('Motorola', 'motorola.com', '0800-701-0888'),
    ('google', 'google.com', '0800-123-4567'),
    ('lg', 'lg.com', '0800-987-6543');

INSERT INTO produtos 
VALUES
(1, 'Iphone 16 Pro Apple 128GB', 999.99, 50, 1),
(2, 'Galaxy S23 Samsung 256GB', 899.99, 30, 2),
(3, 'Moto G Power Motorola 64GB', 199.99, 100, 3),
(4, 'Pixel 7 Google 128GB', 799.99, 20, 4),
(5, 'LG Velvet LG 128GB', 499.99, 15, 5);

SELECT id, name FROM produtos WHERE id > 2;

create table produtos_apple (
    name VARCHAR (150) NOT NULL,
    stock INTEGER default 0  
);

INSERT INTO produtos_apple
SELECT name, stock FROM produtos WHERE id_marca = 1;

SELECT * FROM produtos_apple;

drop Table produtos_apple;

TRUNCATE TABLE produtos_apple;


update produtos
SET name = "branco"
WHERE id = 5;


update produtos
set stock = stock + 20
WHERE id = 1;


delete from produtos
where id = 5;


select *
FROM produtos
WHERE stock < 90 
AND price < 899.99


select *
FROM produtos
WHERE 
    name LIKE "Iphone%";

SELECT *
FROM produtos   
ORDER BY stock desc
LIMIT 3;

