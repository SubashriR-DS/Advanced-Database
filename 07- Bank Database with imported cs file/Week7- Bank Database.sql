------------------week 7---------------------
-----------------Bank Database Design ER Diagram -------------------------

--CREATE DB for BANK

CREATE DATABASE SalfordBankLtd
USE SalfordBankLtd
GO

--Import the CSV file  

/* change the datatypes for account Number n Branch Code 
Accountbal is money and IR is decimals while flat the file setting
*/

--CREATE Customer Tables For Normalising the Database
---Table 1

CREATE TABLE Customers (
	CustomerID int NOT NULL PRIMARY KEY, 
	CustomerFirstName nvarchar(50) NOT NULL, 
	CustomerLastName nvarchar(50) NOT NULL, 
	CustomerAddressID int NOT NULL,
	CustomerEmail nvarchar(100) UNIQUE NOT NULL CHECK (CustomerEmail LIKE '%_@_%._%'), 
	CustomerTelephone nvarchar(20) NOT NULL, 
	CustomerGender nvarchar(15) NOT NULL,
	CustomerDOB date NOT NULL, 
	CustomerBranchcode nvarchar(6) NOT NULL);

--CREATE ACCOUNT TABLE
---Table 2

CREATE TABLE AccountTypes (
	AccountTypeID int IDENTITY NOT NULL PRIMARY KEY,
	AccountType nvarchar(50) UNIQUE NOT NULL,
	AccountInterestRate decimal(4,2) NOT NULL);

--CREATE ACCOUNT TABLE--this table store the information of the customer's accounts
--Note that we are storing the account number as a character string and not as a numeric value.

---Table 3

CREATE TABLE Accounts (
AccountNumber nvarchar(8) NOT NULL PRIMARY KEY, 
AccountTypeID int NOT NULL FOREIGN KEY (AccountTypeID) REFERENCES AccountTypes (AccountTypeID),
AccountBalance money NOT NULL);

--many-to-many relationship between customers and accounts -Junction Table just connect with pk attributes
--Junction table connect the 2 primary key values

CREATE TABLE CustomerAccounts (
AccountNumber nvarchar(8) NOT NULL FOREIGN KEY (AccountNumber) REFERENCES Accounts (AccountNumber),
CustomerID int NOT NULL FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
PRIMARY KEY (AccountNumber, CustomerID));

---Branch Table

CREATE TABLE Branches (
Branchcode nvarchar(6) NOT NULL PRIMARY KEY,
BranchName nvarchar(50) UNIQUE NOT NULL, 
BranchAddressID int NOT NULL,
BranchTelephone nvarchar(20) NOT NULL);

-- Addresses  Adding the unique constraints in the single code and give contraint Name UC_Address

CREATE TABLE Addresses (
AddressID int IDENTITY NOT NULL PRIMARY KEY,
Address1 nvarchar(50) NOT NULL,
Address2 nvarchar(50) NULL,
City nvarchar(50) NULL,
Postcode nvarchar(10) NOT NULL,
CONSTRAINT UC_Address UNIQUE (Address1, Postcode));

---3 foriegn keys constraints

--1 FORIEGN KEY BranchAddressID

ALTER TABLE Branches
ADD FOREIGN KEY (BranchAddressID) REFERENCES Addresses (AddressID)

--2 FORIEGN KEY CutomerAddressID

ALTER TABLE Customers
ADD FOREIGN KEY (CustomerAddressID) REFERENCES Addresses (AddressID);

--3 FORIEGN KEY CutomerBranchCode

ALTER TABLE Customers
ADD FOREIGN KEY (CustomerBranchCode) REFERENCES Branches (BranchCode);

--Part Three: Using INSERT INTO SELECT statements to populate the tables

--16
INSERT INTO Addresses (Address1, Address2, City, Postcode)
SELECT DISTINCT CustomerAddress1, CustomerAddress2, CustomerCity, CustomerPostcode
FROM dbo.Bank_Data
UNION
SELECT DISTINCT BranchAddress1, BranchAddress2, BranchCity, BranchPostcode
FROM dbo.Bank_Data;


