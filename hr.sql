/*
This file demonstrates Microsoft T-SQL commands crafted using Copilot.
*/

-- If database 'hr' exists, drop it
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'hr')
    DROP DATABASE hr;
GO

-- Create a new database named 'hr'
CREATE DATABASE hr;
GO

-- Use the database
USE hr;

/*
Create an 'HourlyEmployees' table with the following columns:
-- id: integer, primary key
-- HourlyRate: decimal (10, 2), not null
*/
CREATE TABLE HourlyEmployees (
    id INT PRIMARY KEY,
    HourlyRate DECIMAL(10, 2) NOT NULL
);

/*
Create a 'SalariedEmployees' table with the following columns:
-- id: integer, primary key
-- Salary: decimal (10, 2), not null
*/
CREATE TABLE SalariedEmployees (
    id INT PRIMARY KEY,
    Salary DECIMAL(10, 2) NOT NULL
);

/*
Create an 'Employees' table that forms a one-to-one relationship with 'HourlyEmployees' and 'SalariedEmployees' tables. Strict referential integrity must be enforced.
-- id: integer, primary key
-- Name: 50 characters, not null
-- HourlyEmployeeId: integer, unique, foreign key references HourlyEmployees(id)
-- SalariedEmployeeId: integer, unique, foreign key references SalariedEmployees(id)
*/
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    HourlyEmployeeId INT UNIQUE,
    SalariedEmployeeId INT UNIQUE,
    FOREIGN KEY (HourlyEmployeeId) REFERENCES HourlyEmployees(id),
    FOREIGN KEY (SalariedEmployeeId) REFERENCES SalariedEmployees(id)
);

/*
Create a stored procedure named 'GetEmployeeDetails' that returns the id, hourly rate, and department name of hourly employees.
*/
CREATE PROCEDURE GetEmployeeDetails
AS
BEGIN
    SELECT HourlyEmployees.id, HourlyEmployees.HourlyRate, 'Hourly' AS Department
    FROM HourlyEmployees
    JOIN Employees ON HourlyEmployees.id = Employees.HourlyEmployeeId;
END;