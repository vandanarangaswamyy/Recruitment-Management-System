-- 1.	Stored Procedure to Get Employee Details by Department

CREATE PROCEDURE GetEmployeeDetailsByDept
    @DeptName NVARCHAR(100),
    @EmpCount INT OUTPUT
AS
BEGIN
    -- Get the count of employees in the department
    SELECT @EmpCount = COUNT(*)
    FROM Employee e
    JOIN Department d ON e.DeptID = d.DeptID
    WHERE d.Department_Name = @DeptName;
    
    -- Return employee details
    SELECT e.Employee_FName, e.Employee_LName, e.Employee_Email
    FROM Employee e
    JOIN Department d ON e.DeptID = d.DeptID
    WHERE d.Department_Name = @DeptName;
END;
GO

DECLARE @EmpCount INT;
EXEC GetEmployeeDetailsByDept 'IT', @EmpCount OUTPUT;
SELECT @EmpCount AS 'Employee Count';

-- 2.	Stored Procedure to Insert a New Candidate and Return Their ID

CREATE PROCEDURE AddNewCandidate
    @CandidateFName NVARCHAR(100),
    @CandidateLName NVARCHAR(100),
    @CandidatePhoneNo NVARCHAR(20),
    @CandidateEmail NVARCHAR(100),
    @ReferralID INT,
    @InterviewID INT,
    @DOB DATE,
    @Gender CHAR(1),
    @NewCandidateID INT OUTPUT
AS
BEGIN
    -- Insert a new candidate
    INSERT INTO Candidate (Candidate_FName, Candidate_LName, Candidate_Phone_No, Candidate_EmailID, Referral_ID, Interview_ID, Date_of_Birth, Gender)
    VALUES (@CandidateFName, @CandidateLName, @CandidatePhoneNo, @CandidateEmail, @ReferralID, @InterviewID, @DOB, @Gender);
    
    -- Get the ID of the newly inserted candidate
    SET @NewCandidateID = SCOPE_IDENTITY();
END;
GO

DECLARE @NewCandidateID INT;
EXEC AddNewCandidate 'John', 'Doe', '8573975545', 'john.doe@example.com', 1, 2, '1990-05-15', 'M', @NewCandidateID OUTPUT;
SELECT @NewCandidateID AS 'New Candidate ID';

-- 3.	Stored Procedure to Update Candidate Contact Information
CREATE PROCEDURE UpdateCandidateContactInfo
    @CandidateID INT,
    @NewPhone VARCHAR(20),
    @NewEmail VARCHAR(100)
AS
BEGIN
    -- Update the phone and email for the specified candidate
    UPDATE Candidate
    SET Candidate_Phone_No = @NewPhone,
        Candidate_EmailID = @NewEmail
    WHERE Candidate_ID = @CandidateID;
END;

EXEC UpdateCandidateContactInfo 
    @CandidateID = 1, 
    @NewPhone = '9999999999999', 
    @NewEmail = 'johnson.doe@example.com';

select * from Candidate

-- VIEWS
-- 1.	Employee Overview View
CREATE VIEW Employee_Overview AS
SELECT 
    E.Employee_ID,
    E.Employee_FName,
    E.Employee_LName,
    E.Employee_Email,
    D.Department_Name,
    R.Role_Name,
    O.Offer_Status,
    O.Joining_Date
FROM 
    Employee E
JOIN 
    Department D ON E.DeptID = D.DeptID
JOIN 
    Roles R ON E.DeptID = R.DeptID
LEFT JOIN 
    Offer O ON E.Employee_ID = O.Candidate_ID;

SELECT * from Employee_Overview

-- 2.	Skills and Performance Report View 
CREATE VIEW Candidate_Skills_Report AS
SELECT 
    C.Candidate_FName,
    C.Candidate_LName,
    C.Candidate_EmailID,
    JP.Job_Title,
    ST.Score,
    JP.Location,
    JP.Deadline_Date,
    JR.Experience,
    JR.Education_Level
FROM 
    Candidate C
JOIN 
    Job_Application JA ON C.Candidate_ID = JA.Candidate_ID
JOIN 
    Job_Posting JP ON JA.Application_ID = JP.DeptID
JOIN 
    Skill_Test ST ON C.Candidate_ID = ST.Candidate_ID
JOIN 
    Job_Posting_Requirement JR ON JP.Job_ID = JR.Job_ID;

SELECT * from Candidate_Skills_Report

-- 3.	View for Department Job Openings
CREATE VIEW Department_Job_Openings AS
SELECT 
    j.Job_Title,
    d.Department_Name
FROM 
    Job_Posting j
JOIN 
    Department d ON j.DeptID = d.DeptID;
SELECT * from Department_Job_Openings

-- USER DEFINED FUNCTIONS
-- 1.	Get Candidate's Total Applications Count
CREATE FUNCTION dbo.fn_GetTotalApplications (@Candidate_ID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalApplications INT;
    
    SELECT @TotalApplications = COUNT(*)
    FROM Job_Application
    WHERE Candidate_ID = @Candidate_ID;

    RETURN @TotalApplications;
END;

SELECT dbo.fn_GetTotalApplications(1) AS TotalApplications;

-- 2.	Get Candidate's Interview Type
CREATE FUNCTION dbo.fn_GetInterviewType (@Interview_ID INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @InterviewType VARCHAR(50);
    
    SELECT @InterviewType = Interview_Type
    FROM Interview
    WHERE Interview_ID = @Interview_ID;

    RETURN @InterviewType;
END;

SELECT dbo.fn_GetInterviewType(5) AS InterviewType;


-- 3.	Get Referral Count for Employee
CREATE FUNCTION dbo.fn_GetReferralCount (@Employee_ID INT)
RETURNS INT
AS
BEGIN
    DECLARE @ReferralCount INT;
    
    SELECT @ReferralCount = COUNT(*)
    FROM Referral
    WHERE Employee_ID = @Employee_ID;

    RETURN @ReferralCount;
END;

SELECT dbo.fn_GetReferralCount(1) AS ReferralCount;

-- DML TRIGGERS
-- 
CREATE TABLE Offer_Log (
    LogID INT PRIMARY KEY IDENTITY,
    Offer_ID INT NOT NULL,
    Old_Status VARCHAR(50),
    New_Status VARCHAR(50),
    Modified_Date DATETIME DEFAULT GETDATE(),
    Modified_By NVARCHAR(100)
);
CREATE TRIGGER trg_OfferStatusUpdate
ON Offer
AFTER UPDATE
AS
BEGIN
    -- Insert log entry for status updates
    INSERT INTO Offer_Log (Offer_ID, Old_Status, New_Status, Modified_By)
    SELECT 
        d.Offer_ID, 
        d.Offer_Status AS Old_Status, 
        i.Offer_Status AS New_Status, 
        SYSTEM_USER AS Modified_By
    FROM 
        Deleted d
    JOIN 
        Inserted i ON d.Offer_ID = i.Offer_ID
    WHERE 
        d.Offer_Status <> i.Offer_Status; -- Only log if status has changed
END;
-- Update an offer status to test the trigger
UPDATE Offer
SET Offer_Status = 'Rejected'
WHERE Offer_ID = 1;

-- Check the Offer_Log table for changes
SELECT * FROM Offer_Log;

