/*
===============================================================================
SQL WINDOW FUNCTIONS - PRACTICE NOTES
===============================================================================
Purpose:
    Practice SQL Server aggregate, ranking, distribution, and value window
    functions using the MyDatabase and SalesDB sample databases.

Key concepts:
    1. OVER()                  - calculates across the full result set.
    2. PARTITION BY             - calculates separately for each group.
    3. ORDER BY inside OVER()   - defines the order used by the window function.
    4. ROWS BETWEEN             - defines a specific frame of rows.
    5. Ranking functions        - assign row numbers or ranks.
    6. LAG() / LEAD()           - access a previous or following row.
    7. Window functions retain detail rows; GROUP BY normally combines rows.

Note:
    These are learning examples. Review the comments and run each query against
    the matching sample database. Table and column availability depends on your
    local SQL Server setup.
===============================================================================
*/

-- DATABASE DISCOVERY: List databases available on this SQL Server instance.
select * from sys.databases

-- SWITCH DATABASE: Use MyDatabase for the following practice queries.
use MyDatabase

-- METADATA: List tables together with the schemas that contain them.
select T.Name as Table_Name,S.Name as Schemas_Name from sys.tables T inner join 
sys.schemas S ON T.schema_id = s.schema_id;

select * from orders

--find the total  sales and number of orders and Avearge sales,Min,Max salaes
-- GROUPED AGGREGATION: Summarize order sales per customer. GROUP BY returns one row per customer.
select 
customer_id,
Sum(sales) as Total_sales,
count(*) as Total_Numberof_orders,
AVG(sales) as Avearge_sales,
Max(sales) as Highest_order_sales,
Min(sales) as Lowest_order_sales
from orders
group by customer_id

select * from customers

-- GROUPED AGGREGATION: Compare customer scores by country using SUM, COUNT, AVG, MAX, and MIN.
select 
country,
Sum(score) as Total_score,
count(*) as Total_customers,
AVG(score) as Average_Sore,
Max(Score)as Highest_score,
Min(score) as Lowest_score
from customers
group by country

-- SWITCH DATABASE: Continue the window-function exercises in SalesDB.
use SalesDB
select * from sales.orders

-- GROUP BY LIMITATION: This query is intended to illustrate that selecting order-level columns requires them to be grouped or aggregated. The current GROUP BY ProductID alone will not run as written in SQL Server.
--find the total sales and provide each productid  and its unable to provide orderid and orderdate details so going to windows function
select
OrderID,
orderDate,
ProductID,
Sum(sales) as Total_sales
from sales.orders
Group by 
ProductID

-- AGGREGATE WINDOW FUNCTIONS: Show every order while also displaying total sales overall and total sales per product.
--find the total sales and provide each productid and orderdate,orderid details
select 
OrderID,
orderDate,
ProductID,
sales,
sum(sales) over() as Total_sales, -- Overall total repeated on each order row.
Sum(sales) over(partition by ProductID) as Totalsalespereachproduct -- Product-level total repeated on that product's rows.
from sales.orders


-- MULTIPLE PARTITIONS: Compare totals for all orders, each product, and each product/status combination.
select
OrderID,
ProductID,
OrderDate,
Orderstatus,
sales,
Sum(sales) over() as total_sales_per_product,
Sum(sales) over(partition by ProductID) as total_sales_per_product,
Sum(sales) over(partition by ProductID,OrderStatus) as total_sales_orderssatus
from sales.orders

-- RANKING: RANK assigns the same rank to tied sales values and leaves gaps after ties.
--Rank each order based on their sales from highest to lowest
--additionally provide details orderid,orderdate

select 
OrderID,
Orderdate,
sales,
rank() over(order by sales DESC) as Rank_Number
from sales.orders

select 
orderID,
orderdate,
orderstatus,
sales,
sum(sales) over(partition by orderstatus order by orderstatus) as total
from sales.orders

select 
orderID,
orderdate,
orderstatus,
sales,
sum(sales) over(partition by orderstatus order by orderstatus) as total
from sales.orders

