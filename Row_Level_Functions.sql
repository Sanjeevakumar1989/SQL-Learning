-- ============================================================
-- SQL Server Functions Practice
-- Database: SalesDB / MyDatabase
-- Topics:
--   1. Database & Table Information
--   2. String Functions
--   3. Number Functions
--   4. Date & Time Functions
--   5. Date Formatting
--   6. Type Conversion
--   7. Date Calculations
--   8. NULL Handling
--   9. CASE Statements
--  10. Self Join / Employee Mapping
--  11. Customer & Order Analysis
-- ============================================================


-- ============================================================
-- 1. DATABASE AND TABLE INFORMATION
-- ============================================================

-- Display all databases available in the SQL Server instance.
SELECT Name
FROM sys.databases;

-- Switch to the SalesDB database.
USE SalesDB;

-- Display all tables and their corresponding schemas.
SELECT
    T.Name AS Table_Name,
    S.Name AS Schema_Name
FROM sys.tables T
INNER JOIN sys.schemas S
    ON T.schema_id = S.schema_id;


-- ============================================================
-- 2. STRING FUNCTIONS
-- ============================================================

-- ------------------------------------------------------------
-- CONCAT()
-- Combine FirstName and Country into a single column.
-- ------------------------------------------------------------

SELECT *
FROM sales.Customers;

SELECT
    CONCAT(FirstName, ' ', Country) AS FirstName_with_Country
FROM sales.Customers;


-- ------------------------------------------------------------
-- UPPER()
-- Convert FirstName values to uppercase.
-- ------------------------------------------------------------

SELECT
    UPPER(FirstName) AS First_Name
FROM sales.Customers;


-- ------------------------------------------------------------
-- LOWER()
-- Convert FirstName values to lowercase.
-- ------------------------------------------------------------

SELECT
    LOWER(FirstName) AS First_Name
FROM sales.Customers;


-- ------------------------------------------------------------
-- TRIM()
-- Remove leading and trailing spaces from FirstName.
-- ------------------------------------------------------------

SELECT
    TRIM(FirstName) AS First_Name
FROM sales.Customers;


-- Compare original and trimmed values.
SELECT
    FirstName,
    LEN(FirstName) AS FirstName_Length
FROM sales.Customers;


-- Switch to MyDatabase for the following examples.
USE MyDatabase;

SELECT *
FROM Customers;


-- Find records where FirstName contains leading/trailing spaces.
SELECT
    First_Name
FROM Customers
WHERE First_Name <> TRIM(First_Name);


-- Compare original length with trimmed length.
-- The difference can help identify unwanted spaces.
SELECT
    First_Name,
    LEN(First_Name) AS Len_First_Name,
    LEN(TRIM(First_Name)) AS Len_Trim_First_Name,
    LEN(First_Name) - LEN(TRIM(First_Name)) AS Space_Flag
FROM Customers
WHERE First_Name <> TRIM(First_Name);


-- ------------------------------------------------------------
-- REPLACE()
-- Replace one text value with another value.
-- ------------------------------------------------------------

SELECT
    'sanjeev' AS Name,
    REPLACE('sanjeev', 'e', 'i') AS Replaced_Name;


-- Replace '-' with ',' in a phone number.
SELECT
    '123-4567,980' AS Phone,
    REPLACE('123-4567,980', '-', ',') AS Replaced_Phone;


-- Replace ',' with '-' in a phone number.
SELECT
    '123-4567,980' AS Phone,
    REPLACE('123-4567,980', ',', '-') AS Replaced_Phone;


-- Replace UK with INDIA only in the displayed result.
-- This SELECT does NOT permanently change the table.
SELECT
    First_Name,
    REPLACE(Country, 'UK', 'INDIA') AS Country
FROM Customers;


-- Example of UPDATE:
-- This permanently changes the country value for Customer ID 3.
UPDATE Customers
SET Country = 'UK'
WHERE ID = 3;

SELECT *
FROM Customers;


-- ------------------------------------------------------------
-- CASE expression
-- Display Score as 100 when Score is 0.
-- Other score values remain unchanged.
-- This does NOT permanently update the table.
-- ------------------------------------------------------------

SELECT
    First_Name,
    Country,
    CASE
        WHEN Score = 0 THEN 100
        ELSE Score
    END AS Score
