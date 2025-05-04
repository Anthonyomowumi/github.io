SELECT * FROM [dbo].[Customer$]

SELECT * FROM [dbo].[Salesman$]

SELECT * FROM [dbo].[Order$]

/* This is to delete the null values in all column, Use AND and OR can be use in either of the column
DELETE FROM [dbo].[Customer$]
WHERE Customer_ID IS NULL AND Customer_Name IS NULL AND City IS NULL AND Grade IS NULL AND Salesman_ID IS NULL;

DELETE FROM [dbo].[Order$]
WHERE [Order Number] IS NULL AND Purchase_Amount IS NULL AND [Order Date] IS NULL AND [Customer ID] IS NULL AND Salesman_id IS NULL;

DELETE FROM [dbo].[Salesman$]
WHERE Salesman_id IS NULL AND Name IS NULL AND city IS NULL AND commission IS NULL; */


	
--1. write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city.
SELECT S.Name as Salesman, 
		C.Customer_Name,
		C.City
FROM [dbo].[Customer$] AS C
Inner Join
[dbo].[Salesman$] AS S
ON S.Salesman_ID = C.Salesman_id
WHERE S.City=C.city;

--2. write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.
SELECT O.[Order Number],
		O.Purchase_Amount, 
		C.Customer_Name,
		C.City
FROM [dbo].[Order$] AS O
JOIN
[dbo].[Customer$] AS C
ON O.[Customer ID] = C.[Customer_ID]
WHERE Purchase_Amount BETWEEN 500 AND 2000;

--3. write a SQL query to find the salesperson(s) and the customer(s) he represents. Return Customer Name, city, Salesman, commission.
SELECT C.Customer_Name, 
		C.City, 
		S.Name as Salesman, 
		S.commission
FROM [dbo].[Customer$] AS C
INNER JOIN [dbo].[Salesman$] AS S
ON S.Salesman_id = C.Salesman_ID;

--4. write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name, customer city, Salesman, commission.  
SELECT C.Customer_Name,
		C.City,
		S.Name as Salesman,
		S.commission
FROM [dbo].[Salesman$] AS S
INNER JOIN [dbo].[Customer$] AS C
ON S.Salesman_id = C.Salesman_ID
WHERE commission>0.12;

--5. write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission of more than 12% from the company. Return Customer Name, customer city, Salesman, salesman city, commission
SELECT C.Customer_Name, 
		C.City, 
		Name as Salesman, 
		S.city, 
		S.commission
FROM [dbo].[Salesman$] AS S
INNER JOIN [dbo].[Customer$] AS C
ON S.Salesman_id = C.Salesman_ID
WHERE S.city <> C.City AND 
commission>0.12;

--6. write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission
SELECT O.[Order Number],
		O.[Order Date],
		O.Purchase_Amount,
		C.Customer_Name,
		C.Grade,
		S.Name as Salesman,
		S.commission
FROM [dbo].[Order$] AS O
INNER JOIN [dbo].[Customer$] AS C
ON O.[Customer ID] = C.Customer_ID
INNER JOIN[dbo].[Salesman$] AS S
ON O.Salesman_id =S.Salesman_id;

--7. Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and only the relational rows are returned. 
SELECT S.NAME as Salesman, S.commission,
		C.Customer_ID, C.Customer_Name, C.City, C.Grade, C.Salesman_ID,
		O.[Order Number], O.Purchase_Amount, O.[Order Date]
		FROM [dbo].[Order$] AS O
		LEFT JOIN [dbo].[Customer$] AS C ON C.Customer_ID =O.[Customer ID]
		LEFT JOIN [dbo].[Salesman$] AS S ON S.Salesman_id = O.Salesman_id;
--OR


/*SELECT *
FROM [dbo].[Order$] o
JOIN [dbo].[Customer$] c ON o.[Customer ID] = c.Customer_ID
JOIN [dbo].[Salesman$] s ON o.Salesman_id = s.Salesman_id;*/

