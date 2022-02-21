--table creation

CREATE TABLE Region 
( 
  RegionID  NUMBER NOT NULL, 
  RegionDescription  CHAR(50) NOT NULL, 
CONSTRAINT PK_Region 
  PRIMARY KEY (RegionID)
) 

CREATE TABLE Territories 
( 
  TerritoryID  VARCHAR2(20) NOT NULL, 
  TerritoryDescription  CHAR(50) NOT NULL, 
  RegionID  NUMBER NOT NULL, 
CONSTRAINT PK_Territories 
  PRIMARY KEY (TerritoryID), 
CONSTRAINT FK_Territories_Region FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
) 

CREATE TABLE Categories 
( 
  CategoryID  NUMBER NOT NULL, 
  CategoryName  VARCHAR2(15) NOT NULL, 
  Description  VARCHAR2(300), 
  Picture  LONG RAW, 
CONSTRAINT PK_Categories 
  PRIMARY KEY (CategoryID)
) 

CREATE TABLE Suppliers 
( 
  SupplierID  NUMBER NOT NULL, 
  CompanyName  VARCHAR2(40) NOT NULL, 
  ContactName  VARCHAR2(30), 
  ContactTitle  VARCHAR2(30), 
  Address  VARCHAR2(60), 
  City  VARCHAR2(15), 
  Region  VARCHAR2(15), 
  PostalCode  VARCHAR2(10), 
  Country  VARCHAR2(15), 
  Phone  VARCHAR2(24), 
  Fax  VARCHAR2(24), 
  HomePage  VARCHAR2(200), 
CONSTRAINT PK_Suppliers 
  PRIMARY KEY (SupplierID)
) 

CREATE TABLE Products 
( 
  ProductID  NUMBER NOT NULL, 
  ProductName  VARCHAR2(40) NOT NULL, 
  SupplierID  NUMBER, 
  CategoryID  NUMBER, 
  QuantityPerUnit  VARCHAR2(20), 
  UnitPrice  NUMBER, 
  UnitsInStock  NUMBER, 
  UnitsOnOrder  NUMBER, 
  ReorderLevel  NUMBER, 
  Discontinued  NUMBER(1) NOT NULL, 
CONSTRAINT PK_Products PRIMARY KEY (ProductID), 
CONSTRAINT CK_Products_UnitPrice   CHECK ((UnitPrice >= 0)), 
CONSTRAINT CK_ReorderLevel   CHECK ((ReorderLevel >= 0)), 
CONSTRAINT CK_UnitsInStock   CHECK ((UnitsInStock >= 0)), 
CONSTRAINT CK_UnitsOnOrder   CHECK ((UnitsOnOrder >= 0)), 
CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID), 
CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
) 

CREATE TABLE Shippers 
( 
  ShipperID  NUMBER NOT NULL, 
  CompanyName  VARCHAR2(40) NOT NULL, 
  Phone  VARCHAR2(24), 
CONSTRAINT PK_Shippers 
  PRIMARY KEY (ShipperID)
) 

CREATE TABLE Customers 
( 
  CustomerID  CHAR(5) NOT NULL, 
  CompanyName  VARCHAR2(40) NOT NULL, 
  ContactName  VARCHAR2(30), 
  ContactTitle  VARCHAR2(30), 
  Address  VARCHAR2(60), 
  City  VARCHAR2(15), 
  Region  VARCHAR2(15), 
  PostalCode  VARCHAR2(10), 
  Country  VARCHAR2(15), 
  Phone  VARCHAR2(24), 
  Fax  VARCHAR2(24), 
CONSTRAINT PK_Customers 
  PRIMARY KEY (CustomerID)
) 

