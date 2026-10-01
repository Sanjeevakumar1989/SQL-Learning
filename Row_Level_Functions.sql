--Show Database name
select Name from sys.databases;
use SalesDB

--Show the Tables and Schemas Name
select T.Name as Table_Name, S.Name as Schema_Name from sys.tables T inner join sys.schemas S ON T.schema_id = S.schema_id

--------------------
--Function
--------------------

--String manipulation 
--concat first name and country convert with firstname with country
select * from sales.Customers
select
concat(FirstName,' ',Country) As Firstname_with_Country
from sales.Customers;

--convert first name to Uppercase
select 
Upper(FirstName) as First_Name
from sales.Customers;

--convert first name to Lower case
select 
Lower(FirstName) as First_Name
from sales.Customers;

--Trim to use for removing leading or Trailing spaces

select 
trim(firstname) as First_Name
from sales.Customers;
--or
select firstName, len(firstname) from sales.Customers;
use MyDatabase
select * from customers

select 
first_name
from customers
where first_name != trim(first_name)

--or
select 
first_name,
len(first_name) as len_first_name,
len(trim(first_name)) as len_trim_first_name,
len(first_name) - len(trim(first_name)) as flag
from customers
where first_name != trim(first_name)

--Replace function
select 
'sanjeev' as name,
replace('sanjeev','e','i')

select '123-4567,980' as phone,
Replace ('123-4567,980','-',',')

select '123-4567,980' as phone,
Replace ('123-4567,980',',','-')

select * from customers;
select First_name,
replace(Country,'UK','INDIA') as country
from customers;
--or
update customers set country = 'UK' where id=3;
select * from customers;

--without using replace and update and where conditions
select 
First_Name,
country,
case 
when score = 0 then 100
else score
end as score
from customers;

--Len  count the number of character

select 
first_name,
len(first_name) as len_first_name
from customers

--Left 
--Extract specific number of character from the start
select
first_name,
left(trim(first_name),2) as First_2_charcter
from customers

--Right 
--Extract specific number of character from the End
select
first_name,
Right(first_name,2) as last_2_charcter
from customers

--Substring
--Retriving first_name from customer after removing first character
select
first_name,
substring(trim(first_name),2,len(first_name)) as sub_name 
from customers

--REPLACE() → replace text inside a string
--CASE → conditionally change a specific value
--UPDATE → permanently change the stored data

-------------------
--Number Function
-------------------

select 3.596 as round_number,
round(3.591,2) as round_2,
round(3.596,1) as round_1,
round(3.596,0) as round_0

--Datetime 
--Datepart are stored in INT only
--DateName are stored in string only
--Datetrunc is reseting values (minutes,hourly,day,Month,Year)

use SalesDB

select * from sales.Orders
select orderID,Orderdate,Shipdate,creationTime,getdate() as Today_date from sales.orders


select 
orderID,
creationTime,
Datetrunc(Hour,CreationTime)as Hour_dt,
Datetrunc(Minute,creationTime)as Minutes_dt,
Datetrunc(day,CreationTime) as Day_dt,
datetrunc(Month,creationtime)as Month_dt,
datepart(day,creationTime) as day_dp,
datepart(month,creationTime) as Month_dp,
datepart(year,creationTime) as Year_dp,
datepart(Hour,creationTime) as Hour_dp,
datepart(week,creationTime) as week_dp,
dateName(Month,creationTime)as Month_dn, 
DateName(weekday,creationTime)as Weekday_dn,
DateName(Year,creationTime)as Year_dn,
datepart(quarter,creationTime) as Quarter_dp,
day(creationTime) as day,
Month(creationTime)as Month,
Year(creationTime) as Year
from sales.Orders

--Use case Datetrunc
--Seconds level order,Monthlevel order,Yearlevel order
select 
creationTime,
count(*) as Total_count
from sales.Orders
group by creationtime

select 
datetrunc(month,creationtime) as Month_order,
count(*) as Total_count
from sales.Orders
group by datetrunc(month,creationtime)

