<<<<<<< HEAD

------------------------
-- Comparison Operators
------------------------

-- Comparison Operators (=, !=, <>, <, <=, >, >=)

SELECT *
FROM customers
WHERE country = 'USA';

SELECT *
FROM customers
WHERE country != 'USA';

SELECT *
FROM customers
WHERE country = 'Germany';

SELECT *
FROM customers
WHERE country <> 'Germany';

SELECT *
FROM customers
WHERE score > 500;

SELECT *
FROM customers
WHERE score >= 500;

SELECT *
FROM customers
WHERE score < 500;

SELECT *
FROM customers
WHERE score <= 500;


------------------------
-- Logical Operators
------------------------

-- Logical Operators (AND, OR, NOT)
-- AND: Both conditions must be TRUE
-- OR: At least one condition must be TRUE
-- NOT: Returns the opposite of the condition

SELECT *
FROM customers
WHERE country = 'USA'
  AND score > 500;

SELECT *
FROM customers
WHERE country = 'USA'
   OR score > 500;

SELECT *
FROM customers
WHERE NOT country = 'USA';

SELECT *
FROM customers
WHERE NOT score > 500;


------------------------
-- Range Operator
------------------------

-- Range Operator (BETWEEN)
-- Returns values within the specified range
-- BETWEEN includes both boundary values

SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;

SELECT *
FROM customers
WHERE id BETWEEN 1 AND 4;

-- BETWEEN can also be written using comparison operators

SELECT *
FROM customers
WHERE score >= 100
  AND score <= 500;

SELECT *
FROM customers
WHERE id >= 1
  AND id <= 4;


------------------------
-- Membership Operators
------------------------

-- Membership Operators (IN, NOT IN)
-- IN: Matches any value in the specified list
-- NOT IN: Excludes values in the specified list

SELECT *
FROM customers
WHERE country IN ('Germany', 'UK');

SELECT *
FROM customers
WHERE country NOT IN ('Germany', 'UK');

-- Equivalent to IN using OR

SELECT *
FROM customers
WHERE country = 'Germany'
   OR country = 'UK';


------------------------
-- Search Operator
------------------------

-- Search Operator (LIKE)
-- % = zero or more characters
-- _ = exactly one character

SELECT *
FROM customers
WHERE first_name LIKE 'M%';

SELECT *
FROM customers
WHERE first_name LIKE '__o%';

SELECT *
FROM customers
WHERE first_name LIKE '%i_';

SELECT *
FROM customers
WHERE first_name LIKE '%r';

SELECT *
FROM customers
WHERE first_name LIKE '%r%';

SELECT *
FROM customers
WHERE first_name LIKE '%n';

SELECT *
FROM customers
WHERE first_name LIKE 'r%';

SELECT *
FROM customers
WHERE first_name LIKE '__r%';


------------------------
-- Joins
------------------------

-- View Customers and Orders tables

SELECT *
FROM customers;

SELECT *
FROM orders;


------------------------
-- Inner Join
------------------------

-- INNER JOIN returns only matching rows
-- between the Customers and Orders tables.

SELECT *
FROM customers c
INNER JOIN orders o
    ON c.id = o.customer_id;

SELECT
    c.id,
    c.first_name,
    c.country,
    o.order_date,
    o.sales
FROM customers c
INNER JOIN orders o
    ON c.id = o.customer_id;


------------------------
-- Left Join
------------------------

-- LEFT JOIN returns all rows from the left table
-- and matching rows from the right table.

SELECT *
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id;

SELECT *
FROM orders
LEFT JOIN customers
    ON orders.customer_id = customers.id;


------------------------
-- Right Join
------------------------

-- RIGHT JOIN returns all rows from the right table
-- and matching rows from the left table.

SELECT *
FROM customers c
RIGHT JOIN orders o
    ON c.id = o.customer_id;

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
RIGHT JOIN orders o
    ON o.customer_id = c.id;


-- Equivalent LEFT JOIN version
-- The table order is reversed.

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders o
LEFT JOIN customers c
    ON c.id = o.customer_id;


------------------------
-- Full Join
------------------------

