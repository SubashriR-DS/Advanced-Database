---------         Trimster 2 -ADB Module MARCH 2024        --------------------
---------         Task 2								   --------------------


-- Step 1: Create the FoodserviceDB database
CREATE DATABASE FoodserviceDB;
USE FoodserviceDB;

-- Step 2: Create the Restaurants table
CREATE TABLE Restaurants1 (
    Restaurant_id INT PRIMARY KEY,
    Name NVARCHAR(255),
    City NVARCHAR(255),
    State NVARCHAR(255),
    Country NVARCHAR(255),
    Zip_code NVARCHAR(255),
    Latitude FLOAT,
    Longitude FLOAT,
    Alcohol_Service NVARCHAR(255),
    Smoking_Allowed NVARCHAR(255),
    Price NVARCHAR(255),
    Franchise NVARCHAR(255),
    Area NVARCHAR(255),
    Parking NVARCHAR(255)
);

-- Step 3: Insert data into the Restaurants table
INSERT INTO Restaurants1(Restaurant_id, Name, City, State, Country, Zip_code, Latitude, Longitude, Alcohol_Service, Smoking_Allowed, Price, Franchise, Area, Parking)
SELECT Restaurant_id, Name, City, State, Country, Zip_code, Latitude, Longitude, Alcohol_Service, Smoking_Allowed, Price, Franchise, Area, Parking
FROM dbo.restaurants;


select *
From Restaurants1

-- Step 4: Create the Consumers table
CREATE TABLE Con(
    Consumer_id NVARCHAR(50) PRIMARY KEY,
    City NVARCHAR(50),
    State NVARCHAR(50),
    Country NVARCHAR(50),
    Latitude FLOAT,
    Longitude FLOAT,
    Smoker NVARCHAR(50),
    Drink_Level NVARCHAR(50),
    Transportation_Method NVARCHAR(50),
    Marital_Status NVARCHAR(50),
    Children NVARCHAR(50),
    Age INT,
    Occupation NVARCHAR(50),
    Budget NVARCHAR(50)
);

-- Step 5: Insert data into the Consumers table
INSERT INTO Con (Consumer_id, City, State, Country, Latitude, Longitude, Smoker, Drink_Level, Transportation_Method, Marital_Status, Children, Age, Occupation, Budget)
SELECT Consumer_id, City, State, Country, Latitude, Longitude, Smoker, Drink_Level, Transportation_Method, Marital_Status, Children, Age, Occupation, Budget
FROM dbo.consumers;

--138

select *
from Con

-- Step 6: Create the Ratings table
CREATE TABLE Rating1 (
    Consumer_id NVARCHAR(50),
    Restaurant_id INT,
    Overall_Rating INT,
    Food_Rating INT,
    Service_Rating INT,
    PRIMARY KEY (Consumer_id, Restaurant_id),
    FOREIGN KEY (Consumer_id) REFERENCES Con(Consumer_id),
    FOREIGN KEY (Restaurant_id) REFERENCES Restaurants1 (Restaurant_id)
);

-- Step 7: Insert data into the Ratings table
INSERT INTO Rating1(Consumer_id, Restaurant_id, Overall_Rating, Food_Rating, Service_Rating)
SELECT Consumer_id, Restaurant_id, Overall_Rating, Food_Rating, Service_Rating
FROM dbo.ratings;

SELECT * 
FROM Rating1

-- Step 8: Create the Restaurant_Cuisines table
CREATE TABLE Restaurant_Cuisines1 (
    Restaurant_id INT,
    Cuisine NVARCHAR(255),
    PRIMARY KEY (Restaurant_id, Cuisine),
    FOREIGN KEY (Restaurant_id) REFERENCES Restaurants1(Restaurant_id)
);

-- Step 9: Insert data into the Restaurant_Cuisines table
INSERT INTO Restaurant_Cuisines1 (Restaurant_id, Cuisine)
SELECT Restaurant_id, Cuisine
FROM dbo.restaurant_cuisines;

SELECT *
FROM Restaurant_Cuisines1

-----PART 2

--1.
SELECT * 
FROM Restaurants1
WHERE Price = 'Medium' 
AND Area = 'Open' 
AND Restaurant_id IN (SELECT Restaurant_id FROM Restaurant_Cuisines WHERE Cuisine = 'Mexican');

--2.
SELECT Cuisine, COUNT(*) as Total_Restaurants
FROM Restaurant_Cuisines1 rc
JOIN Rating1 r 
ON rc.Restaurant_id = r.Restaurant_id
WHERE Overall_Rating = 1
AND (Cuisine = 'Mexican' OR Cuisine = 'Italian')
GROUP BY Cuisine;

--3.
SELECT ROUND(AVG(c.Age),0) AS Average_Age
FROM Con c
JOIN Rating1 r 
ON c.Consumer_id = r.Consumer_id
WHERE Service_Rating = 0;

--4.
SELECT r.Name, r.Restaurant_id, MIN(c.Age) AS Youngest_Age, ra.Food_Rating
FROM Restaurants1 r
JOIN Rating1 ra 
ON r.Restaurant_id = ra.Restaurant_id
JOIN Con c 
ON ra.Consumer_id = c.Consumer_id
GROUP BY r.Name, r.Restaurant_id, ra.Food_Rating
ORDER BY Youngest_Age ASC, ra.Food_Rating DESC;

--5. STORED PROCEDURE

CREATE PROCEDURE UpdateServiceRatingWithParking
AS
BEGIN
    UPDATE Rating1
    SET Service_Rating = 2
    WHERE Restaurant_id IN (
        SELECT Restaurant_id
        FROM Restaurants1
        WHERE Parking IN ('yes', 'public')
    );
END 
--Execution Procedure

EXEC UpdateServiceRatingWithParking 

SELECT *
FROM Rating1

--6.1 EXISTS
SELECT Name, City
FROM Restaurants1 r
WHERE EXISTS (SELECT 1 FROM Rating1 WHERE r.Restaurant_id = Rating1.Restaurant_id);

--6.2 IN
SELECT *
FROM Consumers
WHERE City IN (SELECT DISTINCT City FROM Restaurants1);

--6.3 SYSTEM FUNCTION GROUP BY,HAVING
SELECT Restaurant_id, COUNT(*) AS Total_Ratings
FROM Ratings
GROUP BY Restaurant_id
HAVING COUNT(*) > 10;

--6.4 SYSTEM FUNCTION GROUP BY,HAVING, ORDER BY
SELECT Country, COUNT(*) AS Total_Restaurants
FROM Restaurants
GROUP BY Country
HAVING COUNT(*) > 5
ORDER BY Total_Restaurants DESC;

--------- BACKUP and RESTORE -------------------
BACKUP DATABASE FoodserviceDB
TO DISK ='C:\FoodserviceDB_Restore\FoodserviceDBcheck.bak'
WITH CHECKSUM

-------------------Thank you-------------------------------




 







