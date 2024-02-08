--------------Week 3-------------------------
--------------Advance Database -----------------
/*  1. using AdventureWorksLT2019 DB
	2. Select specific columns 
	3. using the where clauses 
		- only one condition (comparison operator <,>,!=..)
		- two conditions (Logical operators-AND ,OR)
		- Data format '2005-07-01'
		- use Keyword between 
		-  filter the pattern using wild card opearators along with LIKE keywords
			a. multiple character(%)
			b.single character(_)

	4. filter range[a-c]
	5. IS NULL ,IS NOT NULL
	6. Order by column names ASC ascending order and descending order DESC
		
		*/

--Writing SQL Statements-----------------------

/* database already there  and im using the same DB that is
	AdventureWorksLT2019 has many tables with schema */

--Use the AdventureWorksLT2019 database

use AdventureWorksLT2019

--Q1. 
select *
from SalesLT.Customer

select CustomerID,FirstName,MiddleName,LastName
from SalesLT.Customer

--Q2
select ProductID,Name,ProductNumber,Color
from SalesLT.Product

--Q3
select SalesOrderID,CustomerID,OrderDate
from SalesLT.SalesOrderHeader

select *
from SalesLT.SalesOrderHeader

---------------------------1. Select Statement ------------------------------------------------------
/* filter the values using where clause statements in 3rd line
		we use operators <, > , =
						 <= ,>= ,!= or <>
						 !<,!>, operands */
---------------------------------------------------------------------------------

--Q4
select CustomerID,FirstName,MiddleName,LastName
from SalesLT.Customer
where LastName ='Johnson'

--Q5
select CustomerID,FirstName,MiddleName,LastName
from SalesLT.Customer
where LastName='Adams'

/* Last Name Adams contains four members */

--Q6
select *
from SalesLT.Customer
where FirstName='Robert' and LastName ='Brown'

/* there 2 customer having both names as same */

--Q7
--now Using comparison operator <,>....in where clause

select *
from SalesLT.Product
where ListPrice >1000
 /* 86 rows has greater than 1000 price */

 --Q8  the sales were removed from July 30th  use the date format method
 select *
 from SalesLT.Product
 where SellEndDate = '2007-06-30'
 /* 69 rows sales ended */

--Q9 
select *
from SalesLT.Customer
where ModifiedDate ='2005-08-01'
 /* 120 customers were modifyied */

 --Q10
 select *
from SalesLT.Customer
where ModifiedDate !='2005-08-01'
 /* 727 customers were modifyied */

-------------------------------------------------------------------------------------------
--Between operators, is a keyword
--use in where line after the cols name
--Eg: where <cols> BETWEEN  <value1>  and <value2>
--so its requieres logical operator AND

--Q11
select *
from SalesLT.Customer
where ModifiedDate Between '2005-07-01' and '2007-07-01'

/* 674 customers */

--Q12
select *
from SalesLT.Customer
where ModifiedDate between '2005-12-31' and '2006-07-01' 

/*error */

--Q13
Select *
from SalesLT.Customer
where ModifiedDate >= '2006-12-31'

/*  in the year 2007 who are all modified -226 customer */
-----------------------------------------------------------------------------------------------
--Pattern matching using wild card 
--to find 1 value within another value
--(%) many character
--(_) single Charater

--Q14. put Like in the 3rd line after where col , start with mountain continue the name
select ProductID,Name
from SalesLT.Product
where Name Like 'Mountain%'
/* whereas 37 rows  */

--Q15

select ProductID,Name
from SalesLT.Product
where name like '%socks%'

/* 4 names in socks starting or ending */

--Q16  the product name without socks
select ProductID,Name
from SalesLT.Product
where name <> 'socks'
/* 295 rows names has not in socks names  */
--option 2
select ProductID,Name
from SalesLT.Product
where name not like '%socks%'
/* 291 rows names has not in socks names  */

-------------------------------------------------------------------------------------------
------Two condition using logical operators (AND ,OR)

--Q17
select ProductID,Name,Color
from SalesLT.Product
where Name like 'touring%' and Name Not like '%wheel'

/* 26 rows */

--Q18
select CustomerID,FirstName,MiddleName,LastName
from SalesLT.Customer
where FirstName like 'k%e' 

/* 6 customer name k--e */
----------------------------------------------------------------------------------
--Range of character using []
--eg:' value[a-c]','value[a,b,c]','value[^d]'

--Q19
select *
from SalesLT.Customer
where FirstName like 'k%[ea]'
 /* starting with k ending with either e or a */

 --Q20

 select ProductID,Name,Color
 from SalesLT.Product
 where name like '%[0-9]'
 /* discuss */

 --Q21
 select ProductID,Name
 from SalesLT.Product
 where name like '[L,M,N]%'

 --Q22
 select *
 from salesLT.Product
 where name not like '%[0-9]'

 --Q23 only for color
 select *
 from salesLT.Product
 where Color like '%'
 --- not for color
  select *
 from salesLT.Product
 where Color IS NULL

 --Q24
 select *
 from SalesLT.Product
 where color != 'blue'

 --Q25
 select *
 from SalesLT.Product
 where Size is not null or Weight is not null or Color is not null 

 --Q26
 select Name,ListPrice,Size,Weight,Color
 from SalesLT.Product
 where size is null and Color is null

 --27
 select CustomerID,FirstName,MiddleName,LastName
 from SalesLT.Customer
 order by LastName,FirstName,MiddleName

 --28 select only one column for ASC and DESC
 select CustomerID,FirstName,MiddleName,LastName
 from SalesLT.Customer
 order by FirstName DESC

 ---------------------------------------------------------------------------------------------
	






















