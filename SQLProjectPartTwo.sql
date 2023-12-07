/* ● Find a csv file on the internet containing a set of data, can be real or
mock data.
● Import the CSV into The ACC Store.
● Create a view to simplify and show any important information from the
table. */

USE ACC_Store
GO

DROP VIEW IF EXISTS PersonEmail
GO

CREATE VIEW PersonEmail AS
SELECT first_name AS 'First Name', last_name AS 'Last Name', email AS 'Email'
FROM MOCK_DATA
GO 

SELECT * FROM PersonEmail
GO

/* ● Create a stored procedure to clean up your data in some way. */

DROP PROCEDURE IF EXISTS CleanUpData
GO

CREATE PROCEDURE CleanUpData AS
BEGIN
SELECT * FROM MOCK_DATA
ORDER BY last_name
END
GO

EXECUTE dbo.CleanUpData
GO

/* ● Create a function that looks up an entry in the table. */

DROP FUNCTION IF EXISTS LookUpOneEntry
GO

CREATE FUNCTION LookUpOneEntry (@entry_id INT)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM MOCK_DATA
    WHERE id = @entry_id
);
GO

SELECT * FROM LookUpOneEntry(500)
GO