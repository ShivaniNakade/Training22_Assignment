--7FEB2022
--inner join
--1
SELECT
    *
FROM
    orders
INNER JOIN order_items ON
    order_items.order_id = orders.order_id
ORDER BY
    order_date DESC;

--2
SELECT
  *
FROM
  orders
INNER JOIN order_items USING( order_id )
ORDER BY
  order_date DESC;

--3  
SELECT
  name AS customer_name,
  order_id,
  order_date,
  item_id,
  quantity,
  unit_price
FROM
  orders
INNER JOIN order_items USING(order_id)
INNER JOIN customers USING(customer_id)
ORDER BY
  order_date DESC,
  order_id DESC,
  item_id ASC;

--4  
SELECT
	name AS customer_name,
	order_id,
	order_date,
	item_id,
	product_name,
	quantity,
	unit_price
FROM
	orders
INNER JOIN order_items
		USING(order_id)
INNER JOIN customers
		USING(customer_id)
INNER JOIN products
		USING(product_id)
ORDER BY
	order_date DESC,
	order_id DESC,
	item_id ASC;
    
--LEFT OUTER JOIN
--1
SELECT
  order_id, 
  status, 
  first_name, 
  last_name
FROM
  orders o
LEFT JOIN employees e ON o.salesman_id = e.employee_id
ORDER BY
  order_date DESC;

--2
SELECT
    order_id,
    name AS customer_name,
    status,
    first_name,
    last_name
FROM
    orders
LEFT JOIN employees ON
    employee_id = salesman_id
LEFT JOIN customers ON
    customers.customer_id = orders.customer_id
ORDER BY
    order_date DESC;
    
--3
SELECT
    name,
    order_id,
    status,
    order_date
FROM
    customers
LEFT JOIN orders
        USING(customer_id)
ORDER BY
    name;  

--4
SELECT
    order_id,
    status,
    employee_id,
    last_name
FROM
    orders
LEFT JOIN employees ON
    employee_id = salesman_id
WHERE
    order_id = 58;
--5
SELECT
    order_id,
    status,
    employee_id,
    last_name
FROM
    orders
LEFT JOIN employees ON
    employee_id = salesman_id
    AND order_id = 58;
    
--RIGHT OUTER JOIN 
--1
SELECT
    first_name,
    last_name,
    order_id,
    status
FROM
    orders
RIGHT JOIN employees ON
    employee_id = salesman_id
WHERE
    job_title = 'Sales Representative'
ORDER BY
    first_name,
    last_name;

--2
SELECT
    name,
    order_id,
    status
FROM
    orders
RIGHT JOIN customers
        USING(customer_id)
ORDER BY
    name;

--3
SELECT
    employee_id,
    last_name,
    first_name,
    order_id,
    status
FROM
    orders
RIGHT JOIN employees ON
    employee_id = salesman_id
WHERE
    employee_id = 57;
    
--4
SELECT
    employee_id,
    last_name,
    first_name,
    order_id,
    status
FROM
    orders
RIGHT JOIN employees ON
    employee_id = salesman_id
    AND employee_id = 57;
    
--OUTER JOIN
--1
SELECT 
    member_name, 
    project_name
FROM 
    members m
FULL OUTER JOIN projects p ON p.project_id = m.project_id
ORDER BY 
    member_name; 
    
--2
SELECT 
    project_name,
    member_name
FROM 
    members m
    FULL OUTER JOIN projects p 
        ON p.project_id = m.project_id
WHERE 
    member_name IS NULL
ORDER BY 
    member_name;    
    
--3
SELECT 
    member_name, 
    project_name
FROM 
    members m
    FULL OUTER JOIN projects p 
        ON p.project_id = m.project_id
WHERE 
    project_name IS NULL
ORDER BY 
    member_name;   
    
--CROSS JOIN
--1
SELECT
    product_id,
    warehouse_id,
    ROUND( dbms_random.value( 10, 100 )) quantity