-- FULL JOIN returns matching rows and
-- non-matching rows from both tables.

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
FULL JOIN orders o
    ON c.id = o.customer_id;


------------------------
-- Left Anti Join
------------------------

-- LEFT ANTI JOIN pattern
-- Get customers that do not have matching orders.

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
WHERE o.order_id IS NULL;


------------------------
-- Right Anti Join
------------------------

-- RIGHT ANTI JOIN pattern
-- Get orders that do not have matching customers.

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
RIGHT JOIN orders o
    ON c.id = o.customer_id
WHERE c.id IS NULL;


-- Equivalent LEFT JOIN version

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders o
LEFT JOIN customers c
    ON c.id = o.customer_id
WHERE c.id IS NULL;


------------------------
-- Full Anti Join
------------------------

-- Get unmatched rows from both tables.

SELECT *
FROM customers c
FULL JOIN orders o
    ON o.customer_id = c.id
WHERE c.id IS NULL
   OR o.customer_id IS NULL;


------------------------
-- LEFT JOIN with Matching Records
------------------------

-- Get customers that have matching orders.

SELECT *
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;


------------------------
-- Cross Join
------------------------

-- CROSS JOIN returns every possible combination
-- of rows from both tables.

SELECT *
FROM customers
CROSS JOIN orders;




=======

------------------------
-- Comparison Operators
------------------------

-- Comparison Operators (=, !=, <>, <, <=, >, >=)

SELECT *
FROM customers
WHERE country = 'USA';

SELECT *
FROM customers
WHERE country != 'USA';

SELECT *
FROM customers
WHERE country = 'Germany';

SELECT *
FROM customers
WHERE country <> 'Germany';

SELECT *
FROM customers
WHERE score > 500;

SELECT *
FROM customers
WHERE score >= 500;

SELECT *
FROM customers
WHERE score < 500;

SELECT *
FROM customers
WHERE score <= 500;


------------------------
-- Logical Operators
------------------------

-- Logical Operators (AND, OR, NOT)
-- AND: Both conditions must be TRUE
-- OR: At least one condition must be TRUE
-- NOT: Returns the opposite of the condition

SELECT *
FROM customers
WHERE country = 'USA'
  AND score > 500;

SELECT *
FROM customers
WHERE country = 'USA'
   OR score > 500;

SELECT *
FROM customers
WHERE NOT country = 'USA';

SELECT *
FROM customers
WHERE NOT score > 500;


------------------------
-- Range Operator
------------------------

-- Range Operator (BETWEEN)
-- Returns values within the specified range
-- BETWEEN includes both boundary values

SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;

SELECT *
FROM customers
WHERE id BETWEEN 1 AND 4;

-- BETWEEN can also be written using comparison operators

SELECT *
FROM customers
WHERE score >= 100
  AND score <= 500;

SELECT *
FROM customers
WHERE id >= 1
  AND id <= 4;


------------------------
-- Membership Operators
------------------------

-- Membership Operators (IN, NOT IN)
-- IN: Matches any value in the specified list
-- NOT IN: Excludes values in the specified list

SELECT *
FROM customers
WHERE country IN ('Germany', 'UK');

SELECT *
FROM customers
WHERE country NOT IN ('Germany', 'UK');

-- Equivalent to IN using OR

SELECT *
FROM customers
WHERE country = 'Germany'
   OR country = 'UK';


------------------------
-- Search Operator
------------------------

-- Search Operator (LIKE)
-- % = zero or more characters
-- _ = exactly one character

SELECT *
FROM customers
WHERE first_name LIKE 'M%';

SELECT *
FROM customers
WHERE first_name LIKE '__o%';

SELECT *
FROM customers
WHERE first_name LIKE '%i_';

SELECT *
FROM customers
WHERE first_name LIKE '%r';

SELECT *
FROM customers
WHERE first_name LIKE '%r%';

SELECT *
FROM customers
WHERE first_name LIKE '%n';

SELECT *
FROM customers
WHERE first_name LIKE 'r%';

SELECT *
FROM customers
WHERE first_name LIKE '__r%';


------------------------
-- Joins
------------------------

-- View Customers and Orders tables

SELECT *
FROM customers;

SELECT *
FROM orders;


