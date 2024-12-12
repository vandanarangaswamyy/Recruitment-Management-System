-- Insert sample data into Department table
INSERT INTO Department (Department_Name, Dept_Location, Dept_Budget)
VALUES 
('HR', 'New York', 500000),
('IT', 'San Francisco', 1000000),
('Marketing', 'Chicago', 750000),
('Finance', 'Seattle', 800000),
('Operations', 'Austin', 600000),
('Sales', 'Boston', 900000),
('Legal', 'Los Angeles', 650000),
('Research', 'Denver', 1200000),
('Support', 'Phoenix', 450000),
('Logistics', 'Miami', 700000);

-- Insert sample data into Roles table
INSERT INTO Roles (Role_Name, DeptID)
VALUES 
('Manager', 1),
('Analyst', 2),
('Developer', 3),
('Consultant', 4),
('Specialist', 5),
('Technician', 6),
('Coordinator', 7),
('Engineer', 8),
('Assistant', 9),
('Supervisor', 10);

-- Insert sample data into Employee table
INSERT INTO Employee (DeptID, Employee_FName, Employee_LName, Employee_Email)
VALUES 
(1, 'John', 'Doe', 'john.doe@company.com'),
(2, 'Jane', 'Smith', 'jane.smith@company.com'),
(3, 'Mike', 'Johnson', 'mike.johnson@company.com'),
(4, 'Sarah', 'Williams', 'sarah.williams@company.com'),
(5, 'Chris', 'Brown', 'chris.brown@company.com'),
(6, 'Pat', 'Taylor', 'pat.taylor@company.com'),
(7, 'Kelly', 'Miller', 'kelly.miller@company.com'),
(8, 'Alex', 'Davis', 'alex.davis@company.com'),
(9, 'Jordan', 'Martinez', 'jordan.martinez@company.com'),
(10, 'Taylor', 'Garcia', 'taylor.garcia@company.com');

-- Insert sample data into Referral table
INSERT INTO Referral (Employee_ID, Relation_Type, Referral_Date)
VALUES 
(1, 'Friend', '2022-01-10'),
(2, 'Colleague', '2022-02-15'),
(3, 'Family', '2022-03-20'),
(4, 'Friend', '2022-04-25'),
(5, 'Colleague', '2022-05-30'),
(6, 'Family', '2022-06-05'),
(7, 'Friend', '2022-07-10'),
(8, 'Colleague', '2022-08-15'),
(9, 'Family', '2022-09-20'),
(10, 'Friend', '2022-10-25');

-- Insert sample data into Job_Posting table
INSERT INTO Job_Posting (DeptID, Deadline_Date, Location, Job_Title)
VALUES 
(1, '2023-01-10', 'New York', 'HR Manager'),
(2, '2023-02-15', 'San Francisco', 'IT Analyst'),
(3, '2023-03-20', 'Chicago', 'Marketing Specialist'),
(4, '2023-04-25', 'Seattle', 'Finance Consultant'),
(5, '2023-05-30', 'Austin', 'Operations Coordinator'),
(6, '2023-06-05', 'Boston', 'Sales Representative'),
(7, '2023-07-10', 'Los Angeles', 'Legal Advisor'),
(8, '2023-08-15', 'Denver', 'Research Scientist'),
(9, '2023-09-20', 'Phoenix', 'Support Technician'),
(10, '2023-10-25', 'Miami', 'Logistics Supervisor');

-- Insert sample data into Interview table
INSERT INTO Interview (Employee_ID, Interview_Type)
VALUES 
(1, 'Phone'),
(2, 'Onsite'),
(3, 'Technical'),
(4, 'HR'),
(5, 'Phone'),
(6, 'Onsite'),
(7, 'Technical'),
(8, 'HR'),
(9, 'Phone'),
(10, 'Onsite');