-- WINDOW-FUNCTION NOTES: Window functions are evaluated in the SELECT/ORDER BY processing context; filter on a window result by using a CTE or derived table. They cannot be nested directly inside another window function.
--Winow function work only on Select and order by
--window functin will not support another window function inside window function like nest window function
--it will not support where clase and some time will use for particular customers 
select 
ProductID,
sales,
sum(sales) over(partition by productid) as total_sales
from sales.orders
where ProductID in(101,102)
select * from sales.orders

-- AGGREGATION + RANKING: Aggregate sales per customer, then rank customers by their aggregated sales.
--if you want to add aggrication function need to use simple aggregate function using group by  and window function will work only part of group by
select customerID,
sum(sales)as total_sales,
rank() over(order by sum(sales) DESC) as Rank_wise --rank() over(order by customerID DESC) as Rank_wise 
from sales.Orders
group by customerID


-- COUNT OVER: Count orders per customer while retaining each order's details.
--Find the total number of orders
--Find the total number of orders for each customers
--additionally provide details such orderid,orderadte


select
CustomerID,
OrderID,
OrderDate,
count(*) over(partition by customerid) as total_numberofordersbycustomer
from sales.orders

-- COUNT OVER: Add the total customer-row count to every customer row.
--find the total number of customer additionally provide all customer details
select *,
count(*) over() as totalcustomer
from sales.customers

--find the total number of customer additionally provide all customer details
--find the total number of scores for the customers

select *,
count(score) over() as totalscorecustomer
from sales.customers

-- DUPLICATE CHECK: COUNT(*) OVER(PARTITION BY OrderID) shows how many rows share each OrderID.
--check whether primary key contain any duplicates
select OrderID,
count(*) over(partition by orderid) as checkpk
from sales.orders

select * from sales.OrdersArchive

-- DUPLICATE DETECTION: Return archived orders whose OrderID occurs more than once.
--Finding the duplicates in window function
select * from (
select OrderID,
count(*) over(partition by orderid) as checkpk
from sales.OrdersArchive)t where checkpk>1;

--find the total sales and each product sales
--additionally provide orderid,orderdate

select orderid,
orderdate,
ProductID,
sales,
sum(sales) over() as total_sales,
sum(sales) over(partition by ProductID) as totalsalesbyeachproduct
from sales.orders

-- PERCENTAGE CONTRIBUTION: Compare each order's sales with total sales. CAST to FLOAT enables decimal division.
--find the persentage contribution of each products sales to the total sales (sales/total sales)

select 
OrderID,OrderDate,
sales,
sum(sales)over() as totalsales,
Round(cast(sales as float)/sum(sales) over() * 100,2) as Percetagesales
from sales.orders

--find the average sales accoress all orders
--find the average sales of each product
--additionally provide orderid,orderdate

select 
Orderid,
orderdate,
ProductID,
sales,
AVG(sales) over() as averagesales,
AVG(sales) over(partition by Productid) as aveargesalesbyproduct
from sales.Orders

-- NULL HANDLING: AVG(score) ignores NULL values; AVG(COALESCE(score, 0)) treats missing scores as zero.
--Find the average score of customers
--additionally provide details such customerid and lastname

select 
CustomerID,
LastName,
Score,
COALESCE(score,0) as Nullreplacetzero,
AVG(score) over() as averagescore,
Avg(coalesce(score,0)) over() as Averagescorewithcustomer
from sales.customers

-- FILTER ON WINDOW RESULT: Calculate the overall average in a derived table, then filter rows above that average in the outer query.
--find all orders where sales are higher than the average sales across all orders 
--we cannot use where clause in window function
select * from(
select 
orderid,
sales,
AVG(sales) over() as averagesales
from sales.orders)t
where sales>averagesales

-- MIN/MAX OVER: Show overall and per-product sales extremes alongside each order.
--Find the Highest and Lowest sales of all orders
--Find the Highest and Lowest sales of each product
--additionally provide details such order id,orderdate

select 
OrderID,
orderdate,
ProductID,
sales,
Max(sales) over() as Maxsales,
Min(sales) over() as Minsales,
Max(sales) over(partition by ProductID) as Highestsalesbyproduct,
Min(sales) over(partition by ProductID)  as Lowestsalesbyproduct
from sales.orders

-- MAX OVER: Find employees whose salary equals the maximum salary in the employee table.
--Find the employees who have highest salary

