------------------week ---------------------
-----------------SQL Functions -------------------------
--built in function -T-SQL
--create  and call USER DEFINED FUNCTION
--create and call STORED PROCEDURE

-- 1.USE DB AdventureWorksLT2019
USE AdventureWorksLT2019
-- 2.Click the New Query button from the top menu.
--A new query window opens in which you can write queries to create objects and query database objects. 
-- Write a SELECT statement to return columns that contain:
--a.Current date and time. Use the column alias as CurrentDateTime.
    SELECT GETDATE() AS CurrentDateTime
--b.Current date. Use the column alias as CurrentDate
SELECT SellStartDate,
DATEPART(year,SellStartDate),
DATEPART(month,SellStartDate),
DATEPART(day,SellStartDate),
DATEPART(dayofyear,SellStartDate),
DATEPART(week,SellStartDate)FROM SalesLT.Product;

--OPTION1
SELECT GETDATE() AS CurrentDateTime,
CONVERT (DATE,GETDATE()) AS CurrentDate,
CONVERT (TIME,GETDATE()) AS CurrentTime,
DATEPART (YEAR,GETDATE()) AS CurrentYear,
DATEPART (MONTH,GETDATE()) AS CurrentMonth, 
DATEPART (DAY,GETDATE()) AS CurrentDay; 

--OPTION2
SELECT GETDATE() AS CurrentDateTime,
CAST(GETDATE() as DATE) as CurrentDate,
CAST(GETDATE() as TIME) as CurrentTime,
YEAR(GETDATE()) as CurrentYear,
MONTH(GETDATE()) AS CurrentMonth,
DAY(GETDATE()) as CurrentDay

--Functions for working with date and time:

SELECT SellStartDate,
DATEDIFF(day,SellStartDate,GETDATE())
FROM SalesLT.Product;

--3) Return the difference between today and first of January 2024 in terms of year, month, day. 

select DATEDIFF(yy,'2024-1-1',GETDATE()) as ElapsedYear,
DATEDIFF(mm,'2024-1-1',GETDATE()) as ElaspsedMonths,
DATEDIFF(dd,'2024-1-1',GETDATE()) as ElapsedYear

-- 4) Below query returns the CustomerID, the current date, the product's OrderDate, and the number of months between the OrderDate and today's date.

select CustomerID,OrderDate,GETDATE() as Today,
DATEDIFF(MONTH,OrderDate,GETDATE()) as ElapsedMonths
from SalesLT.SalesOrderHeader

--5. Write a SELECT statement against the SalesLT.SalesOrderHeader table and retrieve the SalesOrderID, OrderDate and TotalDue columns. Filter the results to include only orders placed in the last seven days.

select SalesOrderID,OrderDate,DueDate
from SalesLT.SalesOrderHeader
where DATEDIFF(d,OrderDate,GETDATE()) <=7;

SELECT SalesOrderID,OrderDate,TotalDue
FROM SalesLT.SalesOrderHeader
WHERE DATEDIFF(d,OrderDate,GETDATE())<=7;

--6. 
select SalesOrderID,OrderDate,ShipDate,
DATEDIFF(d,OrderDate,ShipDate) as NumberOfDays
from SalesLT.SalesOrderHeader

--7.
select CustomerID,OrderDate,
DATEPART(year,Orderdate) as [year],
DATEPART(day,Orderdate) as[day]
from SalesLT.SalesOrderHeader

--8.
select SalesOrderID,OrderDate,
DATEPART(YYYY,OrderDate) as OrderDate,
DATEPART(MM,OrderDate) as OrderMonth
from SalesLT.SalesOrderHeader

select SalesOrderID,OrderDate,
year(OrderDate) as OrderYear,
MONTH(orderDate) as OrderMonth
from SalesLT.SalesOrderHeader

--9.
select SalesOrderID,OrderDate
from SalesLT.SalesOrderHeader 
WHERE YEAR(OrderDate) =2008


--10.
select CustomerID,FirstName,LastName,ModifiedDate
from SalesLT.Customer
Order By YEAR(ModifiedDate),MONTH(ModifiedDate)

--11.

select DATENAME(weekday,'2024-03-31') as 'Day',
DATEPART(dy,'2024-03-31')as 'NoOfDays'

