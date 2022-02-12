--08Feb22
--Assignment1

CREATE TABLE my_orders
(OrderId number(10) NOT NULL,
CustomerId number(10) NOT NULL,
OrderDate DATE);

CREATE TABLE my_customers
(CustomerId number(10) NOT NULL,
CustomerName varchar(50) NOT NULL,
ContactName varchar(50),
Country varchar(50));

INSERT INTO my_orders VALUES(10308, 2, '18-OCT-1996');
INSERT INTO my_orders VALUES(10309, 37, '19-OCT-1996');
INSERT INTO my_orders VALUES(10310, 77, '20-OCT-1996');

INSERT INTO my_customers VALUES(1, 'Alfreds Futterkiste','Maria Anders','Germany');
INSERT INTO my_customers VALUES(2, 'Ana Trujillo Emparedados y helados','Ana Trujillo','Mexico');
INSERT INTO my_customers VALUES(3, 'Antonio Moreno Taquer?a','	Antonio Moreno','Mexico');


SELECT * FROM my_orders;
SELECT * FROM my_customers;

--INNER JOIN
SELECT my_orders.OrderID, my_customers.customername, my_orders.orderdate
FROM my_orders INNER JOIN 
my_customers ON my_orders.customerid=my_customers.customerid;

--LEFT OUTER JOIN
SELECT my_orders.OrderID, my_customers.customername, my_orders.orderdate
FROM my_orders LEFT OUTER JOIN
my_customers ON my_orders.customerid=my_customers.customerid;

--RIGHT OUTER JOIN
SELECT my_orders.OrderID, my_customers.customername, my_orders.orderdate
FROM my_orders RIGHT OUTER JOIN
my_customers ON my_orders.customerid=my_customers.customerid;

--FULL OUTER JOIN
SELECT my_orders.OrderID, my_customers.customername, my_orders.orderdate
FROM my_orders FULL OUTER JOIN
my_customers ON my_orders.customerid=my_customers.customerid;


--Assignment 2
CREATE TABLE books
( id number(10) NOT NULL,  
  title varchar2(50) NOT NULL,  
  type varchar2(50) NOT NULL,
  author_id number(10) NOT NULL,
  editor_id number(10) NOT NULL,
  translator_id number(10) NOT NULL,
  CONSTRAINT books_id PRIMARY KEY (id)  
);  

CREATE TABLE authors
( id number(10) NOT NULL,  
  first_name varchar2(50) NOT NULL,
  last_name varchar2(50) NOT NULL,
  CONSTRAINT authors_id PRIMARY KEY (id)  
);  

CREATE TABLE editors
( id number(10) NOT NULL,  
  first_name varchar2(50) NOT NULL,
  last_name varchar2(50) NOT NULL,
  CONSTRAINT editors_id PRIMARY KEY (id)  
);  

CREATE TABLE translators
( id number(10) NOT NULL,  
  first_name varchar2(50) NOT NULL,
  last_name varchar2(50) NOT NULL,
  CONSTRAINT translators_id PRIMARY KEY (id)  
);  

ALTER TABLE books MODIFY ( translator_id NULL);


INSERT INTO books values(1,'Time to Grow Up!','original',11,21,NULL);
INSERT INTO books values(2,'Your Trip','translated',15,22,32);
INSERT INTO books VALUES(3,'Lovely Love','original',14,24,NULL);
INSERT INTO books VALUES(4,'Dreamy Your Life','original',11,24,NULL);
INSERT INTO books VALUES(5,'Oranges','translated',12,25,31);
INSERT INTO books VALUES(6,'Your Happy Life','translated',15,22,33);
INSERT INTO books VALUES(7,'Applied AI','translated',13,23,34);
INSERT INTO books VALUES(8,'My Last Book','original',11,28,NULL);

SELECT * FROM books;

INSERT INTO authors VALUES(11,'Ellen','Writer');
INSERT INTO authors VALUES(12,'Olga','Savelieva');
INSERT INTO authors VALUES(13,'Jack','Smart');
INSERT INTO authors VALUES(14,'Donald','Brain');
INSERT INTO authors VALUES(15,'Yao','Duo');

SELECT * FROM authors;

INSERT INTO editors VALUES(21,'Daniel','Brown');
INSERT INTO editors VALUES(22,'Mark','Jhonson');
INSERT INTO editors VALUES(23,'Maria','Evans');
INSERT INTO editors VALUES(24,'Cathrine','Roberts');
INSERT INTO editors VALUES(25,'Sebastian','Wright');
INSERT INTO editors VALUES(26,'Barbara','Jones');
INSERT INTO editors VALUES(27,'Matthew','Smith');

