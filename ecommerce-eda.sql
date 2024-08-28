-- Exploratory Data Analysis

UPDATE sales
SET OrderDate = str_to_date(OrderDate,"%m/%d/%Y");

UPDATE sales
SET ShipDate = str_to_date(ShipDate,"%m/%d/%Y");

SELECT *
FROM sales;

-- 1. Total Sales
SELECT SUM(Sales) AS total_sales
FROM sales;

-- 2. Total Orders
SELECT COUNT(DISTINCT OrderID) AS total_orders
FROM sales;

-- 3. Total Customers
SELECT COUNT(DISTINCT CustomerName) AS total_customers
FROM sales;

-- 4. Total Cities
SELECT COUNT(DISTINCT City) AS total_cities
FROM sales;

-- 5. Profit Margin
SELECT SUM(Profit) / SUM(Sales) AS profit_margin
FROM sales; 

-- 6. Sales by State
SELECT State, SUM(Sales) As total_sales
FROM sales
GROUP BY State
ORDER BY SUM(Sales) DESC
LIMIT 5;

-- 7. Sales by City
SELECT City, SUM(Sales) As total_sales
FROM sales
GROUP BY City
ORDER BY SUM(Sales) DESC
LIMIT 5;

-- 8. Sales by Top Customers
SELECT CustomerName, SUM(Sales) As total_sales
FROM sales
GROUP BY CustomerName
ORDER BY SUM(Sales) DESC
LIMIT 5;

-- 9. Sales by Segment
SELECT MONTH(OrderDate) AS month, YEAR(OrderDate) AS year, Segment, SUM(Sales) as total_sales
FROM sales
GROUP BY MONTH(OrderDate), YEAR(OrderDate), segment
ORDER BY YEAR(OrderDate), MONTH(OrderDate);

-- 10. Sales by Region
SELECT Region, YEAR(OrderDate), SUM(sales) AS total_sales
FROM sales
GROUP BY Region,YEAR(OrderDate)
ORDER BY Region,YEAR(OrderDate);

-- 11. Sales and Profit by Year
SELECT YEAR(OrderDate) AS Year, SUM(Sales) AS total_sales, SUM(Profit) AS total_profit
FROM sales
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate);

-- 12. Products with the Highest Profit Margin
SELECT ProductID, ProductName, SUM(Profit) / SUM(Sales) * 100 AS profit_margin
FROM sales
GROUP BY ProductID, ProductName
ORDER BY profit_margin DESC
LIMIT 10;

-- 13. Year-by-Year Growth
SELECT 
    YEAR(OrderDate), 
    SUM(Sales) AS total_sales, 
    LAG(SUM(Sales)) OVER (ORDER BY YEAR(OrderDate)) AS prev_year_sales,
    (SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY YEAR(OrderDate))) / LAG(SUM(Sales)) OVER (ORDER BY YEAR(OrderDate)) * 100 AS yoy_growth
FROM sales
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate);

-- 14. Most Profitable Categories
SELECT 
    Category, 
    SUM(Sales) AS total_sales, 
    SUM(Profit) AS total_profit,
    SUM(Profit) / SUM(Sales) * 100 AS profit_margin,
    RANK() OVER (ORDER BY SUM(Profit) DESC) AS profitability_rank
FROM sales
GROUP BY Category
ORDER BY profitability_rank;

-- 15. Top 10 Best and Worst Products
(SELECT 
    ProductID, 
    ProductName, 
    SUM(Profit) AS total_profit
FROM sales
GROUP BY 
    ProductID, 
    ProductName
ORDER BY total_profit DESC
LIMIT 10)
UNION ALL
(SELECT 
    ProductID, 
    ProductName, 
    SUM(Profit) AS total_profit
FROM sales
GROUP BY 
    ProductID, 
    ProductName
ORDER BY total_profit ASC
LIMIT 10);

-- 16. Number of customers per year
SELECT Year, COUNT(DISTINCT CustomerName) AS num_of_customers
FROM sales
GROUP BY Year
ORDER BY Year;

-- 17. Profit by Segment
SELECT Segment, AVG(Profit) AS average_profit, SUM(Profit) as total_profit
FROM sales
GROUP BY Segment;