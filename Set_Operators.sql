-- ============================================================
-- SalesDB - Set Operators
-- ============================================================
-- Topics Covered:
-- 1. UNION
-- 2. UNION ALL
-- 3. EXCEPT
-- 4. INTERSECT
-- 5. Practical use case with Orders and OrdersArchive
-- ============================================================


-- ============================================================
-- 1. DATABASE AND TABLE INFORMATION
-- ============================================================

-- View all databases available in SQL Server
SELECT *
FROM sys.databases;


-- Switch to SalesDB database
USE SalesDB;


-- Display all tables along with their schema names
SELECT
    t.Name AS Table_Name,
    s.Name AS Schema_Name
FROM sys.tables t
INNER JOIN sys.schemas s
    ON t.schema_id = s.schema_id;


-- SalesDB tables used in this practice:
-- Employees
-- Customers
-- Orders
-- Products


-- ============================================================
-- 2. SET OPERATORS
-- ============================================================
-- Set operators are used to combine the results of
-- multiple SELECT queries into a single result set.
--
-- Main Set Operators:
-- 1. UNION
-- 2. UNION ALL
-- 3. EXCEPT
-- 4. INTERSECT
--
-- Important:
-- The SELECT statements combined using set operators
-- should have the same number of columns, and the
-- corresponding columns should have compatible data types.


-- ============================================================
-- 3. UNION
-- ============================================================
-- UNION combines the result sets of two SELECT queries.
--
-- UNION removes duplicate rows from the final result.
--
-- The column names in the final result are taken from
-- the FIRST SELECT statement.


SELECT
    FirstName AS First_Name,
    LastName AS Last_Name
FROM sales.Customers

UNION

SELECT
    FirstName,
    LastName
FROM sales.Employees;


-- ============================================================
-- 4. UNION ALL
-- ============================================================
-- UNION ALL combines the result sets of two SELECT queries.
--
-- Unlike UNION, UNION ALL does NOT remove duplicate rows.
--
-- UNION ALL is generally faster than UNION because SQL Server
-- does not need to perform duplicate elimination.


SELECT
    FirstName AS First_Name,
    LastName AS Last_Name
FROM sales.Customers

UNION ALL

SELECT
    FirstName,
    LastName
FROM sales.Employees;


-- View Employees data
SELECT *
FROM sales.Employees;


-- View Customers data
SELECT *
FROM sales.Customers;


-- ============================================================
-- 5. EXCEPT
-- ============================================================
-- EXCEPT returns distinct rows from the FIRST SELECT query
-- that are NOT present in the SECOND SELECT query.
--
-- Query order is important.
--
-- Example:
-- Employees EXCEPT Customers
-- = Employees who do not have the same FirstName + LastName
--   combination in Customers.


SELECT
    FirstName,
    LastName
FROM sales.Employees

EXCEPT

SELECT
    FirstName,
    LastName
FROM sales.Customers;


-- ============================================================
-- 6. INTERSECT
-- ============================================================
-- INTERSECT returns distinct rows that are common
-- between both SELECT queries.
--
-- Example:
-- Employees INTERSECT Customers
-- = FirstName + LastName combinations that exist
--   in both tables.


SELECT
    FirstName,
    LastName
FROM sales.Employees

INTERSECT

SELECT
    FirstName,
    LastName
FROM sales.Customers;


-- ============================================================
-- 7. PRACTICAL USE CASE - ORDERS AND ORDERS ARCHIVE
-- ============================================================
-- Business scenario:
-- Current orders are stored in the Orders table,
-- while older orders are stored in the OrdersArchive table.
--
-- We want to combine both tables into a single result set.


-- View current orders
SELECT *
FROM sales.Orders;


-- View archived orders
SELECT *
FROM sales.OrdersArchive;


-- Combine current and archived orders.
-- UNION removes duplicate rows.


SELECT *
FROM sales.Orders

UNION

SELECT *
FROM sales.OrdersArchive;


-- ============================================================
-- 8. UNION WITH SOURCE TABLE IDENTIFICATION
-- ============================================================
-- Add a column to identify which table the record came from.
--
-- 'Orders'       = Current Orders table
-- 'OrdersArchive' = Archived Orders table
--
-- This is useful when combining data from multiple sources
-- and tracking the original source of each record.


SELECT
    'Orders' AS Source_Table,
    [OrderID],
    [ProductID],
    [CustomerID],
    [SalesPersonID],
    [OrderDate],
    [ShipDate],
    [OrderStatus],
    [ShipAddress],
    [BillAddress],
    [Quantity],
    [Sales],
    [CreationTime]
FROM sales.Orders

UNION

SELECT
    'OrdersArchive' AS Source_Table,
    [OrderID],
    [ProductID],
    [CustomerID],
    [SalesPersonID],
    [OrderDate],
    [ShipDate],
    [OrderStatus],
    [ShipAddress],
    [BillAddress],
    [Quantity],
    [Sales],
    [CreationTime]
FROM sales.OrdersArchive

ORDER BY OrderID;


-- ============================================================
-- 9. SET OPERATORS - COMMON USE CASES
-- ============================================================
--
-- Set operators can be useful for:
--
-- 1. Combining results
--    UNION / UNION ALL can combine data from multiple queries.
--
-- 2. Combining information from multiple tables
--    Example: Customers + Employees
--
-- 3. Delta detection
--    EXCEPT can help identify rows present in one result
--    but missing from another result.
--
-- 4. Data completeness checks
--    EXCEPT can be used to compare two result sets.
--
-- 5. Day-wise data loading
--    EXCEPT can help identify records that already exist
--    or are missing when comparing source and target data.
--
-- Example:
-- If we need to load today's data into a database, we can
-- compare the incoming data with existing data and identify
-- differences before inserting new records.


-- ============================================================
-- END OF SET OPERATORS PRACTICE
-- ============================================================