FROM
    products 
CROSS JOIN warehouses;

--SELF JOIN
--1
SELECT
    (e.first_name || '  ' || e.last_name) employee,
    (m.first_name || '  ' || m.last_name) manager,
    e.job_title
FROM
    employees e
LEFT JOIN employees m ON
    m.employee_id = e.manager_id
ORDER BY
    manager;
    
--2
SELECT
   e1.hire_date,
  (e1.first_name || ' ' || e1.last_name) employee1,
  (e2.first_name || ' ' || e2.last_name) employee2  
FROM
    employees e1
INNER JOIN employees e2 ON
    e1.employee_id > e2.employee_id
    AND e1.hire_date = e2.hire_date
ORDER BY  
   e1.hire_date DESC,
   employee1, 
   employee2;
   
--Correlated Subquery with exist,not exist,any,all
--1 not exist
SELECT
    name
FROM
    customers
WHERE
    NOT EXISTS (
        SELECT
            NULL
        FROM
            orders
        WHERE
            orders.customer_id = customers.customer_id
    )
ORDER BY
    name;


--2 exist
SELECT
    name
FROM
    customers c
WHERE
    EXISTS (
        SELECT
            1
        FROM
            orders
        WHERE
            customer_id = c.customer_id
    )
ORDER BY
    name;
        

UPDATE
    warehouses w
SET
    warehouse_name = warehouse_name || ', USA'
WHERE
    EXISTS (
        SELECT
            1
         FROM
            locations
         WHERE
            country_id = 'US'
            AND location_id = w.location_id
    );
    
SELECT
	warehouse_name
FROM
	warehouses
INNER JOIN locations
		USING(location_id)
WHERE
	country_id = 'US';

--any
--4
SELECT
    product_name,
    list_price
FROM
    products
WHERE
    list_price > ANY(
        SELECT
            list_price
        FROM
            products
        WHERE
            category_id = 1
    )
ORDER BY
    product_name;

--5
SELECT
    product_name,
    list_price
FROM
    products
WHERE
    list_price = ANY(
        2200,
        2259.99,
        2269.99
    )
    AND category_id = 1;
--6
SELECT
    product_name,
    list_price
FROM
    products
WHERE
    list_price != ANY(
        2200,
        2259.99,
        2269.99
    )
    AND category_id = 1
ORDER BY
    list_price DESC;
--7
SELECT
    product_name,
    list_price
FROM
    products
WHERE
    list_price > ANY(
        2200,
        2259.99,
        2269.99
    )
    AND category_id = 1
ORDER BY
    list_price DESC;

--8
SELECT
    product_name,
    list_price
FROM
    products
WHERE
    list_price >= ANY(
        2200,
        2259.99,
        2269.99
    )
    AND category_id = 1
ORDER BY
    list_price DESC; 

--9
SELECT
    product_name,
    list_price
FROM
    products
WHERE
    list_price < ANY(
        2200,
        2259.99,
        2269.99
    )
    AND category_id = 1
ORDER BY
    list_price DESC;
    
--all
--10
SELECT product_name,
       list_price
FROM products
WHERE list_price > ALL
    ( SELECT list_price
     FROM products
     WHERE category_id = 1 )
ORDER BY product_name;

--11
SELECT
    product_name,
    list_price
FROM
    products
WHERE
    list_price > ALL(
        SELECT
            AVG( list_price )
        FROM
            products
        GROUP BY
            category_id
    )
ORDER BY
    list_price ASC;

--12
SELECT
    product_name,
    list_price
FROM
    products
WHERE
    list_price < ALL(
        SELECT
            AVG( list_price )
        FROM
            products
        GROUP BY
            category_id
    )
ORDER BY
    list_price DESC;
    
--13
SELECT
    product_name,
    list_price
FROM
    products
WHERE
    list_price <= ALL(
        977.99,
        1000,
        2200
    )
    AND category_id = 1
ORDER BY
    list_price DESC;
    