------------------------
-- Inner Join
------------------------

-- INNER JOIN returns only matching rows
-- between the Customers and Orders tables.

SELECT *
FROM customers c
INNER JOIN orders o
    ON c.id = o.customer_id;

SELECT
    c.id,
    c.first_name,
    c.country,
    o.order_date,
    o.sales
FROM customers c
INNER JOIN orders o
    ON c.id = o.customer_id;


------------------------
-- Left Join
------------------------

-- LEFT JOIN returns all rows from the left table
-- and matching rows from the right table.

SELECT *
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id;

SELECT *
FROM orders
LEFT JOIN customers
    ON orders.customer_id = customers.id;


------------------------
-- Right Join
------------------------

-- RIGHT JOIN returns all rows from the right table
-- and matching rows from the left table.

SELECT *
FROM customers c
RIGHT JOIN orders o
    ON c.id = o.customer_id;

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
RIGHT JOIN orders o
    ON o.customer_id = c.id;


-- Equivalent LEFT JOIN version
-- The table order is reversed.

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders o
LEFT JOIN customers c
    ON c.id = o.customer_id;


------------------------
-- Full Join
------------------------

-- FULL JOIN returns matching rows and
-- non-matching rows from both tables.

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
FULL JOIN orders o
    ON c.id = o.customer_id;


------------------------
-- Left Anti Join
------------------------

-- LEFT ANTI JOIN pattern
-- Get customers that do not have matching orders.

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
WHERE o.order_id IS NULL;


------------------------
-- Right Anti Join
------------------------

-- RIGHT ANTI JOIN pattern
-- Get orders that do not have matching customers.

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
RIGHT JOIN orders o
    ON c.id = o.customer_id
WHERE c.id IS NULL;


-- Equivalent LEFT JOIN version

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders o
LEFT JOIN customers c
    ON c.id = o.customer_id
WHERE c.id IS NULL;


------------------------
-- Full Anti Join
------------------------

-- Get unmatched rows from both tables.

SELECT *
FROM customers c
FULL JOIN orders o
    ON o.customer_id = c.id
WHERE c.id IS NULL
   OR o.customer_id IS NULL;


------------------------
-- LEFT JOIN with Matching Records
------------------------

-- Get customers that have matching orders.

SELECT *
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;


------------------------
-- Cross Join
------------------------

-- CROSS JOIN returns every possible combination
-- of rows from both tables.

SELECT *
FROM customers
CROSS JOIN orders;

------------------------
-- Database and Schema
------------------------

-- Display all databases available in SQL Server
SELECT *
FROM sys.databases;


-- Switch to SalesDB database
USE SalesDB;


-- Display all tables and their schema names
SELECT
    t.name AS Table_Name,
    s.name AS Schema_Name
FROM sys.tables t
INNER JOIN sys.schemas s
    ON t.schema_id = s.schema_id;


------------------------
-- Sales Schema Tables
------------------------

-- Tables available in the Sales schema:
-- Employees
-- Customers
-- Orders
-- Products


-- View Orders table
SELECT *
FROM Sales.Orders;


-- View Customers table
SELECT *
FROM Sales.Customers;


-- View Products table
SELECT *
FROM Sales.Products;


-- View Employees table
SELECT *
FROM Sales.Employees;


------------------------
-- Multiple Table JOIN
------------------------

-- Retrieve order information along with:
-- Customer details
-- Product details
-- Employee/Salesperson details

SELECT
    O.OrderID,
    O.Sales,

    C.FirstName AS Customer_FirstName,
    C.LastName AS Customer_LastName,

    P.Product AS Product_Name,
    P.Price,

    E.FirstName AS Employee_FirstName,
    E.LastName AS Employee_LastName

FROM Sales.Orders O

-- Match Orders with Customers
LEFT JOIN Sales.Customers C
    ON O.CustomerID = C.CustomerID

-- Match Orders with Products
LEFT JOIN Sales.Products P
    ON O.ProductID = P.ProductID

-- Match Orders with Employees
LEFT JOIN Sales.Employees E
    ON O.SalesPersonID = E.EmployeeID;




>>>>>>> 281bbaa (SalesDB tables combined and done analysis)