select * from (select *,
Max(salary) over() as maximumsalary
from sales.Employees)t
where salary = maximumsalary

-- DEVIATION FROM EXTREMES: Calculate how far each order's sales are above the overall minimum and below the overall maximum.
--Find the sales devationmin and max

select 
OrderID,
orderdate,
ProductID,
sales,
Max(sales) over() as Maxsales,
Min(sales) over() as Minsales,
Max(sales) over(partition by ProductID) as Highestsalesbyproduct,
Min(sales) over(partition by ProductID)  as Lowestsalesbyproduct,
sales - Min(sales) over() as salesdeviationmin,
Max(sales) over() - sales as salesdeviationmax
from sales.orders


-- WINDOW FRAMES: Compare a product's running average over time with a frame containing the current order and the next order.
--Calculate  Moving average of sales for each product over time
--Calculate moving average of sales for each product over time,including only the next order

select 
orderid,
OrderDate,
sales,
productid,
Avg(sales) over() as averagesales,
AVG(sales) over(partition by productid order by orderdate) as MovingAvg,
AVG(sales) over(partition by productid order by orderdate Rows between current row and 1 following) Rollingaverage
from sales.orders

-- ROW_NUMBER: Assigns a unique sequential number to each row in the specified ordering. Add a tie-breaker column for deterministic results.
--Row_number() if dies means it will not skip row number is a unique
--rank the orders based on their sales from highest to lowest
select orderid,
productid,
sales,
row_number() over(order by sales desc) as rn
from sales.Orders

-- RANK: Tied rows receive the same rank; the next rank value skips numbers.
--Rank() if rank value die means it will skip rank
--we will get gaps due to shared rank
select orderid,
productid,
sales,
Rank() over(order by sales desc) as RNK
from sales.orders

-- DENSE_RANK: Tied rows receive the same rank, but the next rank does not skip a number.
--Dense_Rank() will not skip number ,it also handle dies,shared ranking(no skipping rank)
select orderid,
productid,
sales,
Dense_rank() over(order by sales desc) as RNK
from sales.orders

-- TOP-N PER GROUP: ROW_NUMBER ranks orders within each product; filtering rank = 1 returns one highest-sales order per product.
--Use case Top N analysis
--find the top highest sales in each product

select * from
(select
orderid,
orderdate,
productid,
sales,
Row_number() over(partition by productid order by sales desc) as highest_rank
from sales.orders)e
where highest_rank = 1;

-- BOTTOM-N PER GROUP: Rank orders from lowest to highest sales within each product.
--Use case Bottom N analysis
--find the top lowest sales in each product

select * from
(select
orderid,
orderdate,
productid,
sales,
Row_number() over(partition by productid order by sales asc) as highest_rank
from sales.orders)e
where highest_rank = 1;

-- LOWEST TWO ORDERS PER PRODUCT: This query ranks individual orders by product, not customers by total sales.
--find the lowest 2 customers ranks based on their sales

select * from (
select orderid,customerid,productid,sales,
Row_number() over(partition by productid order by sales asc) as lowest_customer_sales
from sales.orders)t
where lowest_customer_sales <=2

-- LOWEST TWO CUSTOMERS BY TOTAL SALES: GROUP BY calculates each customer's total, and TOP 2 returns the smallest totals.
--find the lowest 2 customers based on their total sales


select TOP 2 
customerid,
SUM(sales) as total_sales 
from sales.Orders
group by customerid
order by total_sales 

--using by window function

select * from 
(select 
customerid,
sum(sales) as total_sales,
Row_number() over(order by sum(sales)) as rank_customer
from sales.orders
group by customerid)t
where rank_customer <=2;


-- PAGINATION / ROW IDENTIFIERS: ROW_NUMBER creates a sequence based on OrderID; it does not create a permanent table key by itself.
--Use case assign unique IDs help to assign unique identifier  for each row to help paginating
--Paginating means the process of breaking down large datas into smaller,more manageble chunks
select Row_Number() over(order by orderid)as unique_id,* from sales.OrdersArchive;

