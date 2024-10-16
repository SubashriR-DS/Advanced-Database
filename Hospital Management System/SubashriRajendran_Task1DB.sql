-------------       Trimster 2-  ADB Module       ----------------
------------         Task 1            ----------------

-- Create a database for hospital management
CREATE DATABASE HospitalManagementSystem;

-- Use the newly created database
USE HospitalManagementSystem;


-- Create table  1 for Patients 
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Age INT NOT NULL,
    Bloodgroup NVARCHAR(15) NULL,
    Gender NVARCHAR(10) NOT NULL,
	AdmissionDate Date NOT NULL,
	DischargeDate Date Not NULL,
	Email NVARCHAR(100) Not,
	Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Insurance NVARCHAR(30) NULL,
    P_Address NVARCHAR(255) NOT NULL,
	P_City NVARCHAR(255) NOT NULL,
	P_Pincode NVARCHAR(255) NOT NULL,
    ContactNumber NVARCHAR(20) NOT NULL
	
);

-- Create table for Doctors 2
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Specialization NVARCHAR(50) NOT NULL,
	ContactNumber NVARCHAR(20)
);

---- Create table for Departments 3
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY , 
    DepartmentName NVARCHAR(100) NOT NULL,
    HeadDoctorID INT,
    FOREIGN KEY (HeadDoctorID) REFERENCES Doctors(DoctorID)
);

