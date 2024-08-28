# E-commerce Sales Analysis
## Objective
Understand customer behavior, preferences, and demographics to improve marketing and overall satisfaction. Develop an insightful sales analytics dashboard to monitor and optimize the performance of an e-commerce platform.
## Data Description
[E-Commerce Sales Data](https://www.kaggle.com/datasets/abdelrahmanalimo/sales-ecommerce)


**Order ID**: A unique identifier for each sales transaction.\
**Year**: The year the order was made.\
**Order Date**: The date the order was made.\
**Ship Date**: The date the order was shipped.\
**Shipment Days**: The number of days it took the order to ship.\
**Ship Mode**: The mode of shipment.\
**Customer ID**: A unique identifier for each customer.\
**Customer Name**: The name of the customer.\
**Segment**: The segment of the sale.\
**Country**: The country of the sale.\
**City**: The city of the sale.\
**State**: The state of the sale.\
**Postal Code**: The postal code of the sale.\
**Region**: The region of the sale.\
**Product ID**: A unique identifier for each product.\
**Category**: The category of the product.\
**Sub-Category**: The sub-category of the product.\
**Product Name**: The name of the product.\
**Sales**: The revenue made from the transaction of the product.\
**Quantity**: The amount of units bought of the product.\
**Discount**: The discount applied on the sale, if any.\
**Profit**: The profit made from the transaction of the product.

## Exploratory Data Analysis in SQL
1. Total Sales
```
SELECT SUM(Sales)
FROM sales AS total_sales
```
| total_sales |
|-------------|
| 2297200.86  |
2. Total Orders
```
SELECT COUNT(DISTINCT OrderID)
FROM sales AS total_orders
```
| total_orders |
|-------------|
| 5009  |
3. Total Customers
```
SELECT COUNT(DISTINCT CustomerName)
FROM sales AS total_customers
```
| total_orders |
|-------------|
| 793  |
4. Total Cities
```
SELECT COUNT(DISTINCT City) AS total_cities
FROM sales;
```
| total_cities |
|-------------|
| 531  |
5. Profit Margin
```
SELECT (SUM(Profit) / SUM(Sales)) * 100 AS profit_margin
FROM sales;
```
| profit_margin |
|-------------|
|  12.53 |
6. Sales by State
```
SELECT State, SUM(Sales) As total_sales
FROM sales
GROUP BY State
ORDER BY SUM(Sales) DESC
LIMIT 5;
```
| State        | total_sales |
|--------------|-------------|
| California   | 450567.63   |
| New York     | 309453.56   |
| Texas        | 169553.58   |
| Washington   | 136590.20   |
| Pennsylvania | 114911.32   |
7. Sales by City
```
SELECT City, SUM(Sales) As total_sales
FROM sales
GROUP BY City
ORDER BY SUM(Sales) DESC
LIMIT 5;
```
| City        | total_sales |
|--------------|-------------|
| New York City   | 255248.93   |
| Los Angeles     | 173168.85   |
| Seattle        | 117772.59   |
| San Francisco   | 110917.03   |
| Philadelphia | 107486.53   |
8. Sales by Top Customers
```
SELECT CustomerName, SUM(Sales) As total_sales
FROM sales
GROUP BY CustomerName
ORDER BY SUM(Sales) DESC
LIMIT 5;
```
| CustomerName        | total_sales |
|--------------|-------------|
| Sean Miller   | 25043.07   |
| Tamara Chand     | 19017.85   |
| Raymond Buch        | 15117.35   |
| Tom Ashbrook   | 14595.62   |
| Adrian Barton | 14355.61   |
9. Year-by-Year Growth
```
SELECT 
    Year, 
    SUM(Sales) AS total_sales, 
    LAG(SUM(Sales)) OVER (ORDER BY Year) AS prev_year_sales,
    (SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY Year)) / LAG(SUM(Sales)) OVER (ORDER BY Year) * 100 AS yoy_growth
FROM sales
GROUP BY Year
ORDER BY Year;
```
| Year | total_sales | prev_year_sales | yoy_growth |
|------|-------------|-----------------|------------|
| 2011 | 481763.83   | NULL            | NULL       |
| 2012 | 464426.18   | 481763.83       | -3.60      |
| 2013 | 600533.77   | 464426.18       | 29.31      |
| 2014 | 725726.29   | 600533.77       | 20.85      |
10. Most Profitable Categories
```
SELECT 
    Category, 
    SUM(Sales) AS total_sales, 
    SUM(Profit) AS total_profit,
    SUM(Profit) / SUM(Sales) * 100 AS profit_margin,
    RANK() OVER (ORDER BY SUM(Profit) DESC) AS profitability_rank
FROM sales
GROUP BY Category
ORDER BY profitability_rank;
```
| Category        | total_sales | total_profit | profit_margin | profitability_rank |
|-----------------|-------------|--------------|---------------|--------------------|
| Technology      | 835900.14   | 145387.81    | 17.39         | 1                  |
| Office Supplies | 703502.87   | 120489.93    | 17.13         | 2                  |
| Furniture       | 733047.06   | 16980.72     | 2.32          | 3                  |


## Dashboard 
  - KPI's:
      1. Total Sales
      2. Total Orders
      3. Total Customers
      4. Total Cities
      5. Profit Margin
  - Sales Timeline: An interactive timeline that showcases sales for each segment type.
  - Sales by State: A US map highlighting the states with the most sales.
  - Sales by City: A bar chart showing the top 5 cities with the most sales
  - Sales by Top Customers: A funnel chart identifying the 5 customers who order the most.
  - Slicers:
    1. Category
    2. Region
  
![Screenshot 2024-08-23 185121](https://github.com/user-attachments/assets/bc17d23f-fa99-4ee3-9ec0-4fb6979be5a5)
## Results
**Sales Performance**
- The total profit has been steadily increasing from 2011 to 2014, despite there being a negative growth in sales from 2011 from 2012.
- New York City and Los Angeles have the best performance by far, with the west region having the highest order count.
- The three products that are driving the most sales are the Canon imageCLASS 2200 Advanced Copier, Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind, and Hewlett Packard LaserJet 3310 Copier.\
**Customer Insights**
- The top three customers are Sean Miller, Tamara Chand, and Raymond Buch. Priorite them for retention.
- Sales in the technology and office supplies category have similar high profit margins, but sales in the furniture category have a low profit margin. Consider decreasing furniture inventory.

