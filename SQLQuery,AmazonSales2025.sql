-- Let's understant the data(Output all the data)
SELECT * FROM
[amazon_sales_data 2025]
--Q1.SALES PERFORMANCE ANALYSIS

--Total Revenue
SELECT SUM(Total_Sales) AS Revenue
FROM [amazon_sales_data 2025]
	--What is the Total sales Revenue of each months?
SELECT
	DATENAME(month,Date) AS Month_Name,
	SUM(Total_Sales) As TotalSales
FROM [amazon_sales_data 2025]
GROUP BY DATENAME(month,Date),MONTH([Date])
ORDER BY MONTH([Date])

--Total sales revenue across all products
SELECT product,
	SUM(Total_Sales) As TotalSales_Revenue
FROM [amazon_sales_data 2025]
GROUP BY Product
ORDER BY TotalSales_Revenue DESC


--Top 5 Purchased product by revenue
SELECT TOP 5 product,
	SUM(Total_Sales) As TotalSales_Revenue
FROM [amazon_sales_data 2025]
GROUP BY Product
ORDER BY TotalSales_Revenue DESC

	--How do monthly sales compare across the year?
SELECT
SUM(Total_Sales) AS TotalSales,
MONTH (Date) AS MonthNum,
DATENAME(MONTH,Date) AS month,
YEAR(Date) AS Year
FROM [amazon_sales_data 2025]
GROUP BY 
	MONTH (Date),
	DATENAME(MONTH,Date),
	YEAR(Date)
ORDER BY
	Year,
	MonthNum

	--Which product generated the highest revenue?
	SELECT TOP 1 product,
	SUM(Total_Sales) As TotalSales_Revenue
FROM [amazon_sales_data 2025]
GROUP BY Product
ORDER BY TotalSales_Revenue DESC

--Q2.Customer Insights
	--Top 5 most performed products?
SELECT TOP 5
Product,
SUM(Total_Sales) AS TotalSales
FROM [amazon_sales_data 2025]
GROUP BY Product
ORDER BY TotalSales DESC
	--Bottom 5 underperformed product
SELECT TOP 5
Product,
SUM(Total_Sales) AS TotalSales
FROM [amazon_sales_data 2025]
GROUP BY Product
ORDER BY TotalSales ASC
	--Which payment method is mostly used among Customers?
SELECT COUNT(Payment_Method) AS paymentmethod,
Payment_Method
FROM [amazon_sales_data 2025]
GROUP BY Payment_Method
ORDER BY paymentmethod DESC

	--Which region generated most sales?
SELECT 
Customer_Location,
SUM(Total_Sales) AS Sales
FROM
[amazon_sales_data 2025]
Group by Customer_Location
ORDER BY Sales DESC
--Underperforming Regions by Sales
SELECT TOP 2 --I use TOP to output the records that i want
Customer_Location,
SUM(Total_Sales) AS Sales
FROM
[amazon_sales_data 2025]
Group by Customer_Location
ORDER BY Sales ASC
--Q3.Product Insight
	--Which is the most sold product by category?
SELECT
Category,
SUM(Total_Sales) Sales
FROM [amazon_sales_data 2025]
GROUP BY Category
Order by Sales DESC


--Q5. Month-over-Month Growth
	--What is the sales growth rate compared to previous months?
SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Total_Sales) AS Monthly_Sales,
    LAG(SUM(Total_Sales)) OVER (ORDER BY YEAR(Date), MONTH(Date)) AS Prev_Month_Sales,
	(SUM(Total_Sales) - LAG(SUM(Total_Sales)) OVER (ORDER BY YEAR(Date), MONTH(Date))) * 100.0 /
    ROUND (NULLIF(LAG(SUM(Total_Sales)) OVER (ORDER BY YEAR(Date), MONTH(Date)), 0),2) AS Growth_Rate_Percent
    
FROM [amazon_sales_data 2025]
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month

--Q6 : See why there was a great decline in the month of April(April had fewer items sold)
SELECT  
    MONTH([Date]) AS Month, 
    SUM(Quantity) AS Total_Quantity,  
    SUM(Total_Sales) AS Total_Revenue  
FROM [amazon_sales_data 2025]  
GROUP BY MONTH([Date])  
ORDER BY MONTH([Date])

--Total orders received that month
SELECT 
	COUNT(Order_ID) AS Total_Orders,
	DATENAME(month,DATE) AS month
FROM [amazon_sales_data 2025] 
GROUP BY DATENAME(month,DATE), MONTH([Date])