CREATE TABLE Employees 
( 
  EmployeeID  NUMBER NOT NULL, 
  LastName  VARCHAR2(20) NOT NULL, 
  FirstName  VARCHAR2(10) NOT NULL, 
  Title  VARCHAR2(30), 
  TitleOfCourtesy  VARCHAR2(25), 
  BirthDate  DATE, 
  HireDate  DATE, 
  Address  VARCHAR2(60), 
  City  VARCHAR2(15), 
  Region  VARCHAR2(15), 
  PostalCode  VARCHAR2(10), 
  Country  VARCHAR2(15), 
  HomePhone  VARCHAR2(24), 
  Extension  VARCHAR2(4), 
  Photo  LONG RAW, 
  Notes  VARCHAR2(600), 
  ReportsTo  NUMBER, 
  PhotoPath  VARCHAR2(255), 
CONSTRAINT PK_Employees 
  PRIMARY KEY (EmployeeID), 
CONSTRAINT FK_Employees_Employees FOREIGN KEY (ReportsTo) REFERENCES Employees(EmployeeID)
) 

CREATE TABLE EmployeeTerritories 
( 
  EmployeeID  NUMBER NOT NULL, 
  TerritoryID  VARCHAR2(20) NOT NULL, 
CONSTRAINT PK_EmpTerritories 
  PRIMARY KEY (EmployeeID, TerritoryID), 
CONSTRAINT FK_EmpTerri_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID), 
CONSTRAINT FK_EmpTerri_Territories FOREIGN KEY (TerritoryID) REFERENCES Territories(TerritoryID)
) 

CREATE TABLE CustomerDemographics 
( 
  CustomerTypeID  CHAR(10) NOT NULL, 
  CustomerDesc  LONG, 
CONSTRAINT PK_CustomerDemographics 
  PRIMARY KEY (CustomerTypeID)
) 

CREATE TABLE CustomerCustomerDemo 
( 
  CustomerID  CHAR(5) NOT NULL, 
  CustomerTypeID  CHAR(10) NOT NULL, 
CONSTRAINT PK_CustomerDemo 
  PRIMARY KEY (CustomerID, CustomerTypeID), 
CONSTRAINT FK_CustomerDemo FOREIGN KEY (CustomerTypeID) REFERENCES CustomerDemographics(CustomerTypeID), 
CONSTRAINT FK_CustomerDemo_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
) 

CREATE TABLE Orders 
( 
  OrderID  NUMBER NOT NULL, 
  CustomerID  CHAR(5), 
  EmployeeID  NUMBER, 
  TerritoryID  VARCHAR2(20), 
  OrderDate  DATE, 
  RequiredDate  DATE, 
  ShippedDate  DATE, 
  ShipVia  NUMBER, 
  Freight  NUMBER, 
  ShipName  VARCHAR2(40), 
  ShipAddress  VARCHAR2(60), 
  ShipCity  VARCHAR2(15), 
  ShipRegion  VARCHAR2(15), 
  ShipPostalCode  VARCHAR2(10), 
  ShipCountry  VARCHAR2(15), 
CONSTRAINT PK_Orders 
  PRIMARY KEY (OrderID), 
CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), 
CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID), 
CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperID),
CONSTRAINT FK_Orders_Territories FOREIGN KEY (TerritoryID) REFERENCES Territories(TerritoryID)
) 

CREATE TABLE OrderDetails 
( 
  OrderID  NUMBER NOT NULL, 
  ProductID  NUMBER NOT NULL, 
  UnitPrice  NUMBER NOT NULL, 
  Quantity  NUMBER NOT NULL, 
  Discount  NUMBER NOT NULL, 
CONSTRAINT PK_Order_Details 
  PRIMARY KEY (OrderID, ProductID), 
CONSTRAINT CK_Discount   CHECK ((Discount >= 0 and Discount <= 1)), 
CONSTRAINT CK_Quantity   CHECK ((Quantity > 0)), 
CONSTRAINT CK_UnitPrice   CHECK ((UnitPrice >= 0)), 
CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), 
CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
)

--data insertion
--after inserting data into tables

--Get a list of latest order IDs for all customers by using the max function on Order_ID column.
SELECT
    CUSTOMERID,
    MAX( ORDERID )
FROM
    CUSTOMERS
