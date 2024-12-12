-- Add new columns to store encrypted data

ALTER TABLE employee 
ADD
	EncryptedEmpFirstName VARBINARY(256),
    EncryptedEmpLastName VARBINARY(256);
    
GO
select * from Employee
-- Step 1: Create a certificate to protect the symmetric key
CREATE CERTIFICATE EmpCert
WITH SUBJECT = 'Employee Data Encryption';
GO

-- Create a master key for encryption
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DMDD1234!';
GO

-- Step 2: Create a symmetric key using AES_256 encryption, protected by the certificate
CREATE SYMMETRIC KEY EmpDataKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE EmpCert;

-- Step 3: Open the symmetric key to use it for encryption
OPEN SYMMETRIC KEY EmpDataKey
DECRYPTION BY CERTIFICATE EmpCert;

-- Step 4: Encrypt employee first and last names and store the results
UPDATE employee
SET EncryptedEmpFirstName = EncryptByKey(Key_GUID('EmpDataKey'), Employee_FName),
    EncryptedEmpLastName = EncryptByKey(Key_GUID('EmpDataKey'), Employee_LName)
select * from Employee;

-- Step 5: Verify encryption (optional)
SELECT 
    Employee_ID,
    EncryptedEmpFirstName,
    EncryptedEmpLastName
FROM employee;
GO

CREATE FUNCTION dbo.DecryptEmployeeData1 
(
    @encrypted_data VARBINARY(256)
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @decrypted_data VARCHAR(50)
    
    SELECT @decrypted_data = 
        CONVERT(VARCHAR(50), 
            DecryptByKey(@encrypted_data))
    
    RETURN @decrypted_data
END;

-- Step 7: Decrypt and retrieve employee data
-- Open the symmetric key again, as it needs to be open to decrypt the data
OPEN SYMMETRIC KEY EmpDataKey
DECRYPTION BY CERTIFICATE EmpCert;
GO

SELECT 
    Employee_ID,
    dbo.DecryptEmployeeData1(EncryptedEmpFirstName) AS Decrypted_FirstName,
    dbo.DecryptEmployeeData1(EncryptedEmpLastName) AS Decrypted_LastName
FROM employee;

-- Step 8: Close the symmetric key after use
CLOSE SYMMETRIC KEY EmpDataKey;