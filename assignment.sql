--1Feb2022

SELECT  * FROM customers;
-- Sort the all customers details as per customer_id in ascending by name descending
SELECT 
    customer_id,name,address,website,credit_limit  
FROM
    customers
ORDER BY
    customer_id,name DESC;
-- Sort the all customers details as per customer_id,column_id   
SELECT 
    customer_id,name,address,credit_limit  
FROM
    customers
ORDER BY
    customer_id,credit_limit ;
    
--Sort the all customers details as per credit_limit
SELECT 
    customer_id,name,address,credit_limit  
FROM
    customers
ORDER BY
    credit_limit ;
    
--Display all customers with credit limit 200
SELECT 
    customer_id,name,address,credit_limit  
FROM
    customers
WHERE
    credit_limit=200;
    
--Display all customers with credit limit  100 or 200   
SELECT 
    customer_id,name,credit_limit
FROM
    customers
WHERE 
    credit_limit=100 or credit_limit=200;

SELECT 
    customer_id,name,credit_limit
FROM
    customers
WHERE 
    credit_limit IN(100,200);

--Display all customers with NOT credit limit of 100,200,300 
SELECT 
    customer_id,name,credit_limit
FROM
    customers
WHERE 
    credit_limit NOT IN(100,200,300);
    
SELECT  * FROM employees;
    
--Display all EMPLOYEES WITH no MANAGERID  i.e. managerid is null
SELECT 
    employee_id,first_name,last_name,manager_id
FROM
    employees
WHERE 
    manager_id IS NULL;
    
--Display all EMPLOYEES WITH some MANAGERID  i.e. managerid is not null
SELECT 
    employee_id,first_name,last_name,manager_id
FROM
    employees
WHERE 
    manager_id IS NOT NULL;
    
--Display all customers credit limit in range 500 to 5000 including boundry values
    
SELECT
    customer_id,name,address,credit_limit
FROM
    customers
WHERE
    credit_limit>=500 and credit_limit<=5000
ORDER BY
    credit_limit;
    
SELECT
    customer_id,name,address,credit_limit
FROM
    customers
WHERE
    credit_limit BETWEEN 500 and 5000
ORDER BY
    credit_limit;

--Display all customers credit limit in range 500 to 5000 excluding boundry values
SELECT
    customer_id,name,address,credit_limit
FROM
    customers
WHERE
    credit_limit>500 and credit_limit<5000
ORDER BY
    credit_limit;
    
--Display all customer credit limit not in range 500 to 5000
SELECT
    customer_id,name,address,credit_limit
FROM
    customers
WHERE
    credit_limit NOT BETWEEN 500 and 5000
ORDER BY
    credit_limit;

--Display all customer credit limit  5000  
SELECT
    customer_id,name,address,credit_limit
FROM
    customers
WHERE
    credit_limit = 5000
ORDER BY
    credit_limit;

--Display all CUSTOMERS of Univar
SELECT
    customer_id,name
FROM
    customers
WHERE
    name='Univar'
ORDER BY
    name;
    
--Display all CUSTOMERS of who's name starts with U
SELECT
    customer_id,name
FROM
    customers
WHERE
    name LIKE 'U%'
ORDER BY
    name;

--Display all CUSTOMERS ofwho's name ends with S
SELECT
    customer_id,name
FROM
    customers
WHERE
    name LIKE '%S'
ORDER BY
    name;
    
--Display all CUSTOMERS ofwho's name contains mm
SELECT
    customer_id,name
FROM
    customers
WHERE
    name LIKE '%mm%'
ORDER BY
    name;

--Display all CUSTOMERS ofwho's name contains _
SELECT
    customer_id,name
FROM
    customers
WHERE
    name LIKE'%\_%' ESCAPE '\' 
ORDER BY
    name;
    
--Display count of customers
SELECT
    COUNT(*)
FROM 
    customers;
    
--Display max,min,sum,avg of creditlimit
SELECT
    MIN(credit_limit),MAX(credit_limit),SUM(credit_limit),AVG(credit_limit),COUNT(credit_limit)
FROM 
    customers;
 
SELECT
    credit_limit, count(customer_id)
FROM 
    customers
GROUP BY
    credit_limit
ORDER BY 
    credit_limit;


SELECT 
       customer_id,MIN(credit_limit),MAX(credit_limit),SUM(credit_limit),ROUND(AVG(credit_limit),2),COUNT(credit_limit)
FROM 
    customers
GROUP BY
    customer_id
Having 
    avg(credit_limit)<2500
ORDER BY
    customer_id;
    
--02Feb2022
--text literal
--display unit price+20
SELECT unit_price+20
FROM order_items;

SELECT unit_price+'20'
FROM order_items;

--Date
--Display all the emp details joined on 07-jun-16
SElECT employee_id,first_name,last_name,email,phone,hire_date,manager_id,job_title
FROM employees
WHERE hire_date='07-jun-16';

SElECT employee_id,first_name,last_name,email,phone,hire_date,manager_id,job_title
FROM employees
WHERE hire_date=to_date('07-06-16','dd,mm,yy');

