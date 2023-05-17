create database sqlAssignment;
use sqlAssignment;

--Create two tables: EmployeeDetails and EmployeeSalary.
--Columns for EmployeeDetails: EmpId FullName ManagerId DateOfJoining City && Columns for EmployeeSalary: : EmpId Project Salary Variable.Insert some sample data into both tables

-- create EmployeeDetails table
CREATE TABLE EmployeeDetails (
  EmpId INT NOT NULL PRIMARY KEY,
  FullName KANAK NOT NULL,
  ManagerId INT,
  DateOfJoining DATE,
  City SURAT
);

-- insert sample data into EmployeeDetails
INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES (1, 'Kanak', NULL, '2022-02-01', 'Surat'),
       (2, 'Kruti', 1, '2006-12-24', 'Jamnagar'),
       (3, 'Aryan', 1, '2012-02-15', 'Junagadh'),
       (4, 'Meet', 1, '2021-12-16', 'Surat');


 -- create EmployeeDetails table      
    CREATE TABLE EmployeeSalary (
  EmpId INT NOT NULL,
  Project VARCHAR(255) NOT NULL,
  Salary DECIMAL(10, 2) NOT NULL,
  Variable DECIMAL(10, 2),
  PRIMARY KEY (EmpId, Project),
  FOREIGN KEY (EmpId) REFERENCES EmployeeDetails(EmpId)
);

-- insert sample data into EmployeeSalary
INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES (1, 'Project A', 8000.00, 900.00),
       (1, 'Project B', 5500.00, 800.00),
       (2, 'Project A', 6500.00, 1500.00),
       (2, 'Project C', 5000.00, 1000.00),
       (3, 'Project B', 4000.00, 600.00);

--1.SQL Query to fetch records that are present in one table but not in another table.
SELECT EmployeeDetails.*
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId
WHERE EmployeeSalary.EmpId IS NULL;

--2 SQL query to fetch all the employees who are not working on any project.
SELECT *
FROM EmployeeDetails
WHERE EmpId NOT IN (
  SELECT EmpId
  FROM EmployeeSalary
)
--3.SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2021.
SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2021

--4.Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.
SELECT ed.*
FROM EmployeeDetails ed
INNER JOIN EmployeeSalary es
  ON ed.EmpId = es.EmpId

--5.Write an SQL query to fetch a project-wise count of employees.
SELECT Project, COUNT(EmpId) as NumEmployees
FROM EmployeeSalary
GROUP BY Project

--6.Fetch employee names and salaries even if the salary value is not present for the employee.
SELECT ed.FullName, es.Salary
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es
  ON ed.EmpId = es.EmpId

--7.Write an SQL query to fetch all the Employees who are also managers.
SELECT e1.*
FROM EmployeeDetails e1
INNER JOIN EmployeeDetails e2
  ON e1.EmpId = e2.ManagerId
  
--8.Write an SQL query to fetch duplicate records from EmployeeDetails.
SELECT FullName, ManagerId, DateOfJoining, City, COUNT(*)
FROM EmployeeDetails
GROUP BY FullName, ManagerId, DateOfJoining, City
HAVING COUNT(*) > 1

--9.Write an SQL query to fetch only odd rows from the table.
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY EmpId) AS RowNum
  FROM EmployeeDetails
) AS T
WHERE T.RowNum % 2 = 1

--10.Write a query to find the 3rd highest salary from a table without top or limit keyword.
SELECT DISTINCT Salary
FROM EmployeeSalary e1
WHERE 3 = (
  SELECT COUNT(DISTINCT Salary)
  FROM EmployeeSalary e2
  WHERE e2.Salary > e1.Salary
);