SELECT * FROM editors;

INSERT INTO translators VALUES(31,'Ira','Davies');
INSERT INTO translators VALUES(32,'Ling','Weng');
INSERT INTO translators VALUES(33,'Kristian','Green');
INSERT INTO translators VALUES(34,'Roman','Edwards');

SELECT * FROM translators;

--INNER JOIN
SELECT b.id, b.title, a.first_name, a.last_name
FROM books b INNER JOIN authors a
ON b.author_id=a.id
ORDER BY b.id;

SELECT b.id, b.title,b.type, t.last_name AS Translator_name
FROM books b INNER JOIN translators t
ON b.translator_id=t.id
ORDER BY b.id;

--LEFT OUTER JOIN 
SELECT b.id, b.title, b.type, a.last_name AS author, t.last_name AS translator
FROM books b LEFT OUTER JOIN authors a
ON b.author_id=a.id
LEFT JOIN translators t
ON b.translator_id=t.id
ORDER BY b.id;

SELECT b.id, b.title, e.last_name AS editor
FROM books b
LEFT JOIN editors e
ON b.editor_id = e.id
ORDER BY b.id;

--RIGHT JOIN
SELECT b.id, b.title, e.last_name AS editor
FROM books b
RIGHT JOIN editors e
ON b.editor_id = e.id
ORDER BY b.id;

SELECT b.id, b.title, e.last_name AS editor
FROM books b
RIGHT JOIN editors e
ON b.editor_id = e.id
ORDER BY b.id;

--FULL JOIN
SELECT b.id, b.title, a.last_name AS author, e.last_name AS editor, t.last_name AS translator
FROM books b 
FULL JOIN authors a ON b.author_id=a.id
FULL JOIN editors e ON b.editor_id=e.id
FULL JOIN translators t ON b.translator_id=t.id
ORDER BY b.id;

--Assignment 3
--VIEW
CREATE TABLE brands
( Brand_id number(10) NOT NULL,  
  Brand_name varchar2(50) NOT NULL,
  CONSTRAINT my_brand_id PRIMARY KEY (brand_id)  
);

INSERT INTO brands VALUES(1,'Audi');
INSERT INTO brands VALUES(2,'BMW');
INSERT INTO brands VALUES(3,'Ford');
INSERT INTO brands VALUES(4,'Honda');
INSERT INTO brands VALUES(5,'Toyota');

CREATE TABLE cars
( car_id number(10),  
  car_name varchar2(50),
  brand_id number(10)
);

ALTER TABLE cars MODIFY(CAR_ID NULL); 
ALTER TABLE brands MODIFY(brand_ID NULL); 

INSERT INTO cars VALUES(1,'Audi R8 Coupe',1);
INSERT INTO cars VALUES(2,'Audi Q2',1);
INSERT INTO cars VALUES(3,'Audi S1',1);
INSERT INTO cars VALUES(4,'BMW 2-serie Cabrio',2);
INSERT INTO cars VALUES(5,'BMW i8',2);
INSERT INTO cars VALUES(6,'Ford Edge',3);
INSERT INTO cars VALUES(7,'Ford Mustang Fastback',3);
INSERT INTO cars VALUES(8,'Honda S2000',4);
INSERT INTO cars VALUES(9,'Honda Legend',4);
INSERT INTO cars VALUES(10,'Toyota GT86',5);
INSERT INTO cars VALUES(11,'Toyota C-HR',5);

commit;

CREATE VIEW audi_cars AS 
SELECT car_id, car_name, brand_id
FROM cars
WHERE brand_id=1;

SELECT * FROM audi_Cars;

INSERT INTO audi_Cars(car_name, brand_id) values('BMW Z3 coupe',2);
SELECT * FROM audi_Cars;

UPDATE
    audi_cars
SET
    car_name = 'BMW 1-serie Coupe',
    brand_id = 2
WHERE
    car_id = 3;

SELECT
    *
FROM
    audi_cars;

CREATE
    VIEW ford_cars AS SELECT
        car_id,
        car_name,
        brand_id
    FROM
        cars
    WHERE
        brand_id = 3 WITH CHECK OPTION;
        
SELECT * FROM FORD_CARS;

