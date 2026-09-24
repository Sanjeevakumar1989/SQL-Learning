
--(Comments) Notes to explain code,ignored during excution
--Customer Table analysis using(SELECT,DISTINCT,TOP,FROM,JOIN,WHERE,GROUP BY,HAVING,ORDER BY)
--Retrive data from customer only score condition data is >500 

--------------------------
--01_Database_and_Tables.sql
--------------------------

-- Show database name
SELECT name AS database_name
FROM sys.databases;

USE MyDatabase;

-- List tables and schema names
SELECT
    s.name AS Schema_Name,
    t.name AS Table_Name
FROM sys.tables t
INNER JOIN sys.schemas s
    ON s.schema_id = t.schema_id
ORDER BY Schema_Name, Table_Name;

-- View existing tables
SELECT * FROM orders;
SELECT * FROM customers;

---------------------------
--02_Select_and_Filtering.sql
----------------------------

-- Select specific columns
SELECT
    First_name,
    country,
    score
FROM customers;

-- Customers with score greater than 500
SELECT *
FROM customers
WHERE score > 500;

-- Customers with score not equal to 0
SELECT *
FROM customers
WHERE score != 0;

-- Customers from Germany
SELECT *
FROM customers
WHERE country = 'Germany';

-- Sort by score
SELECT *
FROM customers
ORDER BY score DESC;

-- Sort by country and score
SELECT *
FROM customers
ORDER BY country ASC, score DESC;

-------------------------------
--03_GroupBy_Having_OrderBy.sql
-------------------------------
-- Total score by country
SELECT
    country,
    SUM(score) AS Total_score
FROM customers
GROUP BY country
ORDER BY Total_score DESC;

-- Filter before grouping and after grouping
SELECT
    country,
    SUM(score) AS Total_score
FROM customers
WHERE score > 300
GROUP BY country
HAVING SUM(score) > 800;

-- Average score by country
SELECT
    country,
    AVG(score) AS Average_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;

---------------------
--04_Top_Distinct.sql
---------------------

-- Get unique countries
SELECT DISTINCT country
FROM customers;

-- Top 3 customers by score
SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

-- Top 3 customers by lowest score
SELECT TOP 3 *
FROM customers
ORDER BY score;

-- Latest 2 orders
SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC;

-----------------------
--05_SQL_Techniques.sql
-----------------------

-- Static number
SELECT 123 AS static_number;

-- Static string
SELECT 'Welcome' AS Static_string;

-- Add a calculated/static column
SELECT
    id,
    first_name,
    'New_customer' AS New_customer
FROM customers;

-------------------------
--06_DDL_and_Constraints.sql
--------------------------

-- Create table
CREATE TABLE Person
(
    id INT NOT NULL,
    Name VARCHAR(20) NOT NULL,
    birth_date DATE,
    Phone INT NOT NULL,
    CONSTRAINT PK_Person PRIMARY KEY (id)
);

-- Insert records
INSERT INTO Person
    (id, Name, Birth_date, Phone)
VALUES
    (1, 'Sanjeev', '2026-09-20', 888368280),
    (2, 'Muthu', '2026-07-20', 999968201),
    (3, 'Giri', '2026-06-05', 767682092),
    (4, 'Thanya', '2026-03-11', 888768201);

-- View records
SELECT *
FROM Person;
