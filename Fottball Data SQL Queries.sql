/*Writing SQL Queries on Football Dataset*/
SELECT * 
FROM [dbo].['FOOTBALL PLAYERS$'];

--1. Write a query to find all the players in the "Arizona" team.
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Team='Arizona';

--2. Write a query to find all the players who play as a "WR" (Wide Receiver).
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Pos = 'WR';

--3. Write a query to list all players taller than 6 feet 2 inches.
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Ht='6-2';

--4. Write a query to find all players who attended the "Washington" college.
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE College='Washington';

--5. Write a query to list players who are 25 years old or younger.
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Age <='25';

--6. Write a query to find all players with missing Age data.
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Age = 'N/A';

--7. Write a query to find players who are rookies (Exp = 'R').
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Exp='R';

--8. Write a query to find the tallest player on the "New Orleans" team.
--Using a WINDOW FUNCTION IN SQL
SELECT *, 
		MAX(Ht) OVER() as [TallestPlayer] FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Team='New Orleans';

--OR
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Team='New Orleans' AND Ht='6-7';

--9. Write a query to find players weighing more than 250 pounds.
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Wt>250;

--10. Write a query to calculate the average height of players at each position.
--Using Window Function...
SELECT Pos, 
		AVG(Inches) OVER(PARTITION BY Pos) AS AVERAGE_HEIGHT_OF_PLAYERS
		FROM [dbo].['FOOTBALL PLAYERS$'];

/*SELECT *, 
		AVG(Inches) OVER(PARTITION BY Pos) AS AVERAGE_HEIGHT_OF_PLAYERS
		FROM [dbo].['FOOTBALL PLAYERS$'];*/

--11. Write a query to find the heaviest player for each position.
SELECT [NAME], 
		Pos, 
		MAX(Wt) OVER(PARTITION BY Pos)
		FROM [dbo].['FOOTBALL PLAYERS$'];

/*SELECT *, 
		MAX(Wt) over(PARTITION BY Pos) FROM [dbo].['FOOTBALL PLAYERS$']*/


--12. Write a query to rank players by age within their team. If two players have the same age, rank them by their weight.
SELECT *, 
		RANK() OVER(Order by Age, Wt) AS RANKING
		FROM [dbo].['FOOTBALL PLAYERS$']

--OR USING DENSE RANK ; This function returns the rank of each row within a result set partition, with no gaps in the ranking values.
SELECT *, 
		DENSE_RANK() OVER(Order by Age, Wt) AS RANKING
		FROM [dbo].['FOOTBALL PLAYERS$']

--13. Write a query to calculate the average height (in inches) for all players older than 25 years.
SELECT *, 
		AVG(Inches)  OVER(PARTITION BY Age) as AVG_HEIGHT
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Age IN (SELECT Age FROM [dbo].['FOOTBALL PLAYERS$'] WHERE Age>'25')


--14. Write a query to find all players whose height is greater than the average height of their respective team.
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE Inches >
					(SELECT AVG(Inches) FROM [dbo].['FOOTBALL PLAYERS$'])

--15. Write a query to find all players who share the same last name.
SELECT * 
		FROM [dbo].['FOOTBALL PLAYERS$']  
		WHERE LastName IN
						(SELECT LastName FROM [dbo].['FOOTBALL PLAYERS$'] GROUP BY LastName HAVING COUNT(LastName ) > 1);

--16. Write a query to find the players with the minimum height for each position.
SELECT *,  
		MIN(Ht) OVER(PARTITION BY Pos) as Minimum_Height
		FROM [dbo].['FOOTBALL PLAYERS$'];

/*SELECT Ht FROM [dbo].['FOOTBALL PLAYERS$']
WHERE Pos = 'C';*/ 

--17. Write a query to get the number of players for each team grouped by their experience level.
SELECT COUNT(NAME) as [CountOfPlayers], 
			TEAM, 
			Exp 
			FROM [dbo].['FOOTBALL PLAYERS$']
			GROUP BY Team, Exp
			ORDER BY Team ;

--18. Write a query to find the tallest and shortest players from each college.
SELECT College, 
				Max(Ht) as [TallestPlayer],
				Min(Ht) as [ShortestPlayer]
				FROM [dbo].['FOOTBALL PLAYERS$']
				GROUP BY College;

--OR Using the Inches Column instead,

SELECT College, 
			Max(Inches) as [TallestPlayer], 
			Min(Inches) as [ShortestPlayer] 
			FROM [dbo].['FOOTBALL PLAYERS$']
			GROUP BY College;

/*SELECT College, Inches FROM [dbo].['FOOTBALL PLAYERS$']
ORDER BY College */

--19. Write a query to find all players whose weight is above the average weight for their respective position.
SELECT NAME, 
		Wt, 
		Pos
		FROM [dbo].['FOOTBALL PLAYERS$']
		WHERE WT > 
				  (SELECT AVG(Wt) FROM [dbo].['FOOTBALL PLAYERS$'])
		ORDER BY Pos;

--20. Write a query to calculate the percentage of players in each position for every team.
WITH PositionCounts AS (
    SELECT
        Team,
        Pos,
        COUNT(Pos) AS position_count
    FROM
        [dbo].['FOOTBALL PLAYERS$']
    GROUP BY
        Team,
        Pos
),
TeamTotals AS (
    SELECT
        Team,
        COUNT(Team) AS Total_Team_players
    FROM
       [dbo].['FOOTBALL PLAYERS$']
    GROUP BY
        Team
)

SELECT
    pc.Team,
    pc.Pos,
    (ROUND(CAST(pc.position_count AS FLOAT)/(tt.Total_Team_players) * 100, 1)) AS percentage
FROM
    PositionCounts AS pc
JOIN
    TeamTotals tt ON pc.team = tt.team;
