--9FEB22
--union operator
SELECT
    first_name,
    last_name,
    email,
    'contact'
FROM
    contacts
UNION SELECT
    first_name,
    last_name,
    email,
    'employee'
FROM
    employees;

--Oracle UNION and ORDER BY 
SELECT
    first_name || ' ' || last_name name,
    email,
    'contact'
FROM
    contacts
UNION SELECT
    first_name || ' ' || last_name name,
    email,
    'employee'
FROM
    employees
ORDER BY
    name DESC;
    
--UNION ALL
SELECT
    last_name
FROM
    employees
UNION SELECT
    last_name
FROM
    contacts
ORDER BY
    last_name;

-- use UNION ALL instead of UNION
SELECT
    last_name
FROM
    employees
UNION ALL 
SELECT
    last_name
FROM
    contacts
ORDER BY
    last_name;

--Oracle INTERSECT operator
SELECT
    last_name
FROM
    contacts
INTERSECT 
SELECT
    last_name
FROM
    employees
ORDER BY
    last_name;
    
--Oracle MINUS Operator
SELECT
    last_name
FROM
    contacts
MINUS
SELECT
    last_name
FROM
    employees
ORDER BY
    last_name;
    
SELECT
  product_id
FROM
  products
MINUS
SELECT
  product_id
FROM
  inventories;