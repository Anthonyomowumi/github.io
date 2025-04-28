/* KPI Requirements for SQL Pizza Queries */
SELECT * FROM pizza_sales;

--SELECT DISTINCT COUNT(order_id) FROM pizza_sales;
--SELECT COUNT(order_id) FROM pizza_sales;
--SELECT DISTINCT (pizza_category) FROM pizza_sales;
--SELECT DISTINCT (pizza_name) FROM pizza_sales;

--SUM OF TOTAL PRICE OF ALL PIZZA ORDERED...

SELECT SUM(total_price) AS [TOTAL REVENUE] FROM pizza_sales;

SELECT COUNT (DISTINCT order_id) AS [TOTAL NO OF ORDERS] FROM pizza_sales;

--AVERAGE AMOUNT SPENT PER ORDER
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS [AVG ORDER VALUE] FROM pizza_sales;

-- SUM OF THE QUANTITIES OF PIZZAS SOLD
SELECT SUM(quantity) AS [TOTAL PIZZA SOLD] FROM pizza_sales;

--TOTAL NNUMBER OF ORDER PLACED...
SELECT COUNT(DISTINCT order_id) AS [TOTAL ORDER] FROM pizza_sales;

-- AVERAGE PIZZA PER ORDER
SELECT SUM(quantity) / 
COUNT(DISTINCT order_id) AS [AVG PIZZA PER ORDER] FROM pizza_sales; -- Without casting to decimal...


SELECT CAST(SUM(quantity) AS decimal(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS decimal(10,2))  AS [AVG PIZZA PER ORDER] FROM pizza_sales; -- casting the particular columns

SELECT CAST(CAST(SUM(quantity) AS decimal(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS DECIMAL (10,2)) AS  [AVG PIZZA PER ORDER] FROM pizza_sales; -- Casting the entire result



-- USE [Pizza DB];
SELECT * FROM pizza_sales;

-- Daily Trend for Total Orders
SELECT DATENAME(WEEKDAY, order_date) AS [Order Day], 
COUNT (DISTINCT order_id) AS [Total Orders]
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date);

-- Montly Trend for Total Orders
SELECT DATENAME(MONTH, order_date) AS [Month Name], 
COUNT (DISTINCT order_id) AS [Total Orders]
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY [Total Orders] DESC;

-- Percentage of Sales by Pizza Category
SELECT pizza_category, SUM(total_price) * 100 / 
(select SUM(total_price) from pizza_sales) AS [PERCENT OF SALES] 
FROM pizza_sales
GROUP BY pizza_category;

/*SELECT pizza_category, (SUM(total_price) / 
(select SUM(total_price) from pizza_sales) * 100) AS [PERCENT OF SALES] 
FROM pizza_sales
GROUP BY pizza_category;

SELECT pizza_category, SUM(total_price) AS [Total Sales], (SUM(total_price) / 
(select SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1) * 100 ) AS [PERCENT OF SALES] 
FROM pizza_sales
WHERE MONTH(order_date) = 1 -- Filter for January...
GROUP BY pizza_category; --Always add the WHERE filter in the subquery as well in order to execute properly..

SELECT pizza_category, SUM(total_price) AS [Total Sales], (SUM(total_price) / 
(select SUM(total_price) from pizza_sales) * 100) AS [PERCENT OF SALES] 
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1 -- Filter for the first quarter of the year...Which is incorrect because it needs to be put in the subselect query to work perfectly well.
GROUP BY pizza_category;

SELECT pizza_category, SUM(total_price) AS [Total Sales], (SUM(total_price) / 
(select SUM(total_price) from pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) * 100) AS [PERCENT OF SALES] 
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1 -- Filter for the first quarter of the year...
GROUP BY pizza_category; */


-- Percentage of Sales by Pizza Size
SELECT pizza_size, SUM(total_price) AS [Total Sales], CAST((SUM(total_price) / 
(select SUM(total_price) from pizza_sales) * 100) AS DECIMAL(10,2)) AS [PERCENT OF SALES]
FROM pizza_sales
GROUP BY pizza_size
ORDER BY [PERCENT OF SALES];

-- Top 5 & Bottom 5 Best Sellers/Pizza by Revenue, Total Quantity and Total Orders...
/*SELECT pizza_name, SUM(total_price) As [Revenue]
FROM pizza_sales
Group By pizza_name
ORDER By [Revenue] desc;

SELECT Top 5 (SUM(total_price)) As [Revenue], pizza_name 
FROM pizza_sales
Group By pizza_name;*/

SELECT TOP 5 pizza_name, SUM(total_price) As [Revenue]
FROM pizza_sales
Group By pizza_name
Order By [Revenue] DESC; -- Top 5 Pizza by Revenue
-- Bottom 5 Pizza by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) As [Revenue]
FROM pizza_sales
Group By pizza_name
Order By [Revenue] ASC; -- Bottom 5 Pizza by Revenue

-- Top 5 Pizza by Total Quantity
SELECT TOP 5 pizza_name, SUM(quantity) As [Total Quantity]
FROM pizza_sales
Group By pizza_name
Order By [Total Quantity] DESC; -- TOP 5 Pizza by Total Quantity

-- Bottom 5 Pizza by Total Quantity
SELECT TOP 5 pizza_name, SUM(quantity) As [Total Quantity]
FROM pizza_sales
Group By pizza_name
Order By [Total Quantity] ASC; -- BOTTOM 5 Pizza by Total Quantity

-- TOP 5 pizza by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) As [Total Orders]
FROM pizza_sales
Group By pizza_name
Order By [Total Orders] DESC; -- TOP 5 Pizza by Total Orders

-- Bottom 5 pizza by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) As [Total Orders]
FROM pizza_sales
Group By pizza_name
Order By [Total Orders] ASC; -- BOTTOM 5 Pizza by Total Orders