-- Create table for Appointments 4
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    DepartmentID INT,
    AppointmentStatus VARCHAR(20) DEFAULT 'pending' CHECK (AppointmentStatus IN ('pending', 'cancelled', 'completed')),
    FOREIGN KEY (PatientID) REFERENCES Patients (PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create table for MedicalRecords 5
CREATE TABLE MedicalRecords(
    MedicalRecordID INT PRIMARY KEY ,
    PatientID INT,
    DoctorID INT,
    Diagnoses NVARCHAR(200) NOT NULL,
    MedicineName NVARCHAR(255) NOT NULL,
    MedicinePrescribedDate DATE NOT NULL,
    Allergies NVARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);


-- Create table for Diagnoses 6
CREATE TABLE Diagnosis (
    DiagnosisID INT PRIMARY KEY,
    PatientID INT,
    Diagnosis NVARCHAR(100),
    DiagnosisDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Create table for Allergies 7
CREATE TABLE Allergies (
    AllergyID INT PRIMARY KEY,
    PatientID INT,
    Allergy NVARCHAR(100),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Create table for Feedback 8
CREATE TABLE Feedback(
    FeedbackID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Review TEXT,
    DateAdded DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);


--Junction table for M-N relationship entities 4 combinations

--Junction table :1 Create the junction table for the M-M relationship between Patients and Doctors
CREATE TABLE PatientDoctor (
    PatientID INT NOT NULL FOREIGN KEY (PatientID) REFERENCES Patients (PatientID),
    DoctorID INT NOT NULL FOREIGN KEY (DoctorID) REFERENCES Doctors (DoctorID)
    PRIMARY KEY (PatientID, DoctorID)) 
     

-- Junction table :2
CREATE TABLE PatientMedicalRecords(
    PatientID INT NOT NULL FOREIGN KEY (PatientID) REFERENCES Patients (PatientID),
    MedicalRecordID INT NOT NULL  FOREIGN KEY (MedicalRecordID) REFERENCES MedicalRecords (MedicalRecordID)
    PRIMARY KEY (PatientID, MedicalRecordID))

--- Junction table :3
-- Create junction table for the many-to-many relationship between Patients and Diagnoses
CREATE TABLE PatientDiagnosis (
    PatientID INT NOT NULL FOREIGN KEY (PatientID) REFERENCES Patients (PatientID),
	DiagnosisID INT NOT NULL FOREIGN KEY (DiagnosisID) REFERENCES Diagnosis(DiagnosisID),
	PRIMARY KEY (PatientID, DiagnosisID))

-- Junction table :4
-- Create junction table for the many-to-many relationship between Patients and Allergies
CREATE TABLE PatientAllergy (
	PatientID INT NOT NULL FOREIGN KEY (PatientID) REFERENCES Patients (PatientID),
    AllergyID INT NOT NULL FOREIGN KEY (AllergyID) REFERENCES Allergies(AllergyID),
	PRIMARY KEY (PatientID, AllergyID))

--INSERT RECORDS


-- Inserting 8 records into the Patients table

INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, Age, Bloodgroup, Gender, AdmissionDate, DischargeDate, Email, Username, Password, Insurance, P_Address, P_City, P_Pincode, ContactNumber)
VALUES
(1, 'John', 'Doe', '1990-05-15', 33, 'O+', 'Male', '2023-10-01', '2023-10-10', 'john.doe@gmail.com', 'johndoe', HASHBYTES('sha1','johnpwd'), 'ABC Insurance', '123 Main St', 'London', 'L12345', '555-123-4567'),

(2, 'Jane', 'Smith', '1985-12-20', 38, 'AB-', 'Female', '2023-11-05', '2023-11-15', 'jane.smith@gmail.com', 'janesmith', HASHBYTES('sha1','smith123'), 'HealthDay', '456 Oak St', 'Manchester', 'M67890', '555-987-6543'),

(3, 'Michael', 'Johnson', '1978-08-03', 45, 'A+', 'Male', '2023-09-10', '2023-09-20', 'michael.johnson@yahoo.com', 'michaelj', HASHBYTES('sha1','michaelstr'), NULL, '789 Elm St', 'Manchester', 'M13579', '555-456-7890'),

(4, 'Emily', 'Brown', '1995-04-25', 28, 'B+', 'Female', '2023-08-15', '2023-08-25', 'emily.brown@gmail.com', 'emilyb', HASHBYTES('sha1','welcomedot'), 'ABC Insurance', '321 Pine St', 'London Euston', 'LE24680', '555-321-6548'),

(5, 'David', 'Wilson', '1980-11-10', 43, 'A-', 'Male', '2023-07-20', '2023-08-01', 'david.wilson@yahoo.com', 'davidw', HASHBYTES('sha1','playpp'), 'HealthDay', '987 Cedar St', 'London Euston', 'LE97531', '555-789-1234'),

(6, 'Sarah', 'Jones', '1998-03-18', 25, 'O-', 'Female', '2023-06-05', '2023-06-15', 'sarah.jones@yahoo.com', 'sarahj', HASHBYTES('sha1','doedoe'), 'HealthDay', '654 Birch St', 'Manchester', 'M35791', '555-654-9871'),

(7, 'James', 'Davis', '1970-09-30', 53, 'AB+', 'Male', '2023-12-01', '2023-12-10', 'james.davis@gmail.com', 'jamesd', HASHBYTES('sha1','abqewed'), NULL, '852 Maple St', 'London', 'L35724', '555-987-4561'),

(8, 'Jennifer', 'Martinez', '1987-06-12', 36, 'A-', 'Female', '2023-05-10', '2023-05-20', 'jennifer.martinez@yahoo.com', 'jenniferm', HASHBYTES('sha1','qxepwp'), 'ABC Insurance', '159 Walnut St', 'London', 'L65432', '555-852-7410');

INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, Age, Bloodgroup, Gender, AdmissionDate, DischargeDate, Email, Username, Password, Insurance, P_Address, P_City, P_Pincode, ContactNumber)
VALUES
(14, 'Alice', 'Johnson', '1972-09-08', 53, 'AB+', 'Female', '2023-05-16', '2023-05-23', 'alice.johnson@example.com', 'alicej', HASHBYTES('sha1','alicepwd'), 'HealthCare', '123 Maple St', 'Manchester', 'M12345', '555-111-2222'),

(15, 'Robert', 'Miller', '1975-06-20', 49, 'O+', 'Male', '2023-04-15', '2023-04-25', 'robert.miller@example.com', 'robertm', HASHBYTES('sha1','robertpwd'), 'ABC Insurance', '456 Walnut St', 'London', 'L67890', '555-333-4444'),

(16, 'Emma', 'Davis', '1975-12-15', 48, 'B-', 'Female', '2023-04-11', '2023-04-15', 'emma.davis@example.com', 'emmad', HASHBYTES('sha1','emmapwd'), NULL, '789 Oak St', 'Manchester', 'M24680', '555-555-6666'),

(17, 'William', 'Taylor', '1983-03-30', 41, 'A+', 'Male', '2023-05-10', '2023-05-20', 'william.taylor@example.com', 'williamt', HASHBYTES('sha1','williampwd'), 'HealthCare', '987 Elm St', 'London Euston', 'LE12345', '555-777-8888');


INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, Age, Bloodgroup, Gender, AdmissionDate, DischargeDate, Email, Username, Password, Insurance, P_Address, P_City, P_Pincode, ContactNumber)
VALUES
    (18, 'Alice', 'Johnson', '1987-09-08', 37, 'AB+', 'Female', '2024-01-16', '2024-01-18', 'alice.johnson@example.com', 'alicej', HASHBYTES('sha1','alicepwd'), 'HealthCare', '123 Maple St', 'Manchester', 'M12345', '555-111-2222'),
    (19, 'Robert', 'Miller', '1975-06-20', 49, 'O+', 'Male', '2024-01-15', '2024-01-20', 'robert.miller@example.com', 'robertm', HASHBYTES('sha1','robertpwd'), 'ABC Insurance', '456 Walnut St', 'London', 'L67890', '555-333-4444');


