------------------week 4---------------------
-----------------DDL, DML -------------------------
--create DB with 3 tables




--create the database
create database salfordBuildingProjects;

--use the database
use salfordBuildingProjects

--create table No:1
CREATE TABLE Employees (
EmployeeID int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(30) NOT NULL, 
MiddleName nvarchar(30) NULL,
LastName nvarchar(30) NOT NULL, 
DepartmentID tinyint NOT NULL, 
mailAddress nvarchar(50) NOT NULL, 
LineManagerID int NULL,
DateJoined date NOT NULL,
DateLeft date NULL)


--create table No:2
CREATE TABLE Department (
DepartmentID tinyint IDENTITY(1,1) PRIMARY KEY,
DepartmentName nvarchar(30) NOT NULL,
DepartmentEmail nvarchar(50) NULL, 
DepartmentTelephone nvarchar(20) NOT NULL);

--create table No:3
CREATE TABLE Projects (
ProjectID int IDENTITY(1,1) PRIMARY KEY,
ProjectName nvarchar(50) NOT NULL,
ProjectManagerID int NULL FOREIGN KEY REFERENCES Employees (EmployeeID),
StartDate date NULL, EndDate date NULL);

ALTER TABLE Employees ADD CONSTRAINT fk_department
FOREIGN KEY (DepartmentID) REFERENCES Department
(DepartmentID);

ALTER TABLE Employees ADD CONSTRAINT fk_employee
FOREIGN KEY (LineManagerID) REFERENCES Employees
(EmployeeID);


--Part Two: Using INSERT to add data to a table

--two ways  to insert
-- 1.INSERT without specifying columns

INSERT INTO Department
VALUES ('Marketing', 'marketing@salfordbuildingprojects.co.uk','0161 123 4567'),
('HR', 'hr@salfordbuildingprojects.co.uk','0161 123 4568');

--2.INSERT with specifying columns

INSERT INTO Department (DepartmentEmail, DepartmentTelephone, DepartmentName)
VALUES ('operations@salfordbuildingprojects.co.uk', '0161 123 4590','Operations'),
('sales@salfordbuildingprojects.co.uk', '0161 123 4591','Sales');

--9. Write a SELECT statement which will return all the data you have just inserted into the Department table (answers to be provided after the workshop).

SELECT *
FROM Department

--10. Will this statement execute successfully?

INSERT INTO Employees
VALUES ('Beatrice', 'Alice', ' Robinson', 2, 'b.robinson@salfordbuildingprojects.co.uk', NULL,'2020-08-30',
NULL);
--DEPARTMENTid IS null 4TH VALUES
INSERT INTO Employees
VALUES ('Ejimofor', NULL, ' Chinweuba', NULL, 'e.chinweuba@salfordbuildingprojects.co.uk', 1,'2021-12-02', NULL);

--11 CORRECT ANSWER
INSERT INTO Employees
VALUES ('Ejimofor', NULL, ' Chinweuba', 3, 'e.chinweuba@salfordbuildingprojects.co.uk', 1,'2021-12-02', NULL);

--12) Will this statement execute successfully? EMAIL ID MISSING
INSERT INTO Employees
VALUES ('Ailén', 'Leal', 'Soria', 3, 'ailen@salfordbuildingprojects.co.uk',1,'2022-10-22', NULL);

--13) Will this statement execute successfully? LAST name is missing
INSERT INTO Employees (FirstName,MiddleName,LastName, DepartmentID, mailAddress,LineManagerID,DateJoined,DateLeft)
VALUES ('Houd', 'Mustafa','Sa', 3, 'h.mustafa@salfordbuildingprojects.co.uk',12,'2022-09-11',NULL);

--14) Will this statement execute successfully? EMAIL ADRESSS NOT PRESENT IN THE ATTRIBUTES
INSERT INTO Employees (FirstName, LastName, DepartmentID, mailAddress, DateJoined)
VALUES ('Charles', 'Dotson', 3,'c.dotson@salfordbuildingprojects.co.uk','2018-02-14');

--15) Will this statement execute successfully? EMAIL ADRESSS NOT PRESENT IN THE ATTRIBUTES
INSERT INTO Employees (FirstName, LastName, DepartmentID, mailAddress, DateJoined)
VALUES ('Zhen', 'Pai', 3,'z.pai@salfordbuildingprojects.co.uk', '2018-12-12');

SELECT *
FROM Employees

--16) Now we want to insert the following data into the Projects table.

INSERT INTO Projects(ProjectID,ProjectName,ProjectManagerID,StartDate,EndDate) VALUES(11,'Riverbank Way',3,'2019-10-23',NULL)
insert into Projects values('Manchester Mall',8,'2017-11-06','2022-08-08')
insert into Projects values('Riverbank way',3,'2019-10-23',NULL)
insert into Projects values('Cresent Towers',3,'2019-10-23',NULL)

select*
from Projects




--Part Three: Using UDPATE to modify data to a table

INSERT INTO Employees (FirstName, LastName, DepartmentID, mailAddress, DateJoined)
VALUES ('Charles', 'DUKKU', 2, 9000, '2018-02-14');

SELECT *
FROM Employees


--uPDATE
UPDATE Employees
SET mailAddress = 'c.dukku@salfordbuildingprojects.co.uk' 
WHERE mailAddress = '9000';

--18 Both projects managed by Ejimofor Chinweuba finished on the 17th December 2022. Update the projects table accordingly.

update Projects
set EndDate ='2022-12-17'
where ProjectManagerID =3

select *
from Projects

--19) Ailén Soria left the company on the 4th February 2023. Update her employee record accordingly
update Employees
set DateLeft ='2023-02-04'
where EmployeeID =4

--20) The company decides to get rid of the departmental email addresses. Set all values in this column to NULL.

select * 
from Department

update Department
set DepartmentEmail =NULL

--21)

update Department
set DepartmentTelephone = '0161 123 4592'
where DepartmentTelephone LIKE '0161 123 456_'

select * 
from Department




--Part Four: Using DELETE to modify data to a table

select *
from Department

--22. 

DELETE FROM Department
WHERE DepartmentName='Marketing'

update Department 
set DepartmentName ='sales'

--23
DELETE FROM Department
WHERE DepartmentName='HR'












