-- Drop tables in reverse dependency order to avoid conflicts
CREATE DATABASE RecruitmentManagementSystem;
GO


IF OBJECT_ID('Shortlisted_Candidate', 'U') IS NOT NULL DROP TABLE Shortlisted_Candidate;
IF OBJECT_ID('Skill_Test', 'U') IS NOT NULL DROP TABLE Skill_Test;
IF OBJECT_ID('Offer', 'U') IS NOT NULL DROP TABLE Offer;
IF OBJECT_ID('Job_Posting_Requirement', 'U') IS NOT NULL DROP TABLE Job_Posting_Requirement;
IF OBJECT_ID('Interview_Schedule', 'U') IS NOT NULL DROP TABLE Interview_Schedule;
IF OBJECT_ID('Job_Application', 'U') IS NOT NULL DROP TABLE Job_Application;
IF OBJECT_ID('Interview', 'U') IS NOT NULL DROP TABLE Interview;
IF OBJECT_ID('Job_Posting', 'U') IS NOT NULL DROP TABLE Job_Posting;
IF OBJECT_ID('Candidate', 'U') IS NOT NULL DROP TABLE Candidate;
IF OBJECT_ID('Referral', 'U') IS NOT NULL DROP TABLE Referral;
IF OBJECT_ID('Employee', 'U') IS NOT NULL DROP TABLE Employee;
IF OBJECT_ID('Roles', 'U') IS NOT NULL DROP TABLE Roles;
IF OBJECT_ID('Department', 'U') IS NOT NULL DROP TABLE Department;

-- Use the Recruitment Management System Database
USE RecruitmentManagementSystem;
GO


-- Department Table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY IDENTITY,
    Department_Name VARCHAR(50) NOT NULL,
    Dept_Location VARCHAR(100),
    Dept_Budget DECIMAL(15, 2) CHECK (Dept_Budget >= 0)
);

-- Roles Table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY,
    Role_Name VARCHAR(50) NOT NULL,
    DeptID INT NOT NULL,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Employee Table
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY IDENTITY,
    DeptID INT NOT NULL,
    Employee_FName VARCHAR(50) NOT NULL,
    Employee_LName VARCHAR(50) NOT NULL,
    Employee_Email VARCHAR(100) NOT NULL UNIQUE,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID),
);

-- Referral Table
CREATE TABLE Referral (
    ReferralID INT PRIMARY KEY IDENTITY,
    Employee_ID INT NOT NULL,
    Relation_Type VARCHAR(50) NOT NULL,
    Referral_Date DATE NOT NULL,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);



-- Job Posting Table
CREATE TABLE Job_Posting (
    Job_ID INT PRIMARY KEY IDENTITY,
    DeptID INT NOT NULL,
    Deadline_Date DATE NOT NULL,
    Posting_Date DATE DEFAULT GETDATE(),
    Location VARCHAR(100),
    Job_Title VARCHAR(100) NOT NULL,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);



-- Interview Table
CREATE TABLE Interview (
    Interview_ID INT PRIMARY KEY IDENTITY,
    Employee_ID INT NOT NULL,
    Interview_Type VARCHAR(50) CHECK (Interview_Type IN ('Phone', 'Onsite', 'Technical', 'HR')),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

-- Candidate Table
CREATE TABLE Candidate (
    Candidate_ID INT PRIMARY KEY IDENTITY,
    Candidate_FName VARCHAR(50) NOT NULL,
    Candidate_LName VARCHAR(50) NOT NULL,
    Candidate_Phone_No VARCHAR(15) UNIQUE,
    Candidate_EmailID VARCHAR(100) NOT NULL UNIQUE,
    Referral_ID INT,
    Interview_ID INT,
    Date_of_Birth DATE,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    FOREIGN KEY (Referral_ID) REFERENCES Referral(ReferralID),
	FOREIGN KEY (Interview_ID) REFERENCES Interview(Interview_ID)
);

-- Job Application Table
CREATE TABLE Job_Application (
    Application_ID INT PRIMARY KEY IDENTITY,
    Candidate_ID INT NOT NULL,
    Application_Date DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (Candidate_ID) REFERENCES Candidate(Candidate_ID)
);

-- Interview Schedule Table
CREATE TABLE Interview_Schedule (
    Application_ID INT NOT NULL,
    Interview_ID INT NOT NULL,
    Date_of_Interview DATE,
    PRIMARY KEY (Application_ID, Interview_ID),
    FOREIGN KEY (Application_ID) REFERENCES Job_Application(Application_ID),
    FOREIGN KEY (Interview_ID) REFERENCES Interview(Interview_ID)
);

-- Job Posting Requirement Table
CREATE TABLE Job_Posting_Requirement (
    Job_ID INT NOT NULL,
    Application_ID INT NOT NULL,
    Experience INT CHECK (Experience >= 0),
    Education_Level VARCHAR(50),
    PRIMARY KEY (Job_ID, Application_ID),
    FOREIGN KEY (Job_ID) REFERENCES Job_Posting(Job_ID),
    FOREIGN KEY (Application_ID) REFERENCES Job_Application(Application_ID)
);

-- Offer Table
CREATE TABLE Offer (
    Offer_ID INT PRIMARY KEY IDENTITY,
    Candidate_ID INT NOT NULL,
    Joining_Date DATE,
    Offer_Status VARCHAR(50) CHECK (Offer_Status IN ('Accepted', 'Rejected', 'Pending')),
    Created_Date DATE DEFAULT GETDATE(),
    FOREIGN KEY (Candidate_ID) REFERENCES Candidate(Candidate_ID)
);

-- Skill Test Table
CREATE TABLE Skill_Test (
    SkillTest_ID INT PRIMARY KEY IDENTITY,
    Job_ID INT NOT NULL,
    Assessment_Date DATE NOT NULL,
    Candidate_ID INT NOT NULL,
    Score DECIMAL(5, 2) CHECK (Score >= 0 AND Score <= 100),
    Modified_Date DATE DEFAULT GETDATE(),
	Created_Date DATE DEFAULT GETDATE(),
    FOREIGN KEY (Job_ID) REFERENCES Job_Posting(Job_ID),
    FOREIGN KEY (Candidate_ID) REFERENCES Candidate(Candidate_ID)
);

-- Shortlisted Candidate Table
CREATE TABLE Shortlisted_Candidate (
    Offer_ID INT NOT NULL,
    Interview_ID INT NOT NULL,
    Shortlist_Date DATE DEFAULT GETDATE(),
    PRIMARY KEY (Offer_ID, Interview_ID),
    FOREIGN KEY (Offer_ID) REFERENCES Offer(Offer_ID),
    FOREIGN KEY (Interview_ID) REFERENCES Interview(Interview_ID)
);
