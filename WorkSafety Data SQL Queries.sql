/*Writing SQL Queries on Workplace Safety Dataset*/

SELECT * 
FROM [dbo].['Workplace Safety$'];

-- 1. How many incidents occurred at each plant?
SELECT Plant, 
			COUNT([Incident Type]) AS Incident_Type_Count
			FROM [dbo].['Workplace Safety$']
			GROUP BY Plant;

--2. What is the total incident cost per department?
SELECT Department, 
				SUM([Incident Cost]) AS TOTAL_INCIDENT_COST
				FROM [dbo].['Workplace Safety$']
				GROUP BY Department;

--OR USING WINDOW FUNCTION CALLED OVER() AND PARTITION BY AND I CAN DECIDED TO ORDER BY 

SELECT *, 
		SUM([Incident Cost]) OVER(PARTITION BY Department ORDER BY Plant) AS TOTAL_INCIDENT_COST
		FROM [dbo].['Workplace Safety$'];
-- partition by department but order by plants in the department

--OR 
SELECT Department, 
		SUM([Incident Cost]) OVER(PARTITION BY Department) AS TOTAL_INCIDENT_COST
		FROM [dbo].['Workplace Safety$'];

--3. Which incident type resulted in the highest total days lost?
SELECT TOP 1 [Incident Type], 
		SUM([Days Lost]) AS TOTAL_DAYS_LOST
		FROM [dbo].['Workplace Safety$']
		GROUP BY [Incident Type]
		ORDER BY SUM([Days Lost]) DESC ;

--or 

/*SELECT [Incident Type], 
		SUM([Days Lost]) AS TOTAL_DAYS_LOST
		FROM [dbo].['Workplace Safety$']
		GROUP BY [Incident Type]
		ORDER BY TOTAL_DAYS_LOST DESC;*/


--4. What is the distribution of incident types by shift?
SELECT [Incident Type], [Shift], 
		COUNT([Incident Type]) AS [Dist. Of Incident Types by Shift]
		FROM [dbo].['Workplace Safety$']
		GROUP BY [INCIDENT TYPE],[Shift] ;
/*--OR USING WINDOW FUNCTION
SELECT [Incident Type], [Shift],
COUNT([Incident Type]) OVER(PARTITION BY [Incident Type],[Shift]) AS [Dist. Of Incident Types by Shift]
FROM [dbo].['Workplace Safety$'];*/

--Percentage Distribution Included and Using Window Function
SELECT 
    [Incident Type], 
    [Shift], 
    COUNT(*) AS [Incident_Count],
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY [Incident Type]), 2) AS [Percentage_By_Incident_Type]
	FROM [dbo].['Workplace Safety$']
	GROUP BY [Incident Type], [Shift];

--5. What is the average incident cost for each injury location?
SELECT [Injury Location], 
		AVG([Incident Cost]) AS [AVG_INCIDENT COST BY INJURY LOCATION]
		FROM [dbo].['Workplace Safety$']
		GROUP BY [Injury Location]
--ORDER BY [AVG_INCIDENT COST BY INJURY LOCATION] DESC;

--OR USING WINDOW FUNCTION
SELECT [Injury Location], 
		AVG([Incident Cost]) OVER(PARTITION BY [Injury Location]) AS [AVG_INCIDENT COST BY INJURY LOCATION]
		FROM [dbo].['Workplace Safety$'];

--6. Which age group has the highest number of incidents?
SELECT TOP 1 [Age Group], Count([Incident Type]) AS [COUNT OF INCIDENT]
		FROM [dbo].['Workplace Safety$']
		GROUP BY [Age Group]
		ORDER BY [COUNT OF INCIDENT] DESC;

--7. How many incidents were reported as 'Lost Time' by each plant?
SELECT [Report Type], 
		Plant,
		COUNT([Incident Type]) AS [COUNT OF INCIDENT TYPE]
		FROM [dbo].['Workplace Safety$']
		WHERE [Report Type] = 'Lost Time'
		GROUP BY [Report Type], Plant;