select * 
FROM Patients

-- Insert 8 records into the Doctors table
INSERT INTO Doctors (DoctorID, FirstName, LastName, Specialization, ContactNumber)
VALUES
    (1, 'John', 'Smith', 'Cardiology', '123-456-7890'),
    (2, 'Emily', 'Johnson', 'Pediatrics', '234-567-8901'),
    (3, 'Michael', 'Williams', 'Orthopedics', '345-678-9012'),
    (4, 'Jessica', 'Brown', 'Neurology', '456-789-0123'),
    (5, 'David', 'Martinez', 'Oncology', '567-890-1234'),
    (6, 'Sarah', 'Garcia', 'Dermatology', '678-901-2345'),
    (7, 'Christopher', 'Lopez', 'Endocrinology', '789-012-3456'),
    (8, 'Amanda', 'Wilson', 'Gastroenterology', '890-123-4567');

SELECT *
FROM Doctors

-- Insert 8 records into the Departments table
INSERT INTO Departments (DepartmentID, DepartmentName, HeadDoctorID)
VALUES
    (1, 'Cardiology', 1),        
    (2, 'Pediatrics', 2),        
    (3, 'Orthopedics', 3),    
    (4, 'Neurology', 4),         
    (5, 'Oncology', 5),          
    (6, 'Dermatology', 6),       
    (7, 'Endocrinology', 7),     
    (8, 'Gastroenterology', 8); 

SELECT *
FROM Departments

--Insert 8 records into the Appoinments table
INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, DepartmentID, AppointmentStatus)
VALUES
    (1, 1, 1, '2024-03-20', '10:00:00', 1, 'pending'),   
    (2, 2, 2, '2024-03-21', '11:00:00', 2, 'pending'),   
    (3, 3, 3, '2024-03-22', '09:00:00', 3, 'pending'),   
    (4, 4, 4, '2024-03-23', '14:00:00', 4, 'pending'),   
    (5, 5, 5, '2024-03-24', '13:00:00', 5, 'pending'),   
    (6, 6, 6, '2024-03-25', '15:00:00', 6, 'pending'),   
    (7, 7, 7, '2024-03-26', '12:00:00', 7, 'pending'),   
    (8, 8, 8, '2024-03-27', '16:00:00', 8, 'pending');   

INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, DepartmentID, AppointmentStatus)
VALUES
	(14, 14, 5, '2024-04-27', '16:00:00', 5,'pending'),
	(15, 15, 5, '2024-04-27', '16:30:00', 5,'pending'),
	(16, 16, 5, '2024-04-27', '17:00:00', 5,'pending'),
	(17, 17, 5, '2024-04-27', '17:30:00', 5,'pending');
INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, DepartmentID, AppointmentStatus)
VALUES
	(18, 18, 1, '2024-04-15', '4:00:00', 1,'pending'),
	(19, 19, 1, '2024-04-15', '4:30:00', 1,'pending');


SELECT *
FROM Appointments

---- Insert 8 records into the MedicalRecords table
INSERT INTO MedicalRecords (MedicalRecordID, PatientID, DoctorID, Diagnoses, MedicineName, MedicinePrescribedDate, Allergies)
VALUES
    (1, 1, 1, 'Fever', 'Paracetamol', '2024-03-15', NULL),    
    (2, 2, 2, 'Common Cold', 'DParacetamolCold', '2024-03-16', 'Penicillin'),  
    (3, 3, 3, 'Fractured Arm', 'Codamoline', '2024-03-17', NULL),  
    (4, 4, 4, 'Migraine', 'Sumatriptan', '2024-03-18', 'Aspirin'),  
    (5, 5, 5, 'Cancer', 'Chemotherapy', '2024-03-19', NULL),    
    (6, 6, 6, 'Eczema', 'Corticosteroids', '2024-03-20', NULL),  
    (7, 7, 7, 'Diabetes', 'Insulinacetamol', '2024-03-21', NULL),      
    (8, 8, 8, 'Appendicitis', 'Surgerymol', '2024-03-22', 'Penicillin');  