-- Insert sample data into Candidate table
INSERT INTO Candidate (Candidate_FName, Candidate_LName, Candidate_Phone_No, Candidate_EmailID, Referral_ID, Interview_ID, Date_of_Birth, Gender)
VALUES 
('Alice', 'Johnson', '1234567890', 'alice.johnson@example.com', 1, 1, '1990-01-01', 'F'),
('Bob', 'Smith', '0987654321', 'bob.smith@example.com', 2, 2, '1991-02-02', 'M'),
('Carol', 'Williams', '2345678901', 'carol.williams@example.com', 3, 3, '1992-03-03', 'F'),
('David', 'Brown', '3456789012', 'david.brown@example.com', 4, 4, '1993-04-04', 'M'),
('Eve', 'Taylor', '4567890123', 'eve.taylor@example.com', 5, 5, '1994-05-05', 'F'),
('Frank', 'Garcia', '5678901234', 'frank.garcia@example.com', 6, 6, '1995-06-06', 'M'),
('Grace', 'Martinez', '6789012345', 'grace.martinez@example.com', 7, 7, '1996-07-07', 'F'),
('Hank', 'Davis', '7890123456', 'hank.davis@example.com', 8, 8, '1997-08-08', 'M'),
('Ivy', 'Martinez', '8901234567', 'ivy.martinez@example.com', 9, 9, '1998-09-09', 'F'),
('Jack', 'Wilson', '9012345678', 'jack.wilson@example.com', 10, 10, '1999-10-10', 'M');

-- Insert sample data into Job_Application table
INSERT INTO Job_Application (Candidate_ID)
VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insert sample data into Interview_Schedule table
INSERT INTO Interview_Schedule (Application_ID, Interview_ID, Date_of_Interview)
VALUES 
(1, 1, '2023-11-01'),
(2, 2, '2023-11-02'),
(3, 3, '2023-11-03'),
(4, 4, '2023-11-04'),
(5, 5, '2023-11-05'),
(6, 6, '2023-11-06'),
(7, 7, '2023-11-07'),
(8, 8, '2023-11-08'),
(9, 9, '2023-11-09'),
(10, 10, '2023-11-10');

-- Insert sample data into Job_Posting_Requirement table
INSERT INTO Job_Posting_Requirement (Job_ID, Application_ID, Experience, Education_Level)
VALUES 
(1, 1, 5, 'Bachelor'),
(2, 2, 3, 'Master'),
(3, 3, 2, 'PhD'),
(4, 4, 4, 'Bachelor'),
(5, 5, 6, 'Master'),
(6, 6, 1, 'Bachelor'),
(7, 7, 3, 'Master'),
(8, 8, 5, 'PhD'),
(9, 9, 2, 'Bachelor'),
(10, 10, 4, 'Master');

-- Insert sample data into Offer table
INSERT INTO Offer (Candidate_ID, Joining_Date, Offer_Status)
VALUES 
(1, '2024-01-01', 'Accepted'),
(2, '2024-02-01', 'Pending'),
(3, '2024-03-01', 'Rejected'),
(4, '2024-04-01', 'Accepted'),
(5, '2024-05-01', 'Pending'),
(6, '2024-06-01', 'Rejected'),
(7, '2024-07-01', 'Accepted'),
(8, '2024-08-01', 'Pending'),
(9, '2024-09-01', 'Rejected'),
(10, '2024-10-01', 'Accepted');

-- Insert sample data into Skill_Test table
INSERT INTO Skill_Test (Job_ID, Assessment_Date, Candidate_ID, Score)
VALUES 
(1, '2023-10-01', 1, 85.5),
(2, '2023-10-02', 2, 78.3),
(3, '2023-10-03', 3, 91.4),
(4, '2023-10-04', 4, 69.9),
(5, '2023-10-05', 5, 74.2),
(6, '2023-10-06', 6, 88.8),
(7, '2023-10-07', 7, 95.0),
(8, '2023-10-08', 8, 82.6),
(9, '2023-10-09', 9, 77.1),
(10, '2023-10-10', 10, 90.0);

-- Insert sample data into Shortlisted_Candidate table
INSERT INTO Shortlisted_Candidate (Offer_ID, Interview_ID, Shortlist_Date)
VALUES 
(1, 1, '2023-11-01'),
(2, 2, '2023-11-02'),
(3, 3, '2023-11-03'),
(4, 4, '2023-11-04'),
(5, 5, '2023-11-05'),
(6, 6, '2023-11-06'),
(7, 7, '2023-11-07'),
(8, 8, '2023-11-08'),
(9, 9, '2023-11-09'),
(10, 10, '2023-11-10');


SELECT * FROM Department;
SELECT * FROM Roles;
SELECT * FROM Employee;
SELECT * FROM Referral;
SELECT * FROM Candidate;
SELECT * FROM Job_Posting;
SELECT * FROM Job_Application;
SELECT * FROM Interview;
SELECT * FROM Interview_Schedule;
SELECT * FROM Job_Posting_Requirement;
SELECT * FROM Offer;
SELECT * FROM Skill_Test;
SELECT * FROM Shortlisted_Candidate;