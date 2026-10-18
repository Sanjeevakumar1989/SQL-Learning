select * from sys.databases

use MyDatabase

select T.Name as Table_Name,S.Name as Schemas_Name from sys.tables T inner join 
sys.schemas S ON T.schema_id = s.schema_id;

select * from orders

--find the total  sales and number of orders and Avearge sales,Min,Max salaes
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

select 
country,
Sum(score) as Total_score,
count(*) as Total_customers,
AVG(score) as Average_Sore,
Max(Score)as Highest_score,
Min(score) as Lowest_score
from customers
group by country

use SalesDB
select * from sales.orders

--find the total sales and provide each productid  and its unable to provide orderid and orderdate details so going to windows function
select
OrderID,
orderDate,
ProductID,
Sum(sales) as Total_sales
from sales.orders
Group by 
ProductID

--find the total sales and provide each productid and orderdate,orderid details
select 
OrderID,
orderDate,
ProductID,
sales,
sum(sales) over() as Total_sales,
Sum(sales) over(partition by ProductID) as Totalsalespereachproduct
from sales.orders


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

--Winow function work only on Select and order by
--it will not support where clase
--if you want to add aggrication function need to use simple aggregate function using group by  and order by like
select customerID,
sum(sales)as total_sales,
rank() over(order by sum(sales) DESC) as Rank_wise --rank() over(order by customerID DESC) as Rank_wise 
from sales.Orders
group by customerID

