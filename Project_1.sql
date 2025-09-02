-- RETAIL SALES ANALYSIS (P1)
CREATE DATABASE SQL_PROJECT_1;

-- Create Table
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

SELECT * FROM Retail_Sales;

-- Data Cleaning
SELECT * FROM Retail_Sales
WHERE 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- DATA EXPLORATION: 

-- How many sales happened?
SELECT COUNT(*) AS total_sale FROM Retail_Sales;

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) as unique_customers FROM Retail_Sales;

-- How many unique categories we have and what are they?
SELECT COUNT(DISTINCT category) as unique_category FROM Retail_Sales;
SELECT DISTINCT category FROM Retail_Sales;

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS:

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05' and also give a count of number of sales made for that day. 
SELECT * FROM Retail_Sales
WHERE sale_date = '2022-11-05';

SELECT count(*) FROM Retail_Sales
WHERE sale_date = '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
SELECT * FROM Retail_Sales 
WHERE category = 'Clothing' AND quantity >= 4 AND sale_date BETWEEN '2022-11-01' AND '2022-12-01';

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) AS total_sales
FROM Retail_Sales
GROUP BY category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age), 2) AS avg_age
FROM Retail_Sales
WHERE category = 'Beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000. Also give us the count of such transactions. 
SELECT * FROM Retail_Sales
WHERE total_sale > 1000;

SELECT COUNT(*) FROM Retail_Sales
WHERE total_sale > 1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT COUNT(*) AS total_transactions, gender, category
FROM Retail_Sales
GROUP BY gender, category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
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

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT customer_id, SUM(total_sale) AS total_sales
FROM Retail_Sales	
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM Retail_Sales
GROUP BY category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
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

-- END OF THE PROJECT












