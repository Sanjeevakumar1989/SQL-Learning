select * from sys.databases
use SalesDB
select  t.Name as Table_Name,
s.name as Schema_Name
from sys.tables t inner join sys.schemas s ON t.schema_id = s.schema_id;
--Employees,Customers,Orders,Products

---------------
--Set Operators
----------------
--Union
--Union all
--Except(minus)
--Intersect

--First query table handle the quries result column names 
--dont allow duplicates
select Firstname as First_Name,LastName as Last_Name from sales.customers
Union
select FirstName,LastName from sales.Employees

--Union all  Allow duplicats,union all is faster comparing union
select Firstname as First_Name,LastName as Last_Name from sales.customers
Union all
select FirstName,LastName from sales.Employees

select * from sales.Employees;
select * from sales.Customers;

--Except
--First Query distinct values only will get result so Query order table is important
select 
FirstName,
LastName
from sales.Employees
except
select 
FirstName,
LastName
from sales.Customers

--Intersect
--it is working like Inner join  we will get both table common values only
select 
FirstName,
LastName
from sales.Employees
Intersect
select 
FirstName,
LastName
from sales.Customers


--orders data stored in separate tables (orders and ordersarchive)
--combine all orders data into one report  without duplicates

select * from sales.Orders;
select * from sales.OrdersArchive;

select * from sales.Orders
union
select * from sales.OrdersArchive

select 
        'orders'  as Sours_Table
       ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from sales.Orders
union
select 
        'Orersarchive' as SourceTable
      , [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from sales.OrdersArchive
order by OrderID

--Set operators use cases
--combine the results of  multible quries into single  result set
--combine information (union+Union all)
--Delta detection (except)
--Data completeness check(except)
--example daywise if we need to add data to database , no need to add previous day data again that time we can use except method