INNER JOIN ORDERS
        USING(CUSTOMERID)
GROUP BY 
   CUSTOMERID
ORDER BY
    MAX(ORDERID) DESC;

--Find suppliers who sell more than one product to Northwind Trader.

SELECT s.supplierid,s.companyname
FROM suppliers s
INNER JOIN products p
ON s.supplierid=p.supplierid
WHERE p.supplierid > (SELECT count(productid) FROM products 
GROUP BY supplierid 
HAVING count(productid)>1
order by count(productid));


--Create a function to get latest order date for entered customer_id
CREATE OR REPLACE FUNCTION latest_order_date (customer_id NUMBER)
RETURN DATE
IS
l_orderdate orders.orderdate%TYPE;
BEGIN
SELECT orderdate INTO l_orderdate
FROM orders
ORDER BY orderdate DESC
FETCH FIRST 1 ROW ONLY;
RETURN l_orderdate;
END;


--###calling function
DECLARE
order_date orders.orderdate%TYPE
BEGIN
customer_id=latest_order_date('BONAP')
DBMS_OUTPUT.PUT_LINE(orderdate)
END;


--Get the top 10 most expensive products.
SELECT * FROM (SELECT PRODUCTNAME, UNITPRICE FROM PRODUCTS ORDER BY Unitprice desc) 
WHERE ROWNUM <= 10;
--another way
SELECT * FROM
(
    SELECT DISTINCT ProductName as EXPENSIVE_PRODUCTS, 
           UnitPrice
    from Products
    order by UnitPrice desc
)
FETCH NEXT 10 ROWS ONLY;

--Rank products by the number of units in stock in each product category

SELECT DENSE_RANK() OVER(PARTITION BY categoryid 
                        ORDER BY unitsinstock) productrank,productid,productname,categoryid,unitsinstock 
FROM products;

--Rank customers by the total sales amount within each order date

SELECT DENSE_RANK() OVER(PARTITION BY o.orderdate ORDER BY (ord.unitprice*ord.quantity) DESC),o.orderdate from customers c INNER JOIN orders o
USING (customerid) INNER JOIN orderdetails ord USING (orderid) ;

--For each order, calculate a subtotal for each Order (identified by OrderID)
select OrderID, 
to_char(sum(UnitPrice * Quantity * (1 - Discount)), '$99,999.99') as Subtotal
from OrderDetails
group by OrderID
order by OrderID;

--Sales by Year for each order. Hint: Get Subtotal as sum(UnitPrice * Quantity * (1 - Discount)) for every order_id then join with orders table
select distinct a.ShippedDate, 
    a.OrderID, 
    b.Subtotal, 
    to_char(a.ShippedDate,'YYYY') as "Year"
from Orders a 
inner join
(
--Get subtotal for each order
    select distinct OrderID, 
        to_char(sum(UnitPrice * Quantity * (1 - Discount)), '$99,999.99') as Subtotal
    from OrderDetails
    group by OrderID    
) b on a.OrderID = b.OrderID
where a.ShippedDate is not null
    and a.ShippedDate between to_date('24/12/1996', 'DD/MM/YYYY') 
                               and to_date('30/09/1997', 'DD/MM/YYYY')
order by a.ShippedDate;

--Get Employee sales by country names
select distinct a.Country, 
    a.LastName, 
    a.FirstName, 
    b.ShippedDate, 
    b.OrderID, 
    c.Subtotal as Sale_Amount
from Employees a
inner join Orders b on b.EmployeeID = a.EmployeeID
inner join 
(
    -- Get subtotal for each order
    select distinct OrderID, 
        to_char(sum(UnitPrice * Quantity * (1 - Discount)), '$99,999.99') as Subtotal
    from OrderDetails
    group by OrderID    
) c on b.OrderID = c.OrderID
where b.ShippedDate between to_date('24/12/1996', 'DD/MM/YYYY') 
                             and to_date('30/09/1997', 'DD/MM/YYYY')
