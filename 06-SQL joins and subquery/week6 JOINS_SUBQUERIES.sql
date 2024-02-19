------------------week 6---------------------
-----------------SQL JOINS and SUBQUERIES -------------------------

--1

SELECT p.ProductID, p.Name, p.ProductNumber, c.Name
FROM SalesLT.Product p 
INNER JOIN SalesLT.ProductCategory c
ON p.ProductCategoryID=c.ProductCategoryID

--2
SELECT p.ProductID,p.Name,p.SellStartDate,p.SellEndDate,p.DiscontinuedDate,
		pc.Name as [PC_Name],pc.ModifiedDate
FROM SalesLT.Product p
INNER JOIN SalesLT.ProductCategory pc
ON pc.ProductCategoryID=p.ProductCategoryID

--3.
SELECT p.ProductID, p.Name, p.SellStartDate, p.SellEndDate, p.DiscontinuedDate
,c.ModifiedDate, c.Name
FROM SalesLT.Product p INNER JOIN SalesLT.ProductCategory c
ON p.ProductCategoryID=c.ProductCategoryID
WHERE c.Name='Road Bikes'

--4.

SELECT p.ProductID, p.Name, p.SellStartDate, p.SellEndDate, p.DiscontinuedDate
,c.ModifiedDate, c.Name
FROM SalesLT.Product p INNER JOIN SalesLT.ProductCategory c
ON p.ProductCategoryID=c.ProductCategoryID
WHERE c.Name='Road Bikes' and c.Name='Mountain Bikes' or c.Name = 'Touring Bikes'

--5.
SELECT SalesOrderID, OrderDate, ShipDate, Status, SubTotal, TaxAmt,Freight, TotalDue
FROM SalesLT.SalesOrderHeader;

--6.
SELECT soh.SalesOrderID,soh.OrderDate,soh.ShipDate,soh.Status,soh.SubTotal,soh.TaxAmt,soh.Freight,soh.DueDate,
	c.FirstName + ' '+ c.LastName as FullName, c.EmailAddress	 
from SalesLT.SalesOrderHeader soh
INNER JOIN SalesLT.Customer c
on soh.CustomerID = c.CustomerID


--8.
SELECT ISNULL(c.FirstName,' ')+' _'+ISNULL(c.MiddleName,'')+' '+ISNULL(c.LastName,'') AS FulName,
	c.CompanyName,c.EmailAddress,o.SalesOrderID, o.OrderDate, o.TotalDue
FROM SalesLT.Customer c 
INNER JOIN SalesLT.SalesOrderHeader o
ON c.CustomerID=o.CustomerID
WHERE o.OrderDate >= '01-01-2004'
ORDER BY o.TotalDue DESC

select *
from SalesLT.Customer

select * 
from SalesLT.SalesOrderHeader

--7

SELECT c.*,o.*
FROM SalesLT.Customer c 
LEFT OUTER JOIN SalesLT.SalesOrderHeader o
ON c.CustomerID=o.CustomerID WHERE o.CustomerID IS NULL;

--9.
SELECT DISTINCT p.ProductNumber
FROM SalesLT.SalesOrderHeader o 
INNER JOIN SalesLT.SalesOrderDetail d
ON o.SalesOrderID=d.SalesOrderID
INNER JOIN SalesLT.Product p
ON d.ProductID=p.ProductID

--10

SELECT ISNULL(c.FirstName,'')+'_'+ISNULL(c.MiddleName,'')
	+' '+ISNULL(c.LastName,'') AS FullName, 
	c.CompanyName,c.EmailAddress, a.CountryRegion
FROM SalesLT.Customer c 
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID=ca.CustomerID 
INNER JOIN SalesLT.Address a
ON ca.AddressID=a.AddressID
WHERE a.CountryRegion='United Kingdom';


--11.
select *
from SalesLT.Customer 

--Part 2. SQL Subquery

--12.
SELECT MAX(OrderDate) FROM SalesLT.SalesOrderHeader

--13.
SELECT SalesOrderID,OrderDate,ShipDate,Status,SubTotal,TaxAmt,Freight,TotalDue 
FROM SalesLT.SalesOrderHeader
WHERE OrderDate =(SELECT MAX(OrderDate) FROM SalesLT.SalesOrderHeader);

--14.
SELECT SalesOrderID,OrderDate,ShipDate,Status,SubTotal,TaxAmt,Freight,TotalDue 
FROM SalesLT.SalesOrderHeader
WHERE OrderDate =(SELECT MIN(OrderDate) FROM SalesLT.SalesOrderHeader);

--15.
SELECT ProductID,[Name],ProductNumber
FROM SalesLT.Product
WHERE ProductID IN (SELECT DISTINCT ProductID
FROM SalesLT.SalesOrderDetail WHERE OrderQty >10)

SELECT DISTINCT ProductID
FROM SalesLT.SalesOrderDetail 
WHERE OrderQty >10

SELECT *
from SalesLT.Product

select *
From SalesLT.SalesOrderDetail




--16.
SELECT ProductID,Name,ProductNumber
FROM SalesLT.Product
WHERE ProductID IN (
SELECT DISTINCT ProductID
FROM SalesLT.SalesOrderDetail WHERE UnitPrice >1000)


SELECT *
from SalesLT.Product





