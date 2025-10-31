# Amazon_Sales-Data2025
# Amazon Sales Data Analysis (SQL Project)

## Project Overview
This project focuses on **analyzing Amazon sales data** using SQL Server to uncover meaningful **business insights**, track **sales performance**, and support **data-driven decision-making**.  
The dataset includes key sales metrics such as product details, quantity, total sales, customer locations, and payment methods.  

## The data include five major tables:
**Products** - Product details(Product Category,Unit price)

**TotalSales** - (Unit price * Quantity)

**Category** - Category of each product

**Payment Method**

**Date**

The analysis answers questions like:
- What is the total revenue generated?
- Which products and regions perform the best?
- How do sales trends change month-over-month?
- What caused the decline in April sales?

---

## Objectives
1. **Understand the dataset** structure and contents.  
2. Perform **Sales Performance Analysis** (Revenue trends, Top Products).  
3. Gain **Customer Insights** (Top customers, regions, payment methods).  
4. Explore **Product Performance** (Best and worst categories).  
5. Calculate **Month-over-Month (MoM) Growth** and **seasonal variations**.  
6. Identify causes of **sales declines** in specific months.  

---

##  Tools & Technologies
- **SQL Server (SSMS 21)**  
- **Microsoft Excel** (for data cleaning and preprocessing)  
- **Power BI** (for dashboards)  

---

## SQL Queries & Analysis

### 1️ Understanding the Data
```sql
SELECT * 
FROM [amazon_sales_data 2025];
```

### 2️ Sales Performance Analysis
**Total Revenue:**
```sql
SELECT SUM(Total_Sales) AS Revenue
FROM [amazon_sales_data 2025];
```

**Monthly Revenue Trend:**
```sql
SELECT DATENAME(month, Date) AS Month_Name, 
       SUM(Total_Sales) AS TotalSales
FROM [amazon_sales_data 2025]
GROUP BY DATENAME(month, Date), MONTH(Date)
ORDER BY MONTH(Date);
```

**Top 5 Products by Revenue:**
```sql
SELECT TOP 5 Product, SUM(Total_Sales) AS TotalSales_Revenue
FROM [amazon_sales_data 2025]
GROUP BY Product
ORDER BY TotalSales_Revenue DESC;
```

### 3️ Customer Insights
**Top & Bottom Performing Products:**
```sql
SELECT TOP 5 Product, SUM(Total_Sales) AS TotalSales
FROM [amazon_sales_data 2025]
GROUP BY Product
ORDER BY TotalSales DESC; -- For top products

SELECT TOP 5 Product, SUM(Total_Sales) AS TotalSales
FROM [amazon_sales_data 2025]
GROUP BY Product
ORDER BY TotalSales ASC; -- For bottom products
```

**Most Used Payment Method:**
```sql
SELECT Payment_Method, COUNT(Payment_Method) AS Payment_Count
FROM [amazon_sales_data 2025]
GROUP BY Payment_Method
ORDER BY Payment_Count DESC;
```

### 4️ Regional Analysis
**Top Performing Regions:**
```sql
SELECT Customer_Location, SUM(Total_Sales) AS Sales
FROM [amazon_sales_data 2025]
GROUP BY Customer_Location
ORDER BY Sales DESC;
```

**Underperforming Regions:**
```sql
SELECT TOP 2 Customer_Location, SUM(Total_Sales) AS Sales
FROM [amazon_sales_data 2025]
GROUP BY Customer_Location
ORDER BY Sales ASC;
```

### 5️ Product Insight
**Sales by Product Category:**
```sql
SELECT Category, SUM(Total_Sales) AS Sales
FROM [amazon_sales_data 2025]
GROUP BY Category
ORDER BY Sales DESC;
```

### 6️ Month-over-Month Growth Analysis
```sql
SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Total_Sales) AS Monthly_Sales,
    LAG(SUM(Total_Sales)) OVER (ORDER BY YEAR(Date), MONTH(Date)) AS Prev_Month_Sales,
    (SUM(Total_Sales) - LAG(SUM(Total_Sales)) OVER (ORDER BY YEAR(Date), MONTH(Date))) * 100.0 /
    NULLIF(LAG(SUM(Total_Sales)) OVER (ORDER BY YEAR(Date), MONTH(Date)), 0) AS Growth_Rate_Percent
FROM [amazon_sales_data 2025]
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;
```

### 7️ Investigating the Decline in April
**Total Quantity & Revenue per Month:**
```sql
SELECT MONTH(Date) AS Month, 
       SUM(Quantity) AS Total_Quantity,  
       SUM(Total_Sales) AS Total_Revenue  
FROM [amazon_sales_data 2025]
GROUP BY MONTH(Date)
ORDER BY MONTH(Date);
```

**Total Orders per Month:**
```sql
SELECT COUNT(Order_ID) AS Total_Orders,
       DATENAME(month, Date) AS Month
FROM [amazon_sales_data 2025]
GROUP BY DATENAME(month, Date), MONTH(Date);
```

---

## Insights & Recommendations
- **April** recorded the **lowest sales**, likely due to reduced quantity sold and fewer orders.  
- **Top-selling products** drive the majority of total revenue — suggesting focused inventory management.  
- **Certain regions underperform**, indicating a need for localized marketing efforts.  
- **Payment methods analysis** shows customer preferences — optimizing for top methods may boost conversions.  

---