--8. write a SQL query to display the customer name, customer city, grade, salesman, salesman city. The results should be sorted by ascending customer_id.
SELECT C.Customer_Name, 
		C.City,
		C.Grade,
		S.Name as Salesman,
		S.city
FROM [dbo].[Customer$] AS C
JOIN [dbo].[Salesman$] AS S
ON C.Salesman_ID = S.Salesman_id
ORDER BY Customer_ID ASC;

--9. write a SQL query to find those customers with a grade less than 300. Return cust_name, customer city, grade, Salesman, salesmancity. The result should be ordered by ascending customer_id.
SELECT C.Customer_Name, 
		C.City,
		C.Grade,
		S.Name as Salesman,
		S.city
FROM [dbo].[Customer$] AS C
JOIN [dbo].[Salesman$] AS S
ON C.Salesman_ID = S.Salesman_id
WHERE C.Grade <300
ORDER BY Customer_ID ASC;

--10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to determine whether any of the existing customers have placed an order or not.
SELECT C.Customer_Name,
		C.City,
		O.[Order Number],
		O.[Order Date],
		O.Purchase_Amount 
FROM [dbo].[Customer$] AS C
INNER JOIN [dbo].[Order$] AS O
ON C.Customer_ID = O.[Customer ID]
ORDER BY Purchase_Amount, [Order Date];

--11. SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and commission to determine if any of the existing customers have not placed orders or if they have placed orders through their salesman or by themselves.
SELECT C.Customer_Name,
		C.City,
		O.[Order Number],
		O.[Order Date],
		O.Purchase_Amount,
		S.Name as Salesman,
		S.commission
FROM [dbo].[Customer$] AS C
INNER JOIN [dbo].[Order$] AS O
ON C.Customer_ID = O.[Customer ID]
INNER JOIN [dbo].[Salesman$] AS S
ON C.Salesman_ID = S.Salesman_id

--12. Write a SQL statement to generate a list in ascending order of salespersons who work either for one or more customers or have not yet joined any of the customers.
SELECT * FROM [dbo].[Salesman$] AS S
LEFT JOIN [dbo].[Customer$] AS C 
ON S.Salesman_id = C.Salesman_ID
ORDER BY Name ASC

--13. write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount.
SELECT S.Name as Salespersons,
		C.Customer_Name,
		C.City,
		C.Grade,
		O.[Order Number],
		O.[Order Date],
		O.Purchase_Amount
FROM [dbo].[Salesman$] AS S
INNER JOIN [dbo].[Customer$] AS C ON C.Salesman_ID = S.Salesman_id
INNER JOIN [dbo].[Order$] AS O ON O.Salesman_id = S.Salesman_id;


--14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
SELECT S.Name as Salespersons,
		C.Customer_Name,
		C.City,
		C.Grade,
		O.[Order Number],
		O.[Order Date],
		O.Purchase_Amount
FROM [dbo].[Salesman$] AS S
INNER JOIN [dbo].[Customer$] AS C ON C.Salesman_ID = S.Salesman_id
INNER JOIN [dbo].[Order$] AS O ON O.Salesman_id = S.Salesman_id
WHERE O.Purchase_Amount >= 2000;

--15. For those customers from the existing list who put one or more orders, or which orders have been placed by the customer who is not on the list, create a report containing the customer name, city, order number, order date, and purchase amount


-- Orders by customers in the customer list
SELECT 
    C.Customer_Name,
    C.City,
    O.[Order Number],
    O.[Order Date],
    O.Purchase_Amount
FROM 
   [dbo].[Customer$] C
JOIN 
   [dbo].[Order$]  O ON C.Customer_ID = O.[Customer ID]

UNION

-- Orders by customers NOT in the customer list
SELECT 
    NULL AS customer_name,
    NULL AS city,
    O.[Order Number],
    O.[Order Date],
    O.Purchase_Amount
FROM 
	[dbo].[Order$]  O
LEFT JOIN 
   [dbo].[Customer$]  C ON O.[Customer ID] = C.Customer_ID
WHERE 
    C.Customer_ID IS NULL;

















