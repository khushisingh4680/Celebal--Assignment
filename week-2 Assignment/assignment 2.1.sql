CREATE DATABASE superstore;
USE superstore;
RENAME TABLE superstore TO superstore_data;
SELECT * FROM superstore_data;

DESC superstore_data;

SELECT * FROM superstore_data
LIMIT 10;

SELECT COUNT(*) AS total_rows FROM superstore_data;

SELECT * FROM superstore_data
WHERE Region = 'South'
LIMIT 10;

SELECT * FROM superstore_data
WHERE Category = 'Furniture'
LIMIT 10;

SELECT * FROM superstore_data
WHERE Sales > 1000;

SELECT * FROM superstore_data
WHERE YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) = 2017
LIMIT 5;

SELECT * FROM superstore_data
WHERE Category = 'Technology'
AND Region = 'West';

SELECT Category,
SUM(Quantity) AS Total_quantity
FROM superstore_data
GROUP BY Category;

SELECT Region,
ROUND(AVG(Profit),2) AS Avg_profit
FROM superstore_data
GROUP BY Region;

SELECT Region,
ROUND(SUM(Sales),2) AS Total_sales,
ROUND(SUM(Profit),2) AS Total_profit
FROM superstore_data
GROUP BY Region;

SELECT `Product Name`,
ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_data
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT Category,
ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore_data
GROUP BY Category
ORDER BY Total_Profit DESC
LIMIT 5;

SELECT `Customer Name`,
ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore_data
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Year,
MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Month,
ROUND(SUM(Sales), 2) AS Monthly_Sales
FROM superstore_data
GROUP BY Year, Month
ORDER BY Year, Month;

SELECT `Customer Name`,
COUNT(`Order ID`) AS Orders_Count,
ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore_data
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT `Product Name`,
ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore_data
GROUP BY `Product Name`
ORDER BY Total_Profit DESC
LIMIT 10;

SELECT `Order ID`,
COUNT(*) AS Duplicate_Count
FROM superstore_data
GROUP BY `Order ID`
HAVING COUNT(*) > 1;

SELECT `Order ID`,
`Product ID`,
COUNT(*) AS Duplicate_Count
FROM superstore_data
GROUP BY
`Order ID`,
`Product ID`
HAVING COUNT(*) > 1;

SELECT
SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Null_Sales,
SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Null_Profit,
SUM(CASE WHEN `Customer Name` IS NULL THEN 1 ELSE 0 END) AS Null_Customers
FROM superstore_data;

SELECT * FROM superstore_data
WHERE Profit < 0;

SELECT COUNT(*) AS Total_Rows
FROM superstore_data;
