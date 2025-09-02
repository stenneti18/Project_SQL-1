# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: SQL_PROJECT_1

This is my first ever project where I set out to demonstrate my SQL skills by exploring, cleaning, and analyzing retail sales data. I built a retail sales database, performed exploratory data analysis (EDA), and answered business questions through SQL queries. It was a great learning experience, and I had a lot of fun working on it while building a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_PROJECT_1`.
- **Table Creation**: A table named `Retail_Sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE SQL_PROJECT_1;

CREATE TABLE Retail_Sales
				(
					transactions_id INT PRIMARY KEY,
					sale_date DATE,
					sale_time TIME,
					customer_id	INT,
					gender	VARCHAR(15),
					age	INT,
					category VARCHAR(15),
					quantity	INT,
					price_per_unit FLOAT,
					cogs FLOAT,
					total_sale FLOAT
				);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM Retail_Sales;
SELECT COUNT(DISTINCT customer_id) FROM Retail_Sales;
SELECT DISTINCT category FROM Retail_Sales;

SELECT * FROM Retail_Sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;

DELETE FROM Retail_Sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05 and also give a count of number of sales made for that day.**:
```sql
SELECT * FROM Retail_Sales
WHERE sale_date = '2022-11-05';

SELECT count(*) FROM Retail_Sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * FROM Retail_Sales 
WHERE category = 'Clothing' AND quantity >= 4 AND sale_date BETWEEN '2022-11-01' AND '2022-12-01';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category, SUM(total_sale) AS total_sales
FROM Retail_Sales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM Retail_Sales
WHERE category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000. Also give us the count of such transactions.**:
```sql
SELECT * FROM Retail_Sales
WHERE total_sale > 1000;

SELECT COUNT(*) FROM Retail_Sales
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT COUNT(*) AS total_transactions, gender, category
FROM Retail_Sales
GROUP BY gender, category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
-- The first step is to find the average sale for each month:
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    ROUND(AVG(total_sale), 2) AS avg_sale
FROM Retail_Sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, avg_sale DESC;

-- Now that we have the monthly avg sales, we need to arrange them in a descending order to get the best average selling month in each year:
WITH monthly_sales AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sales
    FROM Retail_Sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT year, month, avg_sales
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY year ORDER BY avg_sales DESC) AS rnk
    FROM monthly_sales
) ranked
WHERE rnk = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales.**:
```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM Retail_Sales	
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM Retail_Sales
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale 
AS
(
SELECT *, 
CASE
	WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) >= 12 AND HOUR(sale_time) <= 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS shift
FROM Retail_Sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


## Author - Santhosh Tenneti

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/santhoshtenneti/)

Thank you, and I look forward to connecting with you!