--to_char
SELECT TO_CHAR('1110'+1) FROM dual;

SELECT
  TO_CHAR( sysdate, 'YYYY-MM-DD' )
FROM
  dual;
  
SELECT
  TO_CHAR( sysdate, 'DL' )
FROM
  dual;
  
SELECT
  TO_CHAR( sysdate, 
                  'DL' , 
                  'NLS_DATE_LANGUAGE = FRENCH')
FROM
  dual;
  
SELECT
  first_name, 
  last_name, 
  TO_CHAR( hire_date, 'Q' ) joined_quarter
FROM
  employees
WHERE
  hire_date BETWEEN DATE  '2016-01-01'  AND date '2016-12-31'
ORDER BY
 first_name, last_name;
 

SELECT
  DECODE(country_id, 'US','United States', 'UK', 'United Kingdom', 'JP','Japan'
  , 'CA', 'Canada', 'CH','Switzerland', 'IT', 'Italy', country_id) country ,
  COUNT(*)
FROM
  locations
GROUP BY
  country_id
HAVING
  COUNT(*) > =2
ORDER BY
  country_id;

--case
SELECT
  product_name,
  list_price,
  CASE category_id
    WHEN 1
    THEN ROUND(list_price * 0.05,2) -- CPU
    WHEN 2
    THEN ROUND(List_price * 0.1,2)  -- Video Card
    ELSE ROUND(list_price * 0.08,2) -- other categories
  END discount
FROM
  products
ORDER BY
  product_name;

SELECT product_id,CASE
WHEN warehouse_id=1 then 'Southlake'
WHEN warehouse_id=2 then 'San Francisco'
WHEN warehouse_id=3 then 'New Jersey'
WHEN warehouse_id=4 then 'Seattle'
else'Non domestic'
end as Location FROM inventories 
WHERE product_id<1775;

--rank
SELECT 
	product_name, 
	list_price, 
	RANK() OVER(ORDER BY list_price DESC) 
FROM 
	products;

SELECT 
    product_name, 
    list_price, 
    RANK() OVER(ORDER BY list_price) 
FROM 
    products;    
    

SELECT 
	order_id,item_id,
    RANK() OVER(
			PARTITION BY item_id ORDER BY unit_price)"RANK"
 FROM 
	order_items;

--3FEB22
--denserank
SELECT
	order_id,unit_price,
	DENSE_RANK () OVER ( 
		ORDER BY unit_price DESC )"RANK"
        FROM order_items;

SELECT
	DENSE_RANK (8867.99) 
    WITHIN GROUP( ORDER BY unit_price DESC )"RANKDESC",
    DENSE_RANK (8867.99) 
    WITHIN GROUP( ORDER BY unit_price ASC )"RANKASC"
        FROM order_items;
        
SELECT order_id,unit_price,item_id,
DENSE_RANK() OVER (    
    PARTITION BY item_id     
    ORDER BY unit_price DESC)"rank_name" 
    FROM
	order_items;

--rowno
SELECT 
    ROW_NUMBER() OVER(
        ORDER BY list_price DESC
    ) row_num, 
    product_name, 
    list_price
FROM 
    products;
    
SELECT order_id,unit_price,item_id,
ROW_NUMBER() OVER (    
    PARTITION BY item_id     
    ORDER BY unit_price DESC)"rank_name" 
    FROM
	order_items;

SELECT employee_id,first_name,last_name,hire_date,manager_id
FROM employees
WHERE hire_date LIKE '%-JUN-16' order by manager_id desc;

--subquery
SELECT
    product_id,product_name,list_price
FROM
    products
WHERE
    list_price = (SELECT
            MAX( list_price )
        FROM
            products
    );

SELECT
    order_id,order_value
FROM
    (
        SELECT order_id,
            SUM( quantity * unit_price ) order_value
        FROM
            order_items
        GROUP BY
            order_id
        ORDER BY
            order_value DESC
    )
FETCH FIRST 10 ROWS ONLY; 

SELECT
    product_id,product_name,list_price
FROM
    products
WHERE
    list_price > (
        SELECT
            AVG( list_price )
        FROM
            products
    )
ORDER BY
    product_name;
    
SELECT
    employee_id,first_name,last_name
FROM
    employees
WHERE
    employee_id IN(
        SELECT
            salesman_id
        FROM
            orders
        INNER JOIN order_items
                USING(order_id)
        WHERE
            status = 'Shipped'
        GROUP BY
            salesman_id,
            EXTRACT(
                YEAR
            FROM
                order_date
            )
        HAVING
            SUM( quantity * unit_price )  >= 1000000  
            AND EXTRACT(
                YEAR
            FROM
                order_date) = 2017
            AND salesman_id IS NOT NULL
    )
ORDER BY
    first_name,last_name;

SELECT
    name
FROM
    customers
WHERE
    customer_id NOT IN(
        SELECT
            customer_id
        FROM
            orders
            
    )
ORDER BY
    name; 

--4feb22
--rewatched all the session regarding rank, denserank, subqueries
--completed the assignment