--below queries SQL Error: ORA-01402: view WITH CHECK OPTION where-clause violation
INSERT
    INTO
        ford_cars(
            car_name,
            brand_id
        )
    VALUES(
        'Audi RS6 Avant',
        1
    );

--Assignment4
--complex query
SELECT
    name AS customer,
    SUM( quantity * unit_price ) sales_amount,
    EXTRACT(
        YEAR
    FROM
        order_date
    ) YEAR
FROM
    orders
INNER JOIN order_items
        USING(order_id)
INNER JOIN customers
        USING(customer_id)
WHERE
    status = 'Shipped'
GROUP BY
    name,
    EXTRACT(
        YEAR
    FROM
        order_date
    );
--To simplify it, we can create a view based on this query

CREATE OR REPLACE VIEW customer_sales AS 
SELECT
    name AS customer,
    SUM( quantity * unit_price ) sales_amount,
    EXTRACT(
        YEAR
    FROM
        order_date
    ) YEAR
FROM
    orders
INNER JOIN order_items
        USING(order_id)
INNER JOIN customers
        USING(customer_id)
WHERE
    status = 'Shipped'
GROUP BY
    name,
    EXTRACT(
        YEAR
    FROM
        order_date
    );
-- retrieve the sales by the customer in 2017 with a more simple query    
SELECT
    customer,
    sales_amount
FROM
    customer_sales
WHERE
    YEAR = 2017
ORDER BY
    sales_amount DESC;

--Assignment5
--create view
CREATE VIEW employee_yos AS
SELECT
    employee_id,
    first_name || ' ' || last_name full_name,
    FLOOR( months_between( CURRENT_DATE, hire_date )/ 12 ) yos
FROM
    employees;

Select * FROM employee_yos;

--without using column aliases
CREATE VIEW employee_yos (employee_id, full_name, yos) AS
SELECT
    employee_id,
    first_name || ' ' || last_name,
    FLOOR( months_between( CURRENT_DATE, hire_date )/ 12 )
FROM
    employees;
    
--returns employees whose years of service are 5
SELECT
    *
FROM
    employee_yos
WHERE
    yos = 5
ORDER BY
    full_name;
    
--read only view
CREATE OR REPLACE VIEW customer_credits(
        customer_id,
        name,
        credit
    ) AS 
SELECT
        customer_id,
        name,
        credit_limit
    FROM
        customers WITH READ ONLY;
        
--join view 
CREATE OR REPLACE VIEW backlogs AS
SELECT
    product_name,
    EXTRACT(
        YEAR
    FROM
        order_date
    ) YEAR,
    SUM( quantity * unit_price ) amount
FROM
    orders
INNER JOIN order_items
        USING(order_id)
INNER JOIN products
        USING(product_id)
WHERE
    status = 'Pending'
GROUP BY
    EXTRACT(
        YEAR
    FROM
        order_date
    ),
    product_name;
    
--Assignment 6
--dropview
CREATE VIEW salesman AS 
SELECT
    *
FROM
    employees
WHERE
    job_title = 'Sales Representative';
    
SELECT
    *
FROM
    salesman;
   
--creates another view named salesman_contacts based on the salesman view 
CREATE VIEW salesman_contacts AS 
SELECT
    first_name,
    last_name,
    email,
    phone
FROM
    salesman;
    
SELECT
    *
FROM
    salesman_contacts;
 
--drop view   
DROP VIEW salesman;

-- the salesman_contacts view is dependent on the salesman view, it became invalid when the salesman view was dropped.
SELECT
    object_name,
    status
FROM
    user_objects
WHERE
    object_type = 'VIEW'
    AND object_name = 'SALESMAN_CONTACTS';
    
DROP VIEW salesman_contacts;

--Assignment7
--Updatable View
CREATE TABLE brands(
	brand_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
	brand_name VARCHAR2(50) NOT NULL,
	PRIMARY KEY(brand_id)
);

CREATE TABLE cars (
	car_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
	car_name VARCHAR2(255) NOT NULL,
	brand_id NUMBER NOT NULL,
	PRIMARY KEY(car_id),
	FOREIGN KEY(brand_id) 
	REFERENCES brands(brand_id) ON DELETE CASCADE
);

