--Show database name
select name as database_name from sys.databases;
use MyDatabase;

--List of table and schema name
select s.name as Schema_name,
	t.name as Table_Name
	from sys.tables t
	inner join sys.schemas s
	on 
	s.schema_id = t.schema_id
	order by Schema_name,Table_Name;

select * from orders;
select * from customers;
--(Comments) Notes to explain code,ignored during excution
select First_name,country , score from customers;

--Customer Table analysis using(SELECT,DISTINCT,TOP,FROM,JOIN,WHERE,GROUP BY,HAVING,ORDER BY)
--Retrive data from customer only score condition data is >500 
select * from customers where score>500;
select * from customers where score !=0;
select * from customers where country = 'Germany';
select * from customers order by score DESC;
select * from customers order by country ASC,score DESC;
select country, sum(score) as Total_score from customers group by country order by Total_score DESC
select country, sum(score) Total_score from customers where score>300 group by country having sum(score)>800;
select country ,AVG(score) as Average_score from customers where score !=0 group by country having AVG(score) > 430;
select distinct country from customers;
select Top 3 * from customers order by score Desc;
select Top 3 * from customers order by score;

--ORDERS TABLE ANALYSIS
SELECT * FROM ORDERS;
--RETRIVE LATEST 2 ORDERS IN ORDER TABLE
SELECT TOP 2 * FROM ORDERS ORDER BY ORDER_DATE DESC;

--Cool SQL Techniques
select 123 as static_number
select 'Welcome' as Static_string;
select id,first_name,'New_customer' as New_customer from customers

--Data Definition Language (Create,ALter,Drop)
CREATE Table Person(id Int Not null,
Name Varchar not null,
birth_date Date,
Phone Int not null,
constraint PK_Person primary key(id)
)
select * from Person
INSERT INTO Person (id,Name,Birth_date,Phone) values(1,'Sanjeev',2026-09-23,8883682);
INSERT INTO Person (id,Name,Birth_date,Phone) values(2,'Muthu','2026-07-20',9999682);
INSERT INTO Person (id,Name,Birth_date,Phone) values(3,'Giri','2026-06-05',767682);
INSERT INTO Person (id,Name,Birth_date,Phone) values(4,'Thanya','2026-03-11',8887682);