select 
datetrunc(Year,creationtime) as Yearly_order,
count(*) as Total_count
from sales.Orders
group by datetrunc(Year,creationtime)


--EOMonth
select 
creationTime,
EOMONTH(creationTime) as EndofMonth,
CAST(DateTrunc(Month,creationTime)as Date) as StartofMonth
from sales.Orders

--Usecase orders count

select 
--month(orderdate) as Month_order,
Datename(month,orderdate) as Month_Name,
count(*) as Total_order
from sales.orders
Group by Datename(month,orderdate) --Month(orderdate)


--Use case filter order on monthwise and filter we can use INTEGER instead of string because numeric value always give faster result
--filtering february month
select * from sales.Orders where Month(orderdate) = 2
select * from sales.Orders where Month(orderdate) = 1

----------------------------------------
--output datatype
/* Day,Month,Year,Datepart ---> Integer
DateName -----> string
Datetrunc -----> DATETIME 
EOMonth ---->DATE
*/
-----------------------------------------

--Date formating
--date extraction 
select 
creationtime,
format(creationtime,'dd') dd,
format(creationtime,'ddd') ddd,
format(creationtime,'dddd')dddd,
format(creationtime,'MM') MM,
Format(creationtime,'MMM')MMM,
Format(creationtime,'MMMM')MMMM,
Format(creationtime,'MM-dd-yyyy') USA_std,
Format(creationtime,'yyyy-MM-dd') ISO_std,
Format(creationtime,'dd-MM-yyyy') Erope_std
from sales.Orders		

--Use case practice
select 
creationtime,
'Day '+ format(creationtime,'ddd MMM') + ' Q'+datename(quarter,creationtime) + format(creationtime,' yyyy HH:mm:dd tt') as customer_format
from sales.orders

--Convert
select 
creationtime,
convert(DATE,creationtime) as date,
--convert(int,'123') as stringtointeger,
--convert(DATE,'2026-09-09') as stringtodate,	
convert(Varchar,creationtime,32) as [USA:standard.style:32],
convert(Varchar,creationtime,34) as [Erope:standard.style:34]
from sales.Orders


--Casting is used to converting one data type to another datatype

select 
cast('123' as INT) as [ string to integer],
cast('2026-09-05' as Date) as [string to Date],
creationtime,
cast(creationtime as date) as [Datetime to date]
from sales.Orders