FROM Customers;


-- ------------------------------------------------------------
-- LEN()
-- Return the number of characters in a string.
-- ------------------------------------------------------------

SELECT
    First_Name,
    LEN(First_Name) AS Len_First_Name
FROM Customers;


-- ------------------------------------------------------------
-- LEFT()
-- Extract a specified number of characters from the beginning.
-- ------------------------------------------------------------

SELECT
    First_Name,
    LEFT(TRIM(First_Name), 2) AS First_2_Characters
FROM Customers;


-- ------------------------------------------------------------
-- RIGHT()
-- Extract a specified number of characters from the end.
-- ------------------------------------------------------------

SELECT
    First_Name,
    RIGHT(First_Name, 2) AS Last_2_Characters
FROM Customers;


-- ------------------------------------------------------------
-- SUBSTRING()
-- Extract part of FirstName starting from the second character.
-- ------------------------------------------------------------

SELECT
    First_Name,
    SUBSTRING(TRIM(First_Name), 2, LEN(First_Name)) AS Sub_Name
FROM Customers;


-- Function summary:
-- REPLACE() -> Replace text inside a string.
-- CASE      -> Conditionally return a value.
-- UPDATE    -> Permanently change stored data.


-- ============================================================
-- 3. NUMBER FUNCTIONS
-- ============================================================

-- ------------------------------------------------------------
-- ROUND()
-- Round decimal numbers to the specified number of digits.
-- ------------------------------------------------------------

SELECT
    3.596 AS Round_Number,
    ROUND(3.591, 2) AS Round_2,
    ROUND(3.596, 1) AS Round_1,
    ROUND(3.596, 0) AS Round_0;


-- ============================================================
-- 4. DATE AND TIME FUNCTIONS
-- ============================================================

USE SalesDB;

SELECT *
FROM sales.Orders;


-- Display order dates, shipping dates, creation time,
-- and the current server date/time.
SELECT
    OrderID,
    OrderDate,
    ShipDate,
    CreationTime,
    GETDATE() AS Today_Date
FROM sales.Orders;


-- ------------------------------------------------------------
-- DATETRUNC()
-- Resets the lower-level date/time values to the specified
-- date part such as hour, minute, day, month, or year.
--
-- DATEPART() returns the numeric part of a date.
--
-- DATENAME() returns the name/text representation.
-- ------------------------------------------------------------

SELECT
    OrderID,
    CreationTime,

    -- DATETRUNC examples
    DATETRUNC(HOUR, CreationTime) AS Hour_DT,
    DATETRUNC(MINUTE, CreationTime) AS Minute_DT,
    DATETRUNC(DAY, CreationTime) AS Day_DT,
    DATETRUNC(MONTH, CreationTime) AS Month_DT,

    -- DATEPART examples
    DATEPART(DAY, CreationTime) AS Day_DP,
    DATEPART(MONTH, CreationTime) AS Month_DP,
    DATEPART(YEAR, CreationTime) AS Year_DP,
    DATEPART(HOUR, CreationTime) AS Hour_DP,
    DATEPART(WEEK, CreationTime) AS Week_DP,
    DATEPART(QUARTER, CreationTime) AS Quarter_DP,

    -- DATENAME examples
    DATENAME(MONTH, CreationTime) AS Month_DN,
    DATENAME(WEEKDAY, CreationTime) AS Weekday_DN,
    DATENAME(YEAR, CreationTime) AS Year_DN,

    -- Individual date functions
    DAY(CreationTime) AS Day,
    MONTH(CreationTime) AS Month,
    YEAR(CreationTime) AS Year

FROM sales.Orders;


-- ============================================================
-- 5. DATETRUNC() USE CASE
-- ============================================================

-- Count orders at the exact CreationTime level.
SELECT
    CreationTime,
    COUNT(*) AS Total_Count
FROM sales.Orders
GROUP BY CreationTime;


-- Count orders month-wise.
SELECT
    DATETRUNC(MONTH, CreationTime) AS Month_Order,
    COUNT(*) AS Total_Count
FROM sales.Orders
GROUP BY DATETRUNC(MONTH, CreationTime);


-- Count orders year-wise.
SELECT
    DATETRUNC(YEAR, CreationTime) AS Yearly_Order,
    COUNT(*) AS Total_Count