order by a.LastName, a.FirstName, a.Country, b.ShippedDate;

--Alphabetical list of products
select distinct b.*, a.CategoryName
from Categories a 
inner join Products b on a.CategoryID = b.CategoryID
where b.Discontinued = 0
order by b.ProductName;

--Display the current Productlist Hint: Discontinued='N'
select ProductID, ProductName
from Products
where Discontinued = 0
order by ProductName;

--Calculate sales price for each order after discount is applied.
select distinct y.OrderID, 
    y.ProductID, 
    x.ProductName, 
    y.UnitPrice, 
    y.Quantity, 
    y.Discount, 
    y.UnitPrice * y.Quantity * (1 - y.Discount) as Extendedprice
from Products x
inner join OrderDetails y on x.ProductID = y.ProductID
order by y.OrderID;

--Sales by Category: For each category, we get the list of products sold and the total sales amount.
select distinct a.CategoryID, 
    a.CategoryName, 
    b.ProductName, 
    sum(c.ExtendedPrice) as ProductSales
from Categories a 
inner join Products b on a.CategoryID = b.CategoryID
inner join 
(
    select distinct y.OrderID, 
        y.ProductID, 
        x.ProductName, 
        y.UnitPrice, 
        y.Quantity, 
        y.Discount, 
        y.UnitPrice * y.Quantity * (1 - y.Discount) as ExtendedPrice
    from Products x
    inner join OrderDetails y on x.ProductID = y.ProductID
    order by y.OrderID
) c on c.ProductID = b.ProductID
inner join Orders d on d.OrderID = c.OrderID
where d.OrderDate between to_date('1/1/1997', 'DD/MM/YYYY') 
                           and to_date('31/12/1997', 'DD/MM/YYYY')
group by a.CategoryID, a.CategoryName, b.ProductName
order by a.CategoryName, b.ProductName, ProductSales;

--Sales by Category: For each category, we get the list of products sold and the total sales amount.
SELECT c.categoryid,c.categoryname,p.productname
FROM categories c
INNER JOIN products p
ON c.categoryid=p.categoryid;

--Displays products(productname,unitprice) who?s price is greater than avg(price)

CREATE OR REPLACE VIEW vwproducts_above_averageprice
AS
SELECT productname,unitprice
FROM products
WHERE unitprice >(
SELECT AVG(unitprice)
FROM products)
ORDER BY unitprice;

--Display product(productname), customers(companyname), orders(orderyear)

CREATE OR REPLACE VIEW vwquarterly_ordersby_product
AS
SELECT p.productname,c.companyname,EXTRACT(YEAR FROM o.orderdate) orderyear
FROM customers c
INNER JOIN orders o
ON c.customerid=o.customerid
INNER JOIN orderdetails ord
ON o.orderid=ord.orderid
INNER JOIN products p
ON ord.productid=p.productid;

--Display Supplier Continent wise sum of unitinstock.

CREATE OR REPLACE VIEW vwunitsinstock
AS
SELECT SUM(p.unitprice) as totalprice,'UK' AS continent 
from suppliers s
INNER JOIN products p
USING (supplierid)
WHERE s.country IN ('UK','Spain','Sweden','Germany','Norway','Denmark','Netherlands','Finland','Italy','France') 
UNION
SELECT SUM(p.unitprice) as totalprice,'America' AS continent 
from suppliers s
INNER JOIN products p
USING (supplierid)
WHERE s.country IN ('USA','Canada','Brazil','Asia-Pacific');

--Display top 10 expensive products

CREATE OR REPLACE VIEW vw10most_expensive_products
AS
SELECT productid,productname,unitprice 
FROM products 
ORDER BY unitprice DESC 
FETCH FIRST 10 ROWS;

--Display customer supplier by city

CREATE OR REPLACE VIEW vwcustomer_supplier_bycity
AS
SELECT city,companyname,contactname,'suppliers' as relationship
FROM suppliers
UNION
SELECT city,companyname,contactname,'customers' as relationship
FROM customers;






