--Dateadd(syntax: Dateadd(part,interval,orderdate)
select 
orderdate,
dateadd(year,3,orderdate)  [3 Year late],
dateadd(month,5,orderdate) [5 Month later],
dateadd(day,-5,orderdate) [5 days before]
from sales.orders

--Datediff
--syntax datediff(part,startdate,enddate)
select 
datediff(year,orderdate,shipdate) as diffence_year,
datediff(day,'2026-06-08','2026-10-19')as difference_day,
datediff(month,'2026-06-08','2026-10-19')as difference_Month
from sales.orders

select 
--birthdate,
--datediff(year,BirthDate,GETDATE()) as Age,
datediff(year,'1989-05-30' ,GETDATE()) as Sanjeev_AGE,
datediff(year,'2000-06-10' ,GETDATE()) as Muthu_AGE,
datediff(year,'2019-10-19' ,GETDATE()) as Giri_AGE,
datediff(year,'2022-06-08' ,GETDATE()) as Thanya_AGE
from sales.Employees;

--Find the average shipping in days of each month
select
MONTH(orderdate) as Average_Order_Month,
AVG(datediff(day,orderdate,shipdate)) as daytoship
from sales.orders
group by MONTH(orderdate)

--Time gap analysis
--Find the gap between current orders and previous one

select 
orderid,
orderdate as current_orderdate,
LAG(orderdate) over(order by orderdate) as previous_order_date,
datediff(day,LAG(orderdate) over(order by orderdate),orderdate) NOOFDays
from sales.Orders


--isnull and Coalesce
-- Is null handling fast comapring coalesce is slow
--ISNull gandling two values only but coalese handling multiple
--ISNULL using in SQL server and Coalesce using allserver

select * from sales.Customers
--find the Average score of the customers
--Average means sum of total/number of samples

select
CustomerID,
FirstName,
score,
Coalesce(score,0) Score_replace_0_if_found_nulls,
AVG(score) over() Averagescores
from sales.customers

--Merging fistname and lastname as customer name and add every customer add 10 bonus points
select
FirstName,
LastName,
concat(firstname,' ',lastname) as Customer_name,
score,
Coalesce(score,0) + 10 as Bonus_10points
from sales.Customers

select * from sales.customers
update sales.Customers set score = NULL where CustomerID = 5;

select CustomerID,
score from sales.customers
order by score asc


--Find the  customer score lowest to highest and Null value to put last
--Method_1
select CustomerID,
Score,
Coalesce(score,1111111) 
from sales.customers
order by Coalesce(score,1111111) 

--Method_2
select 
CustomerID,
Score
from sales.Customers
order by case 
	when score is NULL then 1
	else 0
END,score

--create new table from another table
select * into san_2 from sales.customers

use SalesDB;
select * from san_2
update san_2 set score = Null where CustomerID = 4

select * from San_2

update san_2 set score= Null where CustomerID=1


select * from san_2 order by case when score is null  then 1 else 0 end,score 


select * from sales.customers where score is null

--nee to find score asc lowset to highest if null is there then null will come lost
select * from sales.customers order by case when score is null then 1 else 0 end ,score

--List the all customers  who have not placed any order

select c.*,O.OrderID from sales.customers C
left join sales.Orders O 
ON c.CustomerID = O.CustomerID where O.CustomerID is null


WITH CTE AS (
select 1 id,'Name' category union
select 2, Null Union
select 3, '' union
select 4, ' '
)
select *,
Trim(category) policy_1, --removing leading and trail space
Datalength(category) as policy_2,--checking charactes length
Nullif(category,'') as policy_3, --if category column checking empty string/null it will replace NULL
coalesce(category,'unknown') as Policy_4,--if category column NULL means will replace unknown
coalesce(Nullif(category,''),'unknown') as policy_5  -- if we find empty string will replce null and after null going to replace unknown
from CTE;

--datapolicy  is set of rules that defined how do  should handle data


--Case Statement
select Sales_category,
sum(sales) as Total_sales
from(
select *,
case when sales >50 Then 'High' 
	when sales between 21 and  50 then 'Medium'
	else 'Low'
END as Sales_category
from sales.orders
)t
group by Sales_category
order by Total_sales DESC

--Mapping
select * from sales.Employees;

select  E.FirstName as Emmployee_name ,E.Salary as Employee_Salary,M.FirstName as Manager_Name,M.Salary as Manager_salary 
from sales.Employees E inner join sales.Employees M ON E.EmployeeID = M.ManagerID
where E.salary>M.Salary


select 
EmployeeID,
FirstName,
LastName,
gender,
Case  when Gender = 'M' then 'Male'
	when Gender = 'F' then 'Female'
else 'Not Available'
END as Gender_expansion
from sales.Employees


select 
CustomerID,
FirstName,
LastName,
Country,
Case 
	when Country = 'Germany' then 'GE'
	When Country = 'USA' then 'US'
	Else 'Not available'
end country_apperavation
from sales.Customers;

select * from sales.customers
select
CustomerID,
LastName,
score,
case when score is NULL then 0
else score
end scoreclean,
AVG(case when score is NULL then 0 else score End ) over() averageuser,
AVG(score) over() as Average_Score
from sales.customers;

--Count  how many times each  customer  has made an order with sales greater then 30
select CustomerID,
sum(Case 
	when Sales >30 then 1 else 0 
end) as Total_orders
from sales.orders
group by CustomerID







	




























