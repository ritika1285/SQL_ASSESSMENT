CREATE DATABASE superstore_db;

use superstore_db;
select * from orders;

#################################################
### SECTION:B ###
#################################################

# B: 1. Execute a query to retrieve the first 20 records from the orders table to verify data ingestion.

SELECT * FROM ORDERS
LIMIT 20;

# B: 2. Select Order ID, Order Date, Sales, and Profit, applying a column alias to display Sales as Total_Sales.

SELECT 
        "ORDER ID",
        "ORDERDATE",
        SALES AS TOTAL_SALES,
	    PROFIT 
FROM ORDERS;
        
# B : 3. Display all orders where Sales is greater than 5000.
        
SELECT * FROM ORDERS
WHERE SALES > 5000;

# B: 4. Find the top 10 most profitable orders.

SELECT * FROM ORDERS
ORDER BY PROFIT DESC 
LIMIT 10;

###################################################################
### SECTION C – Retail Profitability & Market Segment Analysis  ###
###################################################################

USE superstore_db;

SELECT COUNT(*) AS Total_Records
FROM orders;

### 2. Multi-Condition Filtering Queries

##2.1  orders with Sales greater than 5000 and Profit less than 500.
SELECT 
    `Order ID`,
    `Product Name`,
    Category,
    Region,
    Sales,
    Discount,
    Profit
FROM orders
WHERE Sales > 5000
  AND Profit < 500;

##2.2 orders with high discounts and negative profit.
SELECT 
    `Order ID`,
    `Product Name`,
    Category,
    Region,
    Sales,
    Discount,
    Profit
FROM orders
WHERE Discount > 0
AND Profit < 0;

##### 3. Aggregated Performance Report by Region
## 3.1 Overall performance by region
SELECT 
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    AVG(Discount) AS Average_Discount
FROM orders
GROUP BY Region
ORDER BY Total_Profit DESC;

##3.2 Profit margin by region
SELECT 
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM orders
GROUP BY Region
ORDER BY Profit_Margin_Percentage DESC;

##4. Performance Report by Product Category
SELECT 
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    AVG(Discount) AS Average_Discount,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM orders
GROUP BY Category
ORDER BY Total_Profit DESC;

##5. Region and Category Performance
SELECT 
    Region,
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    AVG(Discount) AS Average_Discount,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM orders
GROUP BY Region, Category
ORDER BY Region, Total_Profit DESC;

#### 6. Summary of Loss-Making Transactions  #####

## 6.1 Overall loss-making transaction summary
SELECT 
    COUNT(*) AS Loss_Making_Transactions,
    SUM(Sales) AS Total_Sales_From_Losses,
    SUM(Profit) AS Total_Loss
FROM orders
WHERE Profit < 0;

##6.2 Detailed loss-making transactions
SELECT 
    `Order ID`,
    `Order Date`,
    `Product Name`,
    Category,
    `Sub-Category`,
    Region,
    Sales,
    Discount,
    Profit
FROM orders
WHERE Profit < 0
ORDER BY Profit asc;

##7. Loss-Making Transactions by Category
SELECT 
    Category,
    COUNT(*) AS Loss_Transactions,
    SUM(Sales) AS Loss_Sales,
    SUM(Profit) AS Total_Loss
FROM orders
WHERE Profit < 0
GROUP BY Category
ORDER BY Total_Loss ASC;

##8. Loss-Making Transactions by Region
SELECT 
    Region,
    COUNT(*) AS Loss_Transactions,
    SUM(Profit) AS Total_Loss
FROM orders
WHERE Profit < 0
GROUP BY Region
ORDER BY Total_Loss ASC;

##9. Analyze Discount Rate and Profit
SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.20 THEN '0-20%'
        WHEN Discount <= 0.40 THEN '21-40%'
        ELSE 'Above 40%'
    END AS Discount_Range,
    COUNT(*) AS Number_of_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM orders
GROUP BY Discount_Range
ORDER BY Total_Profit DESC;

##10. High Discount and Loss Analysis by Category
SELECT 
    Category,
    COUNT(*) AS Loss_Transactions,
    AVG(Discount) AS Average_Discount,
    SUM(Profit) AS Total_Loss
FROM orders
WHERE Discount > 0.30
  AND Profit < 0
GROUP BY Category
ORDER BY Total_Loss ASC;