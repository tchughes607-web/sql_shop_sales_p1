-- Data Cleaning 

SELECT * 
FROM shop_sales; 

-- cross check rows with excel

SELECT  
    COUNT(*)
FROM shop_sales;

-- find null values 

SELECT * FROM shop_sales;
WHERE transactions_id IS NULL;

SELECT * FROM shop_sales 
WHERE sale_date IS NULL;

SELECT * FROM shop_sales 
WHERE sale_time IS NULL;

-- repeat for each coloumn -- 
-- where NULL value returned -- can delete --

DELETE FROM shop_sales 
WHERE 
transactions_id IS NULL
OR
sale_date IS NULL 
OR 
sale_time IS NULL; 

-- inlcude all rows with NULL Values -- 

-- Data Exploration 
-- How many sales we have?

SELECT COUNT(*) as total_sale
FROM shop_sales;

-- How many customers we have? 

SELECT COUNT(customer_id) as total_sale 
FROM shop_sales;

-- How many unique customers do we have? 

SELECT COUNT(DISTINCT customer_id) 
	as total_sale
FROM shop_sales;

-- How many unique categories do we have?

SELECT COUNT(DISTINCT category) 
	as total_sale
FROM shop_sales;

-- Category Names?

SELECT DISTINCT category 
FROM shop_sales;

-- DATA Analysis and Business Key Problems & Answers 
-- Q1 Write an SQL Query to retrieve all columns for sale made on '2022-11-05';

SELECT *
FROM shop_sales
WHERE sale_date = '2022-11-05';

-- Q2;

SELECT category, 
SUM(quantity)
FROM shop_sales
WHERE category = 'Clothing'
GROUP BY 1;
 
 
 SELECT *
FROM shop_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantity >=4;

-- Q3;

SELECT* FROM shop_sales;

SELECT 
	category,
    SUM(total_sale) as net_sales
FROM shop_sales
GROUP BY category;

SELECT 
	category,
    SUM(total_sale) as net_sales,
    COUNT(*) as total_orders
FROM shop_sales
GROUP BY category;

-- Q4 

SELECT* FROM shop_sales;

SELECT*
FROM shop_sales
WHERE category = 'Beauty';

SELECT
	AVG(age) as Average_Age
FROM shop_sales
WHERE category = 'Beauty';

SELECT
	ROUND(AVG(age), 2) as Average_Age
FROM shop_sales
WHERE category = 'Beauty';

-- Q5 

SELECT* FROM shop_sales;

SELECT* FROM shop_sales
WHERE total_sale > 1000;

-- Q6 

SELECT* FROM shop_sales;

SELECT 
	category,
    gender,
COUNT(*) as Total_Trans
FROM shop_sales
GROUP BY category,
		gender
ORDER BY category;

-- Q7 

SELECT 
YEAR(sale_date) as Year,
MONTH(sale_date) as Month,
AVG(total_sale) as avg_sale
FROM shop_sales
GROUP BY Year, Month
ORDER BY Year, Month, avg_sale DESC;

SELECT 
YEAR(sale_date) as Year,
MONTH(sale_date) as Month,
AVG(total_sale) as avg_sale
FROM shop_sales
GROUP BY Year, Month
ORDER BY Year, avg_sale DESC;


SELECT 
YEAR(sale_date) as Year,
MONTH(sale_date) as Month,
AVG(total_sale) as avg_sale,
	RANK () OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as Best
FROM shop_sales
GROUP BY Year, Month;

SELECT* FROM
(
	SELECT 
	YEAR(sale_date) as Year,
	MONTH(sale_date) as Month,
	AVG(total_sale) as avg_sale,
		RANK () OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as best
	FROM shop_sales
	GROUP BY Year, Month
) as T1
WHERE best = 1
;

SELECT
	Year, Month, avg_sale
FROM 
(
	SELECT 
	YEAR(sale_date) as Year,
	MONTH(sale_date) as Month,
	AVG(total_sale) as avg_sale,
		RANK () OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as best
	FROM shop_sales
	GROUP BY Year, Month
) as T1
WHERE best = 1
;

-- Q8 

SELECT* FROM shop_sales;

SELECT 
	customer_id,
    SUM(total_sale) as Total_Sales
FROM shop_sales
GROUP BY customer_id
ORDER BY Total_sales DESC
LIMIT 5;


-- Q9 

SELECT* FROM shop_sales;

SELECT 
	category,
    COUNT(customer_id)
FROM shop_sales
GROUP BY category;

SELECT 
	category,
    COUNT(DISTINCT customer_id) as unique_customers
FROM shop_sales
GROUP BY category;

-- Q10 

SELECT* FROM shop_sales;

SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END as shift
FROM shop_sales;


WITH hourly_sales
AS
(
SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END as shift
FROM shop_sales
)
SELECT 
shift,
COUNT(*) as total_orders
FROM hourly_sales
GROUP BY shift;


-- END OF PROJECT 