SELECT *
FROM MedicalRecords

---- Insert 8 records into the Diagnosis table
INSERT INTO Diagnosis (DiagnosisID, PatientID, Diagnosis, DiagnosisDate)
VALUES
    (1, 1, 'Fever', '2024-03-15'),    
    (2, 2, 'Common Cold', '2024-03-16'),  
    (3, 3, 'Fractured Arm', '2024-03-17'),  
    (4, 4, 'Migraine', '2024-03-18'),  
    (5, 5, 'Cancer', '2024-03-19'),    
    (6, 6, 'Eczema', '2024-03-20'),    
    (7, 7, 'Diabetes', '2024-03-21'),  
    (8, 8, 'Appendicitis', '2024-03-22');  
INSERT INTO Diagnosis (DiagnosisID, PatientID, Diagnosis, DiagnosisDate)
VALUES
	(14, 14, 'Cancer', '2024-03-19'),
	(15, 15, 'Cancer', '2024-03-19'), 
	(16, 16, 'Cancer', '2024-03-19'), 
	(17, 17, 'Cancer', '2024-03-19');
INSERT INTO Diagnosis (DiagnosisID, PatientID, Diagnosis, DiagnosisDate)
VALUES
	(18, 18, 'Cancer', '2024-04-15'),
	(19, 19, 'Cancer', '2024-04-15');

SELECT *
FROM Diagnosis

---- Insert 8 records into the Allergies table
INSERT INTO Allergies (AllergyID, PatientID, Allergy)
VALUES
    (1, 1, 'Peanuts'),    
    (2, 2, 'Penicillin'),  
    (3, 3, 'Shellfish'),   
    (4, 4, 'Pollen'),      
    (5, 5, 'Cats'),       
    (6, 6, 'Dust'),        
    (7, 7, 'Mold'),        
    (8, 8, 'Eggs');  
INSERT INTO Allergies (AllergyID, PatientID, Allergy)
VALUES
    (9, 18, 'Peanuts'),    
    (10, 19, 'Penicillin');

SELECT *
FROM Allergies

---- Insert 8 records into the Feedback table
INSERT INTO Feedback (FeedbackID, PatientID, DoctorID, Review, DateAdded)
VALUES
    (1, 1, 1, 'Great experience with Dr. Smith. Very knowledgeable and helpful.', '2024-03-01'),
    (2, 2, 2, 'Dr. Johnson provided excellent care. Highly recommend!', '2024-03-02'),
    (3, 3, 3, 'Had a positive experience with Dr. Brown. Friendly and professional.', '2024-03-03'),
    (4, 4, 4, 'Dr. Wilson was attentive and thorough. Thank you!', '2024-03-04'),
    (5, 5, 5, 'Excellent service from Dr. Anderson. Addressed all my concerns.', '2024-03-05'),
    (6, 6, 6, 'Dr. Martinez was very helpful and understanding. Highly recommended.', '2024-03-06'),
    (7, 7, 7, 'Had a great consultation with Dr. Taylor. Very informative.', '2024-03-07'),
    (8, 8, 8, 'Dr. Garcia provided excellent care. Thank you for your help!', '2024-03-08');

SELECT *
FROM Feedback
---------------------- PART 2 --------------------------

--PART 2:Q2
ALTER TABLE Appointments
ADD CONSTRAINT Check_AppointmentDate_NotInPast 
CHECK (AppointmentDate >= GETDATE())

select *
FROm Appointments

UPDATE Appointments
SET AppointmentStatus = 'completed'
WHERE AppointmentDate <= CAST(GETDATE() AS DATE);


--Q3.

SELECT Patients.*, Diagnosis.Diagnosis
FROM Patients
JOIN Diagnosis 
ON Patients.PatientID = Diagnosis.PatientID
WHERE DATEDIFF(YEAR, Patients.DateOfBirth, GETDATE()) > 40
AND Diagnosis.Diagnosis LIKE '%Cancer%';

--Q4.a

CREATE PROCEDURE SearchMedicineByNames
    @MedicineName NVARCHAR(255)
AS
BEGIN
    SELECT MedicalRecords.*, Patients.FirstName, Patients.LastName
    FROM MedicalRecords
    JOIN Patients ON MedicalRecords.PatientID = Patients.PatientID
    WHERE MedicineName LIKE '%' + @MedicineName + '%'
    ORDER BY MedicinePrescribedDate DESC;
END;

