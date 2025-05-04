--WRITING SQL QUERIES ON EMPLOYEES DATA
/*In the analysis of the Employees Dataset, I analyzed employee data from four different tables using SQL data manipulation language, 
Employees' Salary, Employees' Position, and Employees' Details tables.which includes the Employees' Information.*/


SELECT * 
FROM [dbo].[Employee_Details$];

UPDATE [dbo].[Employee_Details$]
SET [DateOfJoining] = '01/31/2019'
WHERE EmpId = '121';

UPDATE [dbo].[Employee_Details$]
SET [DateOfJoining] = '01/30/2020'
WHERE EmpId = 321;


--Alter Statement to Alter the Dataypes.
ALTER TABLE [dbo].[Employee_Details$]
ALTER COLUMN EmpId INT

ALTER TABLE [dbo].[Employee_Details$]
ALTER COLUMN FullName VARCHAR(255)

ALTER TABLE [dbo].[Employee_Details$]
ALTER COLUMN ManagerId INT

ALTER TABLE [dbo].[Employee_Details$]
ALTER COLUMN DateOfJoining Date

ALTER TABLE [dbo].[Employee_Details$]
ALTER COLUMN City VARCHAR(255)


--1.Writing an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’.
SELECT EmpId, FullName 
FROM [dbo].[Employee_Details$]
WHERE ManagerId = 986;

--2. Writing an SQL query to fetch the different projects available from the EmployeeSalary table.
SELECT DISTINCT(Project)
FROM [dbo].[Employee_Salary$];


--3. Writing an SQL query to fetch the count of employees working in project ‘P1’.
SELECT COUNT(EmpId) 
FROM [dbo].[Employee_Salary$]
WHERE Project = 'P1';

--4. Writing an SQL query to find the maximum, minimum, and average salary of the employees.
SELECT MIN(Salary) AS Minimum_Salary 
FROM [dbo].[Employee_Salary$];

SELECT MAX(Salary) AS Maximum_Salary 
FROM [dbo].[Employee_Salary$];

SELECT AVG(Salary) AS Average_Salary 
FROM [dbo].[Employee_Salary$];

--5. Writing an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.
SELECT EmpId
FROM [dbo].[Employee_Salary$]
WHERE Salary BETWEEN 9000 AND 15000;

--6. Writing an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.
SELECT EmpId, 
       FullName, 
       ManagerId, 
      City 
FROM [dbo].[Employee_Details$]
WHERE ManagerId= 321 AND City ='Toronto';

--7. Writing an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321.
SELECT EmpId, 
	FullName, 
	ManagerId, 
	City 
FROM [dbo].[Employee_Details$]
WHERE ManagerId= 321 OR City ='California';

--8. Write an SQL query to fetch all those employees who work on Projects other than P1.
SELECT * 
FROM [dbo].[Employee_Salary$]
WHERE Project != 'P1';

--9. Write an SQL query to display the total salary of each employee adding the Salary with Variable value.
SELECT *, 
      (Salary) + (Variable)  AS [Total Salary] 
FROM [dbo].[Employee_Salary$];

/*10. Write an SQL query to fetch the employees whose name begins with any two characters, 
followed by a text “hn” and ends with any sequence of characters.*/
--this wildcard, % representsplenty character while '_' underscore represents single character.
SELECT * 
FROM [dbo].[Employee_Details$]
WHERE FullName LIKE '__hn%';

/*11. Write an SQL query to fetch all the EmpIds which are present 'in either' of the tables
– ‘EmployeeDetails’ and ‘EmployeeSalary’.*/ --EITHER IN MEANS FULL OUTER JOIN

SELECT D.EmpId,
       S.EmpId FROM 
       [dbo].[Employee_Details$] AS D
FULL OUTER JOIN
       [dbo].[Employee_Salary$] AS S 
ON D.EmpId = S.EmpId;


/*SELECT * 
FROM [dbo].[Employee_Details$] AS D
FULL OUTER JOIN
[dbo].[Employee_Salary$] AS S 
ON D.EmpId = S.EmpId;*/

--12. Write a query to fetch the EmpFname from the EmployeeInfo table in the upper case and use the ALIAS name as EmpName.
SELECT UPPER(EmpFname) AS EmpName 
FROM [dbo].['Employee Info$'];

--13. Write a query to fetch the number of employees working in the department ‘HR’.
SELECT COUNT(Department) AS [EmployeesInHR] 
FROM [dbo].['Employee Info$']
WHERE Department = 'HR';

--14. Write a query to get the current date.
SELECT GETDATE()

--15. Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.
SELECT LEFT(EmpLname, 4) AS FirstFourEmpLnameChars
FROM [dbo].['Employee Info$'];

--16. Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.
SELECT LEFT(Address, LEN(Address)-5) AS [ADDRESS] 
FROM [dbo].['Employee Info$'];

/*SELECT RIGHT(Address, 5) AS [ADDRESS] 
FROM [dbo].['Employee Info$'];*/

--SELECT LEN(Address) FROM [dbo].['Employee Info$'];

--17. Write a query to create a new table that consists of data and structure copied from the other table.
SELECT * INTO EMPLOYEEINFORMATION1
FROM [dbo].['Employee Info$'];

