USE ACC_Store
GO

/* 1) Select statement that shows all store ID and Name, their addresses and
the manager’s name */
SELECT ST.Store_ID, ST.Store_Name, 
ST.Address1, ST.Address2, ST.City, ST.State_CD, ST.Zip_code, ST.Zip_Ext,
EM.First_Name, EM.MI, EM.Last_Name
FROM Store AS ST
JOIN Employee AS EM
ON ST.Manager_ID = EM.Emp_ID
GO

/* 2) Select statement that shows all managers, the manager’s address and
their store name */
SELECT EM.Emp_ID, EM.First_Name, EM.MI, EM.Last_Name,
EM.Address1, EM.Address2, EM.City, EM.State_CD, EM.Zip_code, EM.Zip_Ext,
ST.Store_Name
FROM Employee AS EM
JOIN Store AS ST
ON ST.Manager_ID = EM.Emp_ID
GO

/* 3) Create a view for #2 */
DROP VIEW IF EXISTS StoreManagers
GO

CREATE VIEW StoreManagers AS
SELECT EM.Emp_ID, EM.First_Name, EM.MI, EM.Last_Name,
EM.Address1, EM.Address2, EM.City, EM.State_CD, EM.Zip_code, EM.Zip_Ext,
ST.Store_Name
FROM Employee AS EM
JOIN Store AS ST
ON ST.Manager_ID = EM.Emp_ID
GO

/* 4) Create a stored procedure for #1 */
DROP PROCEDURE IF EXISTS StoreInfo
GO

CREATE PROCEDURE StoreInfo
AS
BEGIN
SELECT ST.Store_ID, ST.Store_Name, 
ST.Address1, ST.Address2, ST.City, ST.State_CD, ST.Zip_code, ST.Zip_Ext,
EM.First_Name, EM.MI, EM.Last_Name
FROM Store AS ST
JOIN Employee AS EM
ON ST.Manager_ID = EM.Emp_ID
END
GO

EXECUTE dbo.StoreInfo
GO

/* 5) Add non-clustered index on the products table by product name */
CREATE NONCLUSTERED INDEX IX_Product_Name
ON Product (Product_Name);
GO

/* 6) Create a SELECT Statement in a STORED PROCEDURE that returns:
a. All Active Stores
b. Manager First and Last Name for the store
c. Product Name
d. Quantity of Products per Store */
DROP PROCEDURE IF EXISTS ActiveStores
GO

CREATE PROCEDURE ActiveStores
AS
BEGIN
SELECT ST.Store_ID, ST.Store_Name, ST.Active_IND,
EM.First_Name, EM.Last_Name, PR.Product_Name, SK.Quantity
FROM Store AS ST
JOIN Employee AS EM
ON ST.Manager_ID = EM.Emp_ID
JOIN Product AS PR
ON PR.Active_IND = ST.Active_IND
JOIN Stock AS SK
ON PR.Product_ID = SK.Product_ID
WHERE ST.Active_IND = 1
END
GO

EXECUTE dbo.ActiveStores
GO