INSERT INTO brands(brand_name) VALUES('Audi');
INSERT INTO brands(brand_name) VALUES('BMW');
INSERT INTO brands(brand_name) VALUES('Ford');
INSERT INTO brands(brand_name) VALUES('Honda');
INSERT INTO brands(brand_name) VALUES('Toyota');
INSERT INTO cars (car_name,brand_id) VALUES('Audi R8 Coupe',1);
INSERT INTO cars (car_name,brand_id)VALUES('Audi Q2',1);
INSERT INTO cars (car_name,brand_id) VALUES('Audi S1',1);
INSERT INTO cars (car_name,brand_id) VALUES('BMW 2-serie Cabrio',2);
INSERT INTO cars (car_name,brand_id) VALUES('BMW i8',2);
INSERT INTO cars (car_name,brand_id) VALUES('Ford Edge',3);
INSERT INTO cars (car_name,brand_id) VALUES('Ford Mustang Fastback',3);
INSERT INTO cars (car_name,brand_id)VALUES('Honda S2000',4);
INSERT INTO cars (car_name,brand_id)VALUES('Honda Legend',4);
INSERT INTO cars (car_name,brand_id)VALUES('Toyota GT86',5);
INSERT INTO cars (car_name,brand_id)VALUES('Toyota C-HR',5);

-- creates a new view
CREATE VIEW cars_master AS 
SELECT
    car_id,
    car_name
FROM
    cars;
--delete row   
DELETE
FROM
    cars_master
WHERE
    car_id = 1;

--updated the column
UPDATE
    cars_master
SET
    car_name = 'Audi RS7 Sportback'
WHERE
    car_id = 2;

-- create a join view
CREATE VIEW all_cars AS 
SELECT
    car_id,
    car_name,
    c.brand_id,
    brand_name
FROM
    cars c
INNER JOIN brands b ON
    b.brand_id = c.brand_id; 
    
--inserted the value
INSERT INTO all_cars(car_name, brand_id ) VALUES('Audi A5 Cabriolet', 1);

SELECT
    *
FROM
    USER_UPDATABLE_COLUMNS
WHERE
    TABLE_NAME = 'ALL_CARS';
    
--Assignment8
--oracle Fetch
--will give error cause Oracle Database does not have the LIMIT clause
SELECT
	product_name,
	quantity
FROM
	inventories
      INNER JOIN products
		USING(product_id)
ORDER BY
	quantity DESC 
LIMIT 5;

--using fetch
SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC 
FETCH NEXT 5 ROWS ONLY;

--returns the top 10 products with the highest inventory level
SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC 
FETCH NEXT 10 ROWS ONLY;

--using ties
SELECT
	product_name,
	quantity
FROM
	inventories
INNER JOIN products
		USING(product_id)
ORDER BY
	quantity DESC 
FETCH NEXT 10 ROWS WITH TIES;

--percentage of rows
SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC 
FETCH FIRST 5 PERCENT ROWS ONLY;

--offset
SELECT
	product_name,
	quantity
FROM
	inventories
INNER JOIN products
		USING(product_id)
ORDER BY
	quantity DESC 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;

--Assignment9
--inline views
SELECT
    *
FROM
    (
        SELECT
            product_id,
            product_name,
            list_price
        FROM
            products
        ORDER BY
            list_price DESC
    )
WHERE
    ROWNUM <= 10;

--Inline view joins with a table
SELECT
    category_name,
    max_list_price
FROM
    product_categories a,
    (
        SELECT
            category_id,
            MAX( list_price ) max_list_price
        FROM
            products
        GROUP BY
            category_id
    ) b
WHERE
    a.category_id = b.category_id
ORDER BY
    category_name;

-- LATERAL inline view
--occur error because the inline view cannot reference the tables from the outside of its definition.
SELECT
    category_name,
    product_name
FROM
    products p,
    (
        SELECT
            *
        FROM
            product_categories c
        WHERE
            c.category_id = p.category_id
    )
ORDER BY
    product_name;

--using lateral keyword
SELECT
    product_name,
    category_name
FROM
    products p,
    LATERAL(
        SELECT
            *
        FROM
            product_categories c
        WHERE
            c.category_id = p.category_id
    )
ORDER BY
    product_name;
    
--update
UPDATE
    (
        SELECT
            list_price
        FROM
            products
        INNER JOIN product_categories using (category_id)
        WHERE
            category_name = 'CPU'
    )
SET
    list_price = list_price * 1.15;
    
--delete
DELETE
    (
        SELECT
            list_price
        FROM
            products
        INNER JOIN product_categories
                USING(category_id)
        WHERE
            category_name = 'Video Card'
    )
WHERE
    list_price < 1000; 