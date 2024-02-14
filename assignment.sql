-- Create EmployeeDetail table query

CREATE TABLE `employeedetails` (
  `EmpId` int NOT NULL,
  `FullName` varchar(45) NOT NULL,
  `ManagerId` int unsigned DEFAULT NULL,
  `DateOfJoining` date NOT NULL,
  `City` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create EmployeeSalary table query

CREATE TABLE `employeesalary` (
  `EmpId` int NOT NULL,
  `Project` varchar(45) DEFAULT NULL,
  `Salary` varchar(45) NOT NULL,
  `Variable` varchar(45) NOT NULL,
  PRIMARY KEY (`EmpId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




-- 1. SQL Query to fetch records that are present in one table but not in another table:

SELECT * FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary);

-- 2. SQL query to fetch all the employees who are not working on any project:

SELECT ed.*
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es ON ed.EmpId = es.EmpId
WHERE es.Project IS NULL;

-- 3. SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020:

SELECT * FROM EmployeeDetails
WHERE DATE_FORMAT(DateOfJoining, '%Y') = '2020';

-- 4. Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary:

SELECT * FROM EmployeeDetails
WHERE EmpId IN (SELECT EmpId FROM EmployeeSalary);

-- 5. Write an SQL query to fetch a project-wise count of employees:

SELECT Project, COUNT(*) AS EmployeeCount
FROM EmployeeSalary
WHERE Project IS NOT NULL
GROUP BY Project;

-- 6. Fetch employee names and salaries even if the salary value is not present for the employee.

SELECT ED.FullName, COALESCE(ES.Salary, 'Salary not available') AS Salary
FROM EmployeeDetails ED
LEFT JOIN EmployeeSalary ES ON ED.EmpId = ES.EmpId;

-- 7. Write an SQL query to fetch all the Employees who are also managers.

SELECT * FROM EmployeeDetails
WHERE ManagerId IS NOT NULL;

-- 8. Write an SQL query to fetch duplicate records from EmployeeDetails.

SELECT EmpId, COUNT(*) AS DuplicateCount
FROM EmployeeDetails
GROUP BY EmpId
HAVING COUNT(*) > 1;

-- 9. Write an SQL query to fetch only odd rows from the table.

SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY EmpId) AS RowNum
  FROM EmployeeDetails
) AS EmployeeWithRowNum
WHERE RowNum % 2 = 1;

-- 10. Write a query to find the 3rd highest salary from a table without top or limit keyword.

SELECT MIN(Salary) AS ThirdHighestSalary
FROM EmployeeSalary AS e1
WHERE 2 = (
    SELECT COUNT(DISTINCT Salary)
    FROM EmployeeSalary AS e2
    WHERE e2.Salary > e1.Salary
);