EXEC SearchMedicineByNames @MedicineName = '%mol%'

--Q4.b

CREATE PROCEDURE GetDiagnosisAndAllergiesForToday
    @PatientID INT
AS
BEGIN
    DECLARE @Today DATE = GETDATE();
    
    SELECT Diagnosis.Diagnosis, Diagnosis.DiagnosisDate, Allergies.Allergy
    FROM Diagnosis
    JOIN Allergies ON Diagnosis.PatientID = Allergies.PatientID
    WHERE Diagnosis.PatientID = @PatientID
    AND EXISTS (
        SELECT 1
        FROM Appointments
        WHERE Appointments.PatientID = @PatientID
        AND AppointmentDate = @Today
    );
END;

EXEC GetDiagnosisAndAllergiesForToday @PatientID = 18
EXEC GetDiagnosisAndAllergiesForToday @PatientID = 19

--Q4.C.
CREATE PROCEDURE UpdateDoctorDetails
    @DoctorID INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Specialization NVARCHAR(50),
    @ContactNumber NVARCHAR(20)
AS
BEGIN
    UPDATE Doctors
    SET FirstName = @FirstName,
        LastName = @LastName,
        Specialization = @Specialization,
        ContactNumber = @ContactNumber
    WHERE DoctorID = @DoctorID;
END;

--EXEC

SELECT *
FROM Doctors

EXEC UpdateDoctorDetails 
	@DoctorID = 1,
    @FirstName = 'Dr. John', 
    @LastName = 'Smith', 
    @Specialization = 'HeadDr.Cardiology', 
    @ContactNumber = '123-456-7890';

--4.d
SELECT * 
FROM Appointments

CREATE TABLE #tempappointment (
    AppointmentID INT
);

-- Step 2: Insert completed appointments into the temporary table
INSERT INTO #tempappointment (AppointmentID)
SELECT AppointmentID
FROM Appointments
WHERE AppointmentStatus = 'completed';

-- Step 3: Delete completed appointments from the main Appointments table
DELETE FROM Appointments
WHERE AppointmentID IN (SELECT AppointmentID FROM #tempappointment);

SELECT AppointmentID 
FROM #tempappointment

SELECT *
FROM #tempappointment
SELECT *
FROM Appointments

-- SELECT * INTO #TempAppointments FROM Appointments ;
 
-- SELECT * FROM #TempAppointments ;

CREATE PROCEDURE DeleteCompletedAppointments
AS
BEGIN
    DELETE FROM Appointments
    WHERE AppointmentStatus = 'completed';
END;

EXEC DeleteCompletedAppointments

--5 SQL View
CREATE VIEW AppointmentDetailsView AS
SELECT 
    A.AppointmentID,
    A.AppointmentDate,
    A.AppointmentTime,
    A.AppointmentStatus,
    D.FirstName AS DoctorFirstName,
    D.LastName AS DoctorLastName,
    D.Specialization AS DoctorSpecialization,
    D.ContactNumber AS DoctorContactNumber,
    Dep.DepartmentName,
    F.Review AS DoctorReview
FROM 
    Appointments A
JOIN 
    Doctors D ON A.DoctorID = D.DoctorID
JOIN 
    Departments Dep ON A.DepartmentID = Dep.DepartmentID
LEFT JOIN 
    Feedback F ON A.DoctorID = F.DoctorID;

-- View Results

SELECT * 
FROM AppointmentDetailsView;



--Q6.
INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, Age, Bloodgroup, Gender, AdmissionDate, DischargeDate, Email, Username, Password, Insurance, P_Address, P_City, P_Pincode, ContactNumber)
VALUES
(9, 'Alex', 'Johnson', '1975-02-28', 52, 'B-', 'Male', '2023-04-01', '2023-04-10', 'alex.johnson@gmail.com', 'alexj', HASHBYTES('sha1','alexpwd'), 'HealthCare', '753 Elm St', 'Manchester', 'M97531', '555-321-9876'), -- Completed
(10, 'Sophia', 'Williams', '1983-07-08', 41, 'AB+', 'Female', '2023-04-01', '2023-04-10', 'sophia.williams@gmail.com', 'sophiaw', HASHBYTES('sha1','sophiapwd'), 'HealthCare', '852 Oak St', 'Manchester', 'M35791', '555-987-6543'), -- Completed
(11, 'Ethan', 'Brown', '1976-11-23', 48, 'O-', 'Male', '2023-12-01', '2023-12-10', 'ethan.brown@gmail.com', 'ethanb', HASHBYTES('sha1','ethanpwd'), 'ABC Insurance', '456 Cedar St', 'London Euston', 'LE65432', '555-123-4567'); -- Cancelled