FROM sales.Orders
GROUP BY DATETRUNC(YEAR, CreationTime);


-- ============================================================
-- 6. EOMONTH()
-- ============================================================

-- EOMONTH() returns the last date of the month.
-- DATETRUNC(MONTH) identifies the beginning of the month.

SELECT
    CreationTime,
    EOMONTH(CreationTime) AS End_Of_Month,
    CAST(DATETRUNC(MONTH, CreationTime) AS DATE) AS Start_Of_Month
FROM sales.Orders;


-- ============================================================
-- 7. MONTH-WISE ORDER ANALYSIS
-- ============================================================

-- Count the number of orders for each month.
SELECT
    DATENAME(MONTH, OrderDate) AS Month_Name,
    COUNT(*) AS Total_Order
FROM sales.Orders
GROUP BY DATENAME(MONTH, OrderDate);


-- Filter orders for February.
SELECT *
FROM sales.Orders
WHERE MONTH(OrderDate) = 2;


-- Filter orders for January.
SELECT *
FROM sales.Orders
WHERE MONTH(OrderDate) = 1;


-- ============================================================
-- DATE FUNCTION OUTPUT TYPES
-- ============================================================

/*
DATEPART  -> Integer
DAY       -> Integer
MONTH     -> Integer
YEAR      -> Integer

DATENAME  -> String

DATETRUNC -> DATETIME / date-time value

EOMONTH   -> DATE
*/


-- ============================================================
-- 8. DATE FORMATTING
-- ============================================================

-- FORMAT() can be used to display dates in different formats.

SELECT
    CreationTime,

    FORMAT(CreationTime, 'dd') AS DD,
    FORMAT(CreationTime, 'ddd') AS DDD,
    FORMAT(CreationTime, 'dddd') AS DDDD,

    FORMAT(CreationTime, 'MM') AS MM,
    FORMAT(CreationTime, 'MMM') AS MMM,
    FORMAT(CreationTime, 'MMMM') AS MMMM,

    FORMAT(CreationTime, 'MM-dd-yyyy') AS USA_Standard,
    FORMAT(CreationTime, 'yyyy-MM-dd') AS ISO_Standard,
    FORMAT(CreationTime, 'dd-MM-yyyy') AS Europe_Standard

FROM sales.Orders;


-- Create a custom date/time display.
SELECT
    CreationTime,
    'Day '
    + FORMAT(CreationTime, 'ddd MMM')
    + ' Q'
    + DATENAME(QUARTER, CreationTime)
    + FORMAT(CreationTime, ' yyyy HH:mm:ss tt') AS Customer_Format
FROM sales.Orders;


-- ============================================================
-- 9. CONVERT()
-- ============================================================

-- CONVERT() converts a value from one data type to another.

SELECT
    CreationTime,
    CONVERT(DATE, CreationTime) AS Date,

    -- Examples of other conversions:
    -- CONVERT(INT, '123') AS String_To_Integer,
    -- CONVERT(DATE, '2026-09-09') AS String_To_Date,

    CONVERT(VARCHAR, CreationTime, 32) AS USA_Standard_Style_32,
    CONVERT(VARCHAR, CreationTime, 34) AS Europe_Standard_Style_34

FROM sales.Orders;


-- ============================================================
-- 10. CAST()
-- ============================================================

-- CAST() is used to convert one data type into another.

SELECT
    CAST('123' AS INT) AS String_To_Integer,
    CAST('2026-09-05' AS DATE) AS String_To_Date,
    CreationTime,
    CAST(CreationTime AS DATE) AS Datetime_To_Date
FROM sales.Orders;


-- ============================================================
-- 11. DATEADD()
-- ============================================================

-- Syntax:
-- DATEADD(datepart, interval, date)

SELECT
    OrderDate,
    DATEADD(YEAR, 3, OrderDate) AS Three_Years_Later,
    DATEADD(MONTH, 5, OrderDate) AS Five_Months_Later,
    DATEADD(DAY, -5, OrderDate) AS Five_Days_Before
FROM sales.Orders;


-- ============================================================
-- 12. DATEDIFF()
-- ============================================================

-- Syntax:
-- DATEDIFF(datepart, startdate, enddate)