-- DATA QUALITY: Identify duplicate OrderID values in the archive and demonstrate how ROW_NUMBER can select one row per OrderID.
--Use case Identify duplicates 
--identify and remove duplicates row to improve data quality
--identify and remove duplicates rows in orders archive table and return a clean result without duplicates

--only find the duplicates
select orderid,
count(*) as total_rows from sales.OrdersArchive
group by orderid
having count(*)>1;

--clean and return values without duplicates
select * from (
select *,
Row_Number() over(partition by orderid order by CreationTime) as RN
from sales.OrdersArchive)r
where RN =1


-- NTILE: Divide ordered rows into a requested number of buckets. Buckets are as evenly sized as possible; ties may be split across buckets.
--Ntile is spliting equal size of  rows in table example 10 rows available NTILE(2)
--bucket_size = Number_of_rows/Number_of_size =10/2=5,10/3=1,1,1,1,2,2,2,3,3,3 

select *,
NTILE(3) over(order by sales desc) as Ntile_3,
NTILE(2) over(order by sales desc) as Ntile_2,
NTILE(4) over(order by sales desc) as Ntile_4,
NTILE(5) over(order by sales desc) as Ntile_5
from sales.orders

-- BUCKET LABELS: Map the three NTILE buckets to High, Medium, and Low sales groups.
--segment all orders in 3 categories like,High,Medium,Low
select *,
case when buckets =1 Then 'High'
	when buckets = 2 Then 'Medium'
	when buckets = 3 then 'Low'
End as Bucket_category
from
(select orderid,sales,
NTILE(3) over(order by sales desc) as buckets
from sales.orders)r

-- DISTRIBUTION FUNCTIONS: CUME_DIST reports cumulative distribution; PERCENT_RANK reports relative rank. Their meanings differ, so compare them separately.
--find the products that fall within highest 40% of prices
--cume_dist()
select *,
concat(Cume_rank * 100,'%') as cumulative_persentage
from( select Productid,product,price,
cume_dist() over(order by Price desc) as Cume_rank
from sales.Products)t
where Cume_rank <=0.4;
--Percent_Rank()
select *,
concat(Cume_rank * 100,'%') as cumulative_persentage
from( select Productid,product,price,
Percent_Rank() over(order by Price desc) as Cume_rank
from sales.Products)t
where Cume_rank <=0.4;


-- VALUE FUNCTIONS: LAG accesses a preceding row; LEAD accesses a following row; FIRST_VALUE returns the first value in the window frame.
--Window value functions
--LAG(),LEAD(),First_value(),Last_Value()
--Analyze the Month_over_Month (MOM) performance by finding the percentage changes sales between previous and current month

select *,
current_month_sales - previous_month_sales as MOM_sales_change,
ROUND(CAST((current_month_sales - previous_month_sales)as FLOAT)/previous_month_sales * 100,1) as MOM_Percentage
from
(select 
	Month(orderdate) as Order_Month,
	Sum(sales) as current_month_sales,
	LAG(sum(sales)) over(order by Month(orderdate)) as previous_month_sales
	from sales.orders
	group by Month(orderdate)

)w

-- CUSTOMER LOYALTY: LEAD finds the next order date per customer; DATEDIFF calculates days between consecutive orders, then customers are ranked by average gap.
--in order to analyze customer Loyality
--rank customers based on the average days between their orders

select customerid,
AVG(orderuntilnextorder) as Average_day_orders,
RANK() over(order by COALESCE(AVG(orderuntilnextorder),9999)) as RNK_Average
from (
select 
orderid,
customerid,
orderdate as current_orderdate,
Lead(orderdate) over(partition by customerid order by orderdate) as Nxt_order,
DATEDIFF(DAY,orderdate,Lead(orderdate) over(partition by customerid order by orderdate)) as orderuntilnextorder
from sales.orders)t
group by CustomerID


-- FIRST_VALUE: With ascending order it returns the lowest sales value per product; with descending order it returns the highest sales value per product.
--Find the lowest and highest sales in each product


select orderid,
productid,
sales,
min(sales) over(partition by productid) as lowest_sales,
Max(sales) over(partition by productid ) as highest_sales,
first_value(sales) over(partition by productid order by sales ) as lower_value_1,
first_value(sales) over(partition by productid order by sales desc ) as higher_value_1
from sales.orders


