SELECT *
FROM Patients

-- Insert records with appointment status 'completed' and 'cancelled'
INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, DepartmentID, AppointmentStatus)
VALUES
(9, 9, 1, '2024-03-16', '08:30:00', 1, 'completed'),  -- Update AppointmentID 1 to 'completed'
(10, 10, 2, '2024-03-16', '09:00:00', 2, 'completed'), -- Update AppointmentID 2 to 'completed'
(11, 11, 3, '2024-05-03', '10:00:00', 3, 'cancelled'); -- Update AppointmentID 3 to 'cancelled'


--Triggers

CREATE TRIGGER TRIG_CancelledAppointment
ON Appointments
AFTER UPDATE
AS
BEGIN
    IF UPDATE(AppointmentStatus)
    BEGIN
        UPDATE Appointments
        SET AppointmentStatus = 'available'
        FROM Appointments AS a
        INNER JOIN inserted AS i ON a.AppointmentID = i.AppointmentID
        WHERE i.AppointmentStatus = 'cancelled';
    END
END;

--Execu :No Eecution for Triggers
CREATE TRIGGER UpdateAppointmentStateOnCancel
ON Appointments
AFTER UPDATE
AS
BEGIN
    IF UPDATE(AppointmentStatus)  -- Check if AppointmentStatus column is update
    BEGIN
        UPDATE Appointments
        SET AppointmentStatus = 'available'
        WHERE AppointmentStatus = 'cancelled';
    END
END;

Select *
FROM Appointments


INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, Age, Bloodgroup, Gender, AdmissionDate, DischargeDate, Email, Username, Password, Insurance, P_Address, P_City, P_Pincode, ContactNumber)
VALUES
    (12, 'Emma', 'Anderson', '1990-09-15', 31, 'O+', 'Female', '2023-04-05', '2023-04-15', 'emma.anderson@example.com', 'emmaa', HASHBYTES('sha1','emmapwd'), 'ABC Insurance', '456 Birch St', 'London', 'L24680', '555-123-9876'), 
    (13, 'Oliver', 'Wilson', '1978-05-20', 43, 'A-', 'Male', '2023-03-20', '2023-03-30', 'oliver.wilson@example.com', 'oliverw', HASHBYTES('sha1','oliverpwd'), 'HealthCare', '789 Cedar St', 'Manchester', 'M13579', '555-987-6543'); 

select *
from Patients

INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, DepartmentID, AppointmentStatus)
VALUES
(12, 12, 8, '2024-03-16', '08:30:00', 8, 'completed'),  -- Update AppointmentID 1 to 'completed'
(13, 13, 8, '2024-03-16', '09:00:00', 8, 'completed') ; -- Update AppointmentID 2 to 'completed'

Select *
FROM Appointments

--Q7.

SELECT COUNT(*) AS CompletedAppointments
FROM Appointments AS A
JOIN Doctors AS D 
ON A.DoctorID = D.DoctorID
WHERE A.AppointmentStatus = 'completed'
AND D.Specialization = 'Gastroenterology';


---------Additional Recommendation-----------------------------------------------------------

--Creating Users & Roles and using GRANT and REVOKE
CREATE LOGIN Testuser
WITH PASSWORD = 'testuser99!';

CREATE USER Testuser FOR LOGIN Testuser;
GRANT SELECT ON SCHEMA :: Patients TO Testuser;

EXECUTE AS USER = 'Testuser';


---------BACKUP and RESTORE ------------------
BACKUP DATABASE HospitalManagementSystem
TO DISK ='C:\HospitalMgmtSystem_Restore\HospitalManagementSystemcheck.bak'
WITH CHECKSUM
--------------------Extra analysis ----------------
SELECT 
    p.PatientID,p.FirstName,p.LastName,p.DateOfBirth,p.Age, p.Bloodgroup,p.Gender,p.AdmissionDate,
    p.DischargeDate,p.Email,p.Username,p.Password,p.Insurance,p.P_Address,p.P_City,p.P_Pincode,
    p.ContactNumber
FROM 
    Patients p
WHERE 
    p.PatientID IN (
        SELECT 
            a.PatientID
        FROM 
            Appointments a
        JOIN 
            Doctors d ON a.DoctorID = d.DoctorID
        WHERE 
            d.Specialization = 'Oncology'
    );

---------------------------thank you---------------------------