SELECT
    DATEDIFF(YEAR, OrderDate, ShipDate) AS Difference_Year,
    DATEDIFF(DAY, '2026-06-08', '2026-10-19') AS Difference_Day,
    DATEDIFF(MONTH, '2026-06-08', '2026-10-19') AS Difference_Month
FROM sales.Orders;


-- Calculate age using DATEDIFF().
SELECT
    DATEDIFF(YEAR, '1989-05-30', GETDATE()) AS Sanjeev_Age,
    DATEDIFF(YEAR, '2000-06-10', GETDATE()) AS Muthu_Age,
    DATEDIFF(YEAR, '2019-10-19', GETDATE()) AS Giri_Age,
    DATEDIFF(YEAR, '2022-06-08', GETDATE()) AS Thanya_Age
FROM sales.Employees;


-- ============================================================
-- 13. SHIPPING TIME ANALYSIS
-- ============================================================

-- Calculate the average number of days taken to ship orders
-- for each order month.

SELECT
    MONTH(OrderDate) AS Average_Order_Month,
    AVG(DATEDIFF(DAY, OrderDate, ShipDate)) AS Days_To_Ship
FROM sales.Orders
GROUP BY MONTH(OrderDate);


-- ============================================================
-- 14. TIME GAP ANALYSIS
-- ============================================================

-- Compare each order with the previous order.
-- LAG() retrieves the previous OrderDate.

SELECT
    OrderID,
    OrderDate AS Current_OrderDate,
    LAG(OrderDate) OVER (ORDER BY OrderDate) AS Previous_OrderDate,
    DATEDIFF(
        DAY,
        LAG(OrderDate) OVER (ORDER BY OrderDate),
        OrderDate
    ) AS Number_Of_Days
FROM sales.Orders;


-- ============================================================
-- 15. NULL HANDLING
-- ============================================================

-- ISNULL() and COALESCE() can be used to handle NULL values.

SELECT *
FROM sales.Customers;


-- Calculate the average customer score.
SELECT
    CustomerID,
    FirstName,
    Score,
    COALESCE(Score, 0) AS Score_Replace_0_If_NULL,
    AVG(Score) OVER () AS Average_Score
FROM sales.Customers;


-- Combine FirstName and LastName.
-- Add 10 bonus points to the score.
SELECT
    FirstName,
    LastName,
    CONCAT(FirstName, ' ', LastName) AS Customer_Name,
    Score,
    COALESCE(Score, 0) + 10 AS Bonus_10_Points
FROM sales.Customers;


-- Example of setting a score to NULL.
UPDATE sales.Customers
SET Score = NULL
WHERE CustomerID = 5;


-- Display customers ordered by score.
SELECT
    CustomerID,
    Score
FROM sales.Customers
ORDER BY Score ASC;


-- ============================================================
-- 16. SORT NULL VALUES LAST
-- ============================================================

-- Method 1:
-- Replace NULL with a large value for sorting purposes.

SELECT
    CustomerID,
    Score,
    COALESCE(Score, 1111111) AS Score_For_Sorting
FROM sales.Customers
ORDER BY COALESCE(Score, 1111111);


-- Method 2:
-- Use CASE to place NULL values after non-NULL values.

SELECT
    CustomerID,
    Score
FROM sales.Customers
ORDER BY
    CASE
        WHEN Score IS NULL THEN 1
        ELSE 0
    END,
    Score;


-- ============================================================
-- 17. CREATE A NEW TABLE FROM AN EXISTING TABLE
-- ============================================================

-- SELECT INTO creates a new table and copies the data.

SELECT *
INTO san_2
FROM sales.Customers;

USE SalesDB;

SELECT *
FROM san_2;


-- Create NULL score examples in the new table.
UPDATE san_2
SET Score = NULL
WHERE CustomerID = 4;

UPDATE san_2
SET Score = NULL
WHERE CustomerID = 1;

SELECT *
FROM san_2;


-- Sort the new table with NULL values last.
SELECT *
FROM san_2
ORDER BY
    CASE
        WHEN Score IS NULL THEN 1
        ELSE 0
    END,
    Score;


-- Find customers whose score is NULL.
SELECT *
FROM sales.Customers
WHERE Score IS NULL;


-- Sort customer scores from lowest to highest
-- and place NULL values last.
SELECT *
FROM sales.Customers
ORDER BY
    CASE
        WHEN Score IS NULL THEN 1
        ELSE 0
    END,
    Score;


