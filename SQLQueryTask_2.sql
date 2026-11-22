--Create a table named "Employees" with columns for ID (integer), Name (varchar), and Salary (decimal).
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    salary decimal
);

--Add a new column named "Department" to the "Employees" table with data type varchar(50).
Alter TABLE Employees
add Department VARCHAR(50);

--Remove the "Salary" column from the "Employees" table.
ALTER TABLE Employees
DROP COLUMN Salary;

--Rename the "Department" column in the "Employees" table to "DeptName".
EXEC sp_rename 'Employees.Department', 'DeptName', 'COLUMN';

--Create a new table called "Projects" with columns for ProjectID (integer) and ProjectName (varchar).
CREATE TABLE Projects (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(20)
);

--Create a foreign key relationship between the "Employees" table (referencing "ID") and the "Projects" table (referencing "ProjectID").
ALTER TABLE Employees
ADD ProjectID INT;

ALTER TABLE Employees
ADD CONSTRAINT Employees_Projects
FOREIGN KEY (ProjectID)
REFERENCES Projects(ProjectID);

--Remove the foreign key relationship between "Employees" and "Projects."
ALTER TABLE Employees
DROP CONSTRAINT Employees_Projects;

--Add a unique constraint to the "Name" column in the "Employees" table.
ALTER TABLE Employees
ADD CONSTRAINT Employees_Name
UNIQUE (Name);

--Create a table named "Customers" with columns for CustomerID (integer), FirstName (varchar), LastName (varchar), and Email (varchar), and Status (varchar).
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Status VARCHAR(20)
);

--Add a unique constraint to the combination of "FirstName" and "LastName" columns in the "Customers" table.
ALTER TABLE Customers
ADD CONSTRAINT Customers_FName_lName
UNIQUE (FirstName, LastName);

--Add a default value of 'Active' for the "Status" column in the "Customers" table, where the default value should be applied when a new record is inserted.
ALTER TABLE Customers
ADD CONSTRAINT Customers_Status
DEFAULT 'Active' FOR Status;

--Create a table named "Orders" with columns for OrderID (integer), CustomerID (integer), OrderDate (datetime), and TotalAmount (decimal).
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2)
);

--Add a check constraint to the "TotalAmount" column in the "Orders" table to ensure that it is greater than zero.
ALTER TABLE Orders
ADD CONSTRAINT Orders_TotalAmount
CHECK (TotalAmount > 0);

--Create a schema named "Sales" and move the "Orders" table into this schema.
go
CREATE SCHEMA Sales;
go

ALTER SCHEMA Sales
TRANSFER dbo.Orders;

--Rename the "Orders" table to "SalesOrders."
EXEC sp_rename 'Sales.Orders', 'SalesOrders';

------------- Data Manipulation Questions: -----------------
--Select all columns from the "Employees" table.
select *
from Employees

--Select only the "Name" and "Salary" columns from the "Employees" table.
select 
name,
salary
from Employees

--Select distinct values of the "DeptName" column from the "Employees" table.
SELECT DISTINCT DeptName
FROM Employees;

--Select the top 5 records from the "Employees" table.
SELECT TOP (5) *
FROM Employees;

--Select all records from the "Employees" table, ordered by the "Salary" column in descending order.
SELECT *
FROM Employees
ORDER BY salary DESC;

--Select the first 10 records from the "Employees" table, starting from the third record.
SELECT *
FROM Employees
ORDER BY iD
OFFSET 2 ROWS
FETCH NEXT 10 ROWS ONLY;

--Select the average salary from the "Employees" table. (search on it)
SELECT AVG(salary)  AverageSalary
FROM Employees;

--Select the maximum and minimum salaries from the "Employees" table. (search on it)
SELECT
    MAX(salary)  MaximumSalary,
    MIN(salary)  MinimumSalary
FROM Employees;

--Select the top 3 highest salaries from the "Employees" table.
SELECT TOP (3) *
FROM Employees
ORDER BY salary DESC;

--Select all records from the "Employees" table, ordered by "Name" in ascending order.
SELECT *
FROM Employees
ORDER BY name ASC;

--Select the first 5 records from the "Employees" table, starting from the second record, ordered by "Salary" in descending order.
SELECT *
FROM Employees
ORDER BY salary DESC
OFFSET 1 ROW
FETCH NEXT 5 ROWS ONLY;

--Select the sum of all salaries from the "Employees" table. (search on it)
SELECT SUM(salary) TotalSalary
FROM Employees;

--Select records from the "Employees" table where the "Salary" is between 40000 and 60000, ordered by "Salary" in ascending order.
SELECT *
FROM Employees
WHERE salary BETWEEN 40000 AND 60000
ORDER BY salary ASC;