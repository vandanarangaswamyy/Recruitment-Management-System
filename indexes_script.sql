-- NON CLUSTERED INDICES
-- 1.	Non-Clustered Index on Candidate_EmailID in Candidate Table
CREATE NONCLUSTERED INDEX IDX_Candidate_EmailID
ON Candidate (Candidate_EmailID);

-- 2.	Non-Clustered Index on Job_ID in Job_Posting_Requirement Table
CREATE NONCLUSTERED INDEX IDX_Job_Posting_Requirement_JobID
ON Job_Posting_Requirement (Job_ID);

-- 3.	Non- Clustered Index on Date_of_Interview in Interview_Schedule Table
CREATE NONCLUSTERED INDEX IDX_Interview_Schedule_Date
ON Interview_Schedule (Date_of_Interview);

-- View all indices in the database
SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    i.is_unique AS IsUnique,
    i.is_primary_key AS IsPrimaryKey
FROM 
    sys.indexes i
JOIN 
    sys.tables t ON i.object_id = t.object_id
WHERE 
    i.type > 0 -- Exclude heaps (type = 0)
ORDER BY 
    t.name, i.name;

-- View Index Columns for a Specific Table
SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    c.name AS ColumnName,
    ic.key_ordinal AS KeyOrdinal,
    ic.is_included_column AS IsIncluded
FROM 
    sys.indexes i
JOIN 
    sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN 
    sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN 
    sys.tables t ON i.object_id = t.object_id
WHERE 
    t.name = 'Candidate' 
ORDER BY 
    i.name, ic.key_ordinal;

-- Dynamic Management Views (DMVs)
-- To analyze index usage and performance, use DMVs like sys.dm_db_index_usage_stats:
-- View Index Usage Statistics
SELECT 
    OBJECT_NAME(s.object_id) AS TableName,
    i.name AS IndexName,
    s.user_seeks AS UserSeeks,
    s.user_scans AS UserScans,
    s.user_lookups AS UserLookups,
    s.user_updates AS UserUpdates
FROM 
    sys.dm_db_index_usage_stats s
JOIN 
    sys.indexes i ON s.object_id = i.object_id AND s.index_id = i.index_id
WHERE 
    OBJECTPROPERTY(s.object_id, 'IsUserTable') = 1
ORDER BY 
    UserSeeks DESC;

-- Candidate_EmailID Index:
SELECT Candidate_FName, Candidate_LName
FROM Candidate
WHERE Candidate_EmailID = 'tombaker@example.com';

-- Job_ID Index:
SELECT *
FROM Job_Posting_Requirement
WHERE Job_ID = 1;

-- Date_of_Interview Index:
SELECT Application_ID, Interview_ID
FROM Interview_Schedule
WHERE Date_of_Interview = '2024-02-10';