--8. Which department had the highest number of 'Crush & Pinch' incidents?
SELECT Department, 
		[Incident Type], 
		COUNT([Incident Type])  AS COUNT_of_Incident
		FROM [dbo].['Workplace Safety$']
		WHERE [Incident Type] = 'Crush & Pinch'
		GROUP BY Department, [Incident Type]
		ORDER  BY COUNT_of_Incident DESC;

--9. Which plants reported the most "Near Miss" incidents?
SELECT Plant,
		[Report Type],
		COUNT([Report Type]) AS Count_Of_ReportType
		FROM [dbo].['Workplace Safety$']
		WHERE [Report Type] IN 
							(Select [Report Type] FROM [dbo].['Workplace Safety$'] WHERE [Report Type] ='Near Miss') --SUBQUERY
		GROUP BY Plant, [Report Type]
		ORDER BY Count_Of_ReportType DESC;

--10. What is the total number of incidents by year and month?
SELECT Year,
		MONTH, 
		COUNT([Incident Type]) AS Total_No_Incident
		FROM [dbo].['Workplace Safety$']
		GROUP BY Year, Month;

--11. Which gender has the most reported incidents?
SELECT Gender,
		COUNT([Incident Type]) AS Most_reported_Incident
		FROM [dbo].['Workplace Safety$']
		GROUP BY Gender;

--12. What is the total cost of incidents per year?
SELECT Year, 
		SUM([Incident cost]) AS TOTAL_COST_OF_INCIDENTPERYEAR
		FROM [dbo].['Workplace Safety$']
		GROUP BY Year;

--13. Which incident resulted in the highest cost?
SELECT TOP 1 [Incident Type], 
       SUM([Incident Cost]) as Incident_Type_Cost
       FROM [dbo].['Workplace Safety$']
       GROUP BY [Incident Type]
       ORDER BY Incident_Type_Cost DESC;

--14. What is the total cost of incidents for each report type?
SELECT [Report Type], 
       SUM([Incident Cost]) AS TOTAL_COST_OF_INCIDENT
       FROM [dbo].['Workplace Safety$']
       GROUP BY [Report Type];

--15. Which departments had incidents with more than 2 days lost?
SELECT Department, 
		[Incident Type], [Days Lost]  
		FROM [dbo].['Workplace Safety$']
		WHERE [Days Lost] > 2;

--16. What is the average number of days lost per incident type?
SELECT [Incident Type], 
		ROUND(AVG([Days Lost]),2) as AVG_of_Days_Lost
		FROM [dbo].['Workplace Safety$']
		GROUP BY [Incident Type];

--17. What is the distribution of incidents by shift (Day, Afternoon, Night)?
SELECT [Incident Type], 
		[Shift], 
		COUNT([Incident Type]) AS CountOfIncidentType
		FROM [dbo].['Workplace Safety$']
		GROUP BY [Incident Type], [Shift];

--18. Which months have the highest number of incidents?
SELECT TOP 5 Month, 
			COUNT([Incident type]) AS Count_Of_Incidents
			FROM [dbo].['Workplace Safety$']
			GROUP BY Month
			ORDER BY Count_Of_Incidents DESC;

--19. What is the total cost of "Vehicle" related incidents?
SELECT [Incident Type], 
		SUM([Incident Cost]) as Total_CostOfVehicleRelatedIncident
		FROM [dbo].['Workplace Safety$']
		WHERE [Incident Type] = 'Vehicle'
		GROUP BY [Incident Type];

--20. Which age group is most affected by "Falling Object" incidents?
SELECT  [Age Group], --TOP 1 TO GET THE TOPMOST
		[Incident Type], 
		COUNT([Incident Type]) as Incident_Type
		FROM [dbo].['Workplace Safety$']
		WHERE [Incident Type] = 'Falling Object'
		GROUP BY [Age Group], [Incident Type]
		ORDER BY Incident_Type DESC;