-- ============================================================
-- 18. CUSTOMERS WITHOUT ORDERS
-- ============================================================

-- Find customers who have not placed any orders.
-- LEFT JOIN keeps all customers, and the WHERE condition
-- identifies customers with no matching order.

SELECT
    C.*,
    O.OrderID
FROM sales.Customers C
LEFT JOIN sales.Orders O
    ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL;


-- ============================================================
-- 19. DATA CLEANING WITH NULLIF(), COALESCE() AND TRIM()
-- ============================================================

-- Create sample data containing:
-- NULL, empty string, and spaces.

WITH CTE AS
(
    SELECT 1 AS ID, 'Name' AS Category
    UNION
    SELECT 2, NULL
    UNION
    SELECT 3, ''
    UNION
    SELECT 4, ' '
)

SELECT
    *,
    TRIM(Category) AS Policy_1,
    DATALENGTH(Category) AS Policy_2,
    NULLIF(Category, '') AS Policy_3,
    COALESCE(Category, 'Unknown') AS Policy_4,
    COALESCE(NULLIF(Category, ''), 'Unknown') AS Policy_5
FROM CTE;


/*
Data Policy:
A data policy is a set of rules that defines
how data should be handled or transformed.
*/


-- ============================================================
-- 20. CASE STATEMENT
-- ============================================================

-- Categorize orders based on sales amount:
-- Greater than 50  -> High
-- 21 to 50         -> Medium
-- 20 or below      -> Low

SELECT
    Sales_Category,
    SUM(Sales) AS Total_Sales
FROM
(
    SELECT
        *,
        CASE
            WHEN Sales > 50 THEN 'High'
            WHEN Sales BETWEEN 21 AND 50 THEN 'Medium'
            ELSE 'Low'
        END AS Sales_Category
    FROM sales.Orders
) T
GROUP BY Sales_Category
ORDER BY Total_Sales DESC;


-- ============================================================
-- 21. EMPLOYEE MAPPING / SELF JOIN
-- ============================================================

-- Join the Employees table with itself to compare
-- employees and their managers.

SELECT
    E.FirstName AS Employee_Name,
    E.Salary AS Employee_Salary,
    M.FirstName AS Manager_Name,
    M.Salary AS Manager_Salary
FROM sales.Employees E
INNER JOIN sales.Employees M
    ON E.EmployeeID = M.ManagerID
WHERE E.Salary > M.Salary;


-- ============================================================
-- 22. CASE - GENDER MAPPING
-- ============================================================

-- Convert gender codes into readable descriptions.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Gender,
    CASE
        WHEN Gender = 'M' THEN 'Male'
        WHEN Gender = 'F' THEN 'Female'
        ELSE 'Not Available'
    END AS Gender_Expansion
FROM sales.Employees;


-- ============================================================
-- 23. CASE - COUNTRY CODE MAPPING
-- ============================================================

-- Map country names to country abbreviations.

SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE
        WHEN Country = 'Germany' THEN 'GE'
        WHEN Country = 'USA' THEN 'US'
        ELSE 'Not Available'
    END AS Country_Abbreviation
FROM sales.Customers;


-- ============================================================
-- 24. CUSTOMER SCORE CLEANING AND AVERAGE
-- ============================================================

-- Replace NULL scores with 0 for calculation purposes.
-- Compare the result with AVG(Score), which ignores NULL values.

SELECT
    CustomerID,
    LastName,
    Score,

    CASE
        WHEN Score IS NULL THEN 0
        ELSE Score
    END AS Score_Clean,

    AVG(
        CASE
            WHEN Score IS NULL THEN 0
            ELSE Score
        END
    ) OVER () AS Average_User,

    AVG(Score) OVER () AS Average_Score

FROM sales.Customers;


-- ============================================================
-- 25. COUNT ORDERS BASED ON SALES CONDITION
-- ============================================================

-- Count how many orders each customer has placed
-- where Sales is greater than 30.

SELECT
    CustomerID,
    SUM(
        CASE
            WHEN Sales > 30 THEN 1
            ELSE 0
        END
    ) AS Total_Orders
FROM sales.Orders
GROUP BY CustomerID;


-- ============================================================
-- END OF SQL FUNCTIONS PRACTICE
-- ============================================================







	




