SELECT *
FROM Addresses

--17.

INSERT INTO AccountTypes (AccountType, AccountInterestRate)
SELECT DISTINCT AccountType, AccountInterestRate
FROM dbo.Bank_Data;

SELECT * 
FROM AccountTypes

--18.

INSERT INTO Accounts (AccountNumber, AccountBalance, AccountTypeID)
SELECT DISTINCT b.AccountNumber, b.AccountBalance, t.AccountTypeID
FROM dbo.Bank_Data b 
INNER JOIN AccountTypes t
ON b.AccountType = t.AccountType;

SELECT * 
FROM Accounts

--19.

INSERT INTO Branches (BranchCode,BranchName, BranchTelephone, BranchAddressID)
SELECT DISTINCT b.BranchCode, b.BranchName, b.BranchTelephone, a.AddressID
FROM dbo.Bank_Data b 
INNER JOIN Addresses a
ON (b.BranchAddress1 = a.Address1 AND b.BranchPostcode =a.Postcode);

SELECT *
FROM Branches

--20.

INSERT INTO Customers (CustomerID, CustomerFirstName, CustomerLastName, CustomerEmail, CustomerGender, CustomerDOB, CustomerTelephone, CustomerAddressID, CustomerBranchCode)
SELECT DISTINCT b.CustomerID, b.CustomerFirstName, b.CustomerLastName, b.CustomerEmail, b.CustomerGender, b.CustomerDOB, b.CustomerTelephone, a.AddressID, b.BranchCode
FROM dbo.Bank_Data b 
INNER JOIN Addresses a
ON (b.CustomerAddress1 = a.Address1 AND b.CustomerPostcode = a.Postcode)

SELECT *
FROM Customers

--21.

INSERT INTO CustomerAccounts (CustomerID, AccountNumber)
SELECT b.CustomerID, a. AccountNumber
FROM dbo.Bank_Data b
INNER JOIN Accounts a
ON b.AccountNumber= a.AccountNumber;

SELECT * 
FROM CustomerAccounts


--Part Four: Querying the Data

--1 • How many customers hold more than one account?

WITH CustomerCTE(CustomerID, NumberOfAccounts) AS
(
SELECT CustomerID, COUNT(*) 
FROM CustomerAccounts
GROUP BY CustomerID 
HAVING COUNT(*) > 1
)
SELECT COUNT(*) as 'Number Customers with more than one Account'
FROM CustomerCTE;


--or usual query-- dependency table

SELECT COUNT(DISTINCT c1.CustomerID) as 'Number Customers with more than one Account'
FROM CustomerAccounts c1
WHERE c1.CustomerID IN (SELECT c2.CustomerID
FROM CustomerAccounts c2
WHERE c1.CustomerID=c2.CustomerID
GROUP BY CustomerID
HAVING COUNT(*) > 1);

--• 2 What is the most popular account type?

SELECT top 1 t.AccountType, 
		COUNT(*) AS NumberOfAccounts
FROM AccountTypes t 
INNER JOIN Accounts a
ON t.AccountTypeID=a.AccountTypeID
GROUP BY t.AccountType
ORDER BY NumberOfAccounts DESC;

--3.• What is the average account balance for customers over the age of 50?

SELECT AVG(a.AccountBalance) As 'Average Bal for Customer > 50yrs'
FROM Accounts a 
INNER JOIN CustomerAccounts ca
ON a.AccountNumber = ca.AccountNumber 
INNER JOIN Customers c
ON c.CustomerID = ca.CustomerID
WHERE DATEDIFF(YEAR,c.CustomerDOB,GETDATE()) > 50;

--4. • How many accounts are there with a balance of more than £10,000?

SELECT *
FROM Accounts
where AccountBalance >10000