--17.
select FirstName + ' ' + isnull (middlename,'') +' '+ lastname as FULLNAME,companyname,EmailAddress
from SalesLT.Customer
where customerID not in (select distinct CustomerID from SalesLT.SalesOrderHeader)
--inquery 32

select * 
from SalesLT.Customer

--18.

select FirstName + ' ' + isnull (middlename,'') +' '+ lastname as FullName,
	companyname,EmailAddress
from SalesLT.Customer c
where not exists (select 1 from SalesLT.SalesOrderHeader o
where c.CustomerID=o.CustomerID)

select 1 
from SalesLT.SalesOrderHeader

--19.

select c.FirstName + ' ' + isnull (c.middlename,'') +' '+ c.lastname as [Full Name],
	c.companyname,c.EmailAddress,
	a.AddressLine1 +''+a.City +''+a.PostalCode [FULLAddress]
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca
on c.CustomerID=ca.CustomerID
inner join SalesLT.Address a
on ca.AddressID =a.AddressID
where c.CustomerID in (select o.CustomerID
from SalesLT.SalesOrderHeader o 
inner join SalesLT.SalesOrderDetail d
on o.SalesOrderID=d.SalesOrderID
where o.OrderDate>='2004-01-01'
and d.UnitPrice >1000)



select c.FirstName + ' ' + isnull (c.middlename,'') +' '+ c.lastname as [Full Name],
	c.companyname,c.EmailAddress,
	a.AddressLine1 +''+a.City +''+a.PostalCode [FULLAddress]
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca
on c.CustomerID=ca.CustomerID
inner join SalesLT.Address a
on ca.AddressID =a.AddressID
where exists (select o.CustomerID
from SalesLT.SalesOrderHeader o 
inner join SalesLT.SalesOrderDetail d
on o.SalesOrderID=d.SalesOrderID
where o.OrderDate>='2004-01-01'
and d.UnitPrice >1000)

--part 3. Some other advanced SQL statements

--20. 
select SUM(OrderQty) as TotalQty ,ProductID
from SalesLT.SalesOrderDetail
group by ProductID
order by TotalQty

SELECT SUM(OrderQty) AS TotalOrdered, ProductID
FROM SalesLT.SalesOrderDetail
GROUP BY ProductID
ORDER BY TotalOrdered

select *
from SalesLT.SalesOrderDetail

--21.
SELECT COUNT(*) AS CountOfOrders, SalesOrderID
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY CountOfOrders

select count(*) as countOfOrders ,SalesOrderID
from SalesLT.SalesOrderDetail
group by SalesOrderID
order by countOfOrders

select *
from SalesLT.SalesOrderDetail

--To see the DataBase Diagram
use [AdventureWorksLT2019] exec sp_changedbowner 'sa';

--22.
SELECT CustomerID, COUNT(*) AS CountOfSales, 
	YEAR(OrderDate) AS OrderYear
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID, YEAR(OrderDate);


--23.
SELECT COUNT(*) AS CountOfDetailLines, SalesOrderID
FROM SalesLT.SalesOrderDetail
GROUP BY SalesOrderID
HAVING Count(*) > 3;


SELECT *
from SalesLT.SalesOrderDetail

--24.
select sum(LineTotal) as TotalLine,LineTotal
from SalesLT.SalesOrderDetail
group by SalesOrderID,LineTotal
HAVING LineTotal > 1000

--25.
SELECT ProductModelID, COUNT(*) AS CountOfProducts
FROM SalesLT.Product
GROUP BY ProductModelID HAVING COUNT(*) = 1
ORDER BY ProductModelID DESC

--26.
SELECT ProductModelID, COUNT(*) AS CountOfProducts, Color
FROM SalesLT.Product
WHERE Color IN ('Blue','Red')
GROUP BY ProductModelID, Color
HAVING COUNT(*) = 1
ORDER BY ProductModelID DESC

--27.
DECLARE @OrderCount INT;

SELECT @OrderCount = COUNT(*) FROM SalesLT.SalesOrderDetail;

IF @OrderCount > 100
BEGIN
PRINT 'Over 100'
END
ELSE 
BEGIN
PRINT '100 or less.'
END;

--28.
IF MONTH(GETDATE()) IN (1,2)
BEGIN
PRINT 'The month is ' + DATENAME(mm,GETDATE());
IF YEAR(GETDATE()) % 2 = 0
BEGIN
PRINT 'The year is even.';
END
ELSE
BEGIN
PRINT 'The year is odd.';
END
END;


--29.
DECLARE @Count INT = 1;
WHILE @Count <= 100
BEGIN
IF @Count % 2 = 0
BEGIN
PRINT CAST(@Count AS VARCHAR)+' '+'Even';
END
ELSE
BEGIN
PRINT CAST(@Count AS VARCHAR)+' '+'Odd';
END
SET @Count += 1;
END;

--30:

SELECT CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader
WHERE CustomerID IN (SELECT CustomerID FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID
HAVING SUM(TotalDue) >= 1000);


--CTE common Table Expression

WITH c AS (
SELECT CustomerID
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID
HAVING SUM(TotalDue) >= 1000
)
SELECT c.CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader AS SOH
INNER JOIN SalesLT.Customer c
ON SOH.CustomerID = c.CustomerID;


--Derived Table

SELECT c.CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader AS SOH 
INNER JOIN
(SELECT CustomerID
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID
HAVING SUM(TotalDue) >= 1000
) AS c
ON SOH.CustomerID = c.CustomerID;

