--12.
select DATENAME(weekday,'2024-03-31') as 'Day',
DATEPART(d,'2024-03-31')as 'NoOfDays'
--13.

select SalesOrderID,OrderDate,
year(OrderDate) as OrderYear,
DATENAME(Month,OrderDate) as MonthName
from SalesLT.SalesOrderHeader

--14. 
SELECT CustomerID,OrderDate,
DATENAME(Month,OrderDate) as MonthName,
DATENAME(WEEKDAY,OrderDate) as WeekDayName
FROM SalesLT.SalesOrderHeader

--15.
SELECT  SalesOrderID,OrderDate,
DATEADD(m,6,OrderDate)Plus6Months
from SalesLT.SalesOrderHeader

--16.
select ROUND(119.635,1) as Roundoff1,
		ROUND(119.653,2) as Roundoff2
--17.
select ROUND(119.653,0),
	ROUND(119.653,-1),
	Round(119.653,-2)
--18.
select SalesOrderID,SubTotal,
		ROUND(SubTotal,0) as SubTotal
from SalesLT.SalesOrderHeader

--19.
select SalesOrderID,SubTotal,
		ROUND(SubTotal,2) as SubTotal
from SalesLT.SalesOrderHeader

--20.
select RAND()*(100-10)+10

--21.
select Floor(Rand()*(100-10)+10)

select cast(Rand()*(100-10)+10 as int)

--22.
select ProductID,Name,Color,ISNULL(Color,'No Color')
from SalesLT.Product

--23.
select ProductID,Color,Name 
from SalesLT.Product

/*select ProductID,Color,Name, ISNULL(':' + Color,") as Description from SalesLT.Product  */

--25. 
SELECT CAST(ProductID AS VARCHAR) concat ': ' + Name AS IDName
FROM SalesLT.Product;

--26.
SELECT LEFT(CompanyName,10) AS [Company Name] 
FROM SalesLT.Customer;

select *
from SalesLT.Customer
--26.
SELECT SUBSTRING(CompanyName,1,10) AS [Company Name] FROM SalesLT.Customer;

--27.

SELECT companyname, SUBSTRING(CompanyName,10,6) AS [Company Name 10-15]
FROM SalesLT.Customer;

--28.
SELECT UPPER(FirstName) AS FirstName, UPPER(LastName) AS LastName
FROM SalesLT.Customer;

--29.
SELECT FirstName, LastName, EmailAddress
FROM SalesLT.Customer
WHERE LEN(FirstName) > 10;

--30.
SELECT FirstName, LastName, EmailAddress
FROM SalesLT.Customer
WHERE EmailAddress LIKE '[a-z,0-9,_,-,.]%@[a-z,0-9,_,-]%.[a-z][a-z]%';

--31.
SELECT FirstName, LastName, EmailAddress FROM SalesLT.Customer
WHERE PATINDEX('%@%',EmailAddress)>2;

--32. AGGREGATE FUNCTION
SELECT COUNT(*) AS TotalProducts FROM SalesLT.Product;

--33. 
SELECT AVG(ListPrice) As AveragePrice FROM SalesLT.Product;
--34.
SELECT Color, COUNT(*) AS ProductsInColor 
FROM SalesLT.Product
GROUP BY Color
HAVING COUNT(*) > 10

--37.  USER DEFINED FUNCTIONS

CREATE FUNCTION dbo.addTwoNumbers(@NumberOne INT,@NumberTwo INT)
RETURNS INT
AS BEGIN
RETURN @NumberOne+@NumberTwo 
END
--Exec or select
select dbo.addTwoNumbers(2,3) as Sumvalues

--38. 

CREATE FUNCTION dbo.fnTrim(@Expression VARCHAR(250))
RETURNS VARCHAR(250)
AS BEGIN
RETURN LTRIM(RTRIM(@Expression))
END
--exec
select dbo.fnTrim('   test    ') as FnLTrim

--39. Create stored Procedure

Create Procedure SelectAllCustomers1 @name nvarchar(30)
as 
select * 
from SalesLT.Customer
where FirstName = @name

--exec
exec SelectAllCustomers1 @name='John'





ORDER BY ProductsInColor DESC;

