SELECT * 
FROM EMPLOYEEINFORMATION1;

--IF YOU DON'T WANT TO COPY THE DATA BUT JUST THE TABLE WRITE THE BELOW;
SELECT * INTO EMPLOYEEINFORMATION2
FROM [dbo].['Employee Info$']
WHERE 1 = 0;

SELECT * FROM EMPLOYEEINFORMATION2;

--18. Write a query to find all the employees whose salary is between 50000 to 100000.
SELECT *
FROM [dbo].['Employee position$']
WHERE Salary BETWEEN 50000 AND 100000;
--OR Another way to write this, is using the Full Outer Join Statement in SQL.

SELECT I.EmpID, 
       I.EmpFname, 
       I.EmpLname,
       P.Salary 
FROM [dbo].['Employee Info$'] AS I
FULL OUTER JOIN [dbo].['Employee position$'] AS P
ON I.EmpID = P.EmpID
WHERE Salary BETWEEN 50000 AND 100000;


--19. Write a query to find the names of employees that begin with ‘S’
SELECT * 
FROM [dbo].['Employee Info$'] 
WHERE EmpFname Like 'S%';

--20. Write a query to fetch top N records.
SELECT TOP 3 *
FROM [dbo].['Employee Info$'];

SELECT TOP 3 * 
FROM [dbo].['Employee position$'];

--21. Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space.
SELECT EmpID, 
		CONCAT(EmpFname, ' ', EmpLname) AS FullName, 
		Department, 
		Project, 
		Address, 
		DOB, 
		Gender 
FROM  [dbo].['Employee Info$'];

--22. Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1995 and are grouped according to gender
SELECT COUNT(EmpID) AS [CountOfEmployees], 
		Gender 
FROM [dbo].['Employee Info$']
WHERE DOB between '1970-05-02' AND '1995-12-31'
GROUP BY Gender;


SELECT * 
FROM [dbo].['Employee Info$'];

--23. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.
SELECT * 
FROM [dbo].['Employee Info$']
ORDER BY EmpLname DESC, Department;

--24. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.
SELECT *
FROM [dbo].['Employee Info$']
WHERE EmpLname Like '____A';

--25. Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.
SELECT * 
FROM [dbo].['Employee Info$']
WHERE EmpFname NOT IN ('Sanjay','Sonia');

--Write a query to fetch details of all employees including the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.
SELECT * 
FROM [dbo].['Employee Info$']
WHERE EmpFname IN ('Sanjay','Sonia');

--26. Write a query to fetch details of employees with the address as “DELHI(DEL)”
SELECT * 
FROM [dbo].['Employee Info$']
WHERE Address = 'Delhi(DEL)';

--27. Write a query to fetch all employees who also hold the managerial position.
SELECT * 
from [dbo].['Employee Info$'] AS I
LEFT JOIN [dbo].['Employee position$'] AS P
ON I.EmpID = P.EmpID
WHERE EmpPosition = 'Manager';


/*SELECT * 
from [dbo].['Employee Info$'] AS I
FULL OUTER JOIN [dbo].['Employee position$'] AS P
ON I.EmpID = P.EmpID
WHERE EmpPosition = 'Manager';*/


--28. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order
SELECT COUNT(EmpID) AS CountOfEmployee, 
		Department 
FROM [dbo].['Employee Info$']
GROUP BY Department
Order by Department;

--29.. Write a query to fecth Male employees in HR department
SELECT *
FROM [dbo].['Employee Info$']
WHERE Gender = 'M' AND Department = 'HR';

--30. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table
SELECT * FROM ['Employee Info$'] 
WHERE EmpID IN 
		(SELECT DISTINCT(EmpID) FROM ['Employee position$']);

--31. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table
-- Two minimum salaries
SELECT TOP (2) Salary FROM  [dbo].['Employee position$'] ORDER BY SALARY ASC

-- Two maximum salaries
SELECT TOP (2) Salary FROM  [dbo].['Employee position$']
ORDER BY SALARY DESC;

--TO GET THE ABOVE IN ONE TABLE
with CTE_Low AS
		(select *

			,RANK() OVER (ORDER BY Salary asc) as Low_Salary

			,RANK() OVER (ORDER BY Salary DESC) as High_Salary

			FROM [dbo].['Employee position$']

			)
SELECT [EmpID]

      ,[EmpPosition]

      ,[DateOfJoining]

      ,[Salary]

FROM CTE_Low

WHERE Low_Salary <=2
 
union
 
SELECT [EmpID]

      ,[EmpPosition]

      ,[DateOfJoining]

      ,[Salary]

FROM CTE_Low

WHERE High_Salary <=2
 
/*-- This is to delete the null values in all column, Use AND and OR can be use in either of the column
DELETE FROM [dbo].['Employee position$']
WHERE EmpID IS NULL AND EmpPosition IS NULL AND DateOfJoining IS NULL AND Salary IS NULL;

DELETE FROM [dbo].['Employee Info$']
WHERE EmpID IS NULL AND EmpFname IS NULL AND EmpLname IS NULL AND Department IS NULL AND Project IS NULL 
AND Address IS NULL AND DOB IS NULL AND Gender IS NULL;
*/







