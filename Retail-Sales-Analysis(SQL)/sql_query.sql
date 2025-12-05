-- SQL Retail Sales Analysis

CREATE DATABASE RetailSalesDB;

USE RetailSalesDB;

-- Create TABLE

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

-- import table content from raw data csv file (Note- in retails_sales.csv sale_date format is dd-mm-yy)

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/retail_sales.csv'
INTO TABLE retail_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(transaction_id, @sale_date, sale_time, customer_id, gender, age, category, quantity, price_per_unit, cogs, total_sale)
SET sale_date = STR_TO_DATE(@sale_date, '%d-%m-%y');

SELECT * FROM retail_sales
LIMIT 10;

SELECT 
    COUNT(*) 
FROM retail_sales;

-- Result: 1987

-- Data Cleaning

SELECT 
    *
FROM
    retail_sales
WHERE
    transaction_id IS NULL;

-- Result 0 null values

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date IS NULL;
    
-- Result 0 null values

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_time IS NULL;

-- Result 0 null values

SELECT 
    *
FROM
    retail_sales
WHERE
    transaction_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;
        
-- Result 0 null values

DELETE FROM retail_sales 
WHERE
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
    
-- Result 0 rows affected

-- Data Exploration

-- How many sales we have?

SELECT 
    COUNT(*) AS total_sale
FROM
    retail_sales;

-- Result: 1987

-- How many uniuque customers we have ?

SELECT 
    COUNT(DISTINCT customer_id) AS total_sale
FROM
    retail_sales;

-- Result: 155

-- How many uniuque customers we have ?

SELECT DISTINCT category FROM retail_sales;
-- Result - Beauty, Clothing, Electronics

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



 -- Q.1 Write a SQL query to retrieve all columns for sales made on '22-11-2022'

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';

-- Result:
-- transaction_id	sale_date	sale_time	customer_id	gender	age	category	quantity	price_per_unit	cogs	total_sale
-- 180				2022-11-05	10:47:00	117			Male	41	Clothing	3			300				129		900
-- 214				2022-11-05	16:31:00	53			Male	20	Beauty		2			30				8.1		60
-- 240				2022-11-05	11:49:00	95			Female	23	Beauty		1			300				123		300
-- 856				2022-11-05	17:43:00	102			Male	54	Electronics	4			30				9.3		120
-- 943				2022-11-05	19:29:00	90			Female	57	Clothing	4			300				318		1200
-- 1137				2022-11-05	22:34:00	104			Male	46	Beauty		2			500				145		1000
-- 1256				2022-11-05	09:58:00	29			Male	23	Clothing	2			500				190		1000
-- 1265				2022-11-05	14:35:00	86			Male	55	Clothing	3			300				111		900
-- 1587				2022-11-05	20:06:00	140			Female	40	Beauty		4			300				105		1200
-- 1819				2022-11-05	20:44:00	83			Female	35	Beauty		2			50				13.5	100
-- 1896				2022-11-05	20:19:00	87			Female	30	Electronics	2			25				30.75	50


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing'
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
        AND quantity >= 4;

-- Result:
-- transaction_id	sale_date	sale_time	customer_id	gender	age	category	quantity	price_per_unit	cogs	total_sale
-- 64				2022-11-15	06:34:00	7			Male	49	Clothing	4			25				8.5		100
-- 146				2022-11-10	22:01:00	74			Male	38	Clothing	4			50				49		200
-- 159				2022-11-10	21:30:00	42			Male	26	Clothing	4			50				23.5	200
-- 284				2022-11-12	09:17:00	129			Male	43	Clothing	4			50				20.5	200
-- 547				2022-11-14	07:36:00	3			Male	63	Clothing	4			500				250		2000
-- 699				2022-11-21	22:21:00	129			Female	37	Clothing	4			30				16.2	120
-- 735				2022-11-26	21:38:00	153			Female	64	Clothing	4			500				515		2000
-- 943				2022-11-05	19:29:00	90			Female	57	Clothing	4			300				318		1200
-- 965				2022-11-27	21:45:00	84			Male	22	Clothing	4			50				13		200
-- 1259				2022-11-03	17:31:00	105			Female	45	Clothing	4			50				21		200
-- 1296				2022-11-26	20:42:00	45			Female	22	Clothing	4			300				342		1200
-- 1476				2022-11-11	22:27:00	130			Female	27	Clothing	4			500				555		2000
-- 1484				2022-11-23	09:29:00	22			Female	19	Clothing	4			300				147		1200
-- 1497				2022-11-19	21:44:00	109			Male	41	Clothing	4			30				32.4	120
-- 1615				2022-11-17	13:43:00	82			Female	61	Clothing	4			25				13.5	100
-- 1696				2022-11-21	17:59:00	24			Female	50	Clothing	4			50				55		200
-- 1885				2022-11-09	07:32:00	148			Female	52	Clothing	4			30				10.8	120

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY 1;

-- Result
-- category		net_sale	total_orders
-- Beauty		286790		611
-- Clothing		309995		698
-- Electronics	311445		678

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM
    retail_sales
WHERE
    category = 'Beauty';

-- Result: avg_age - 40.42

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;

-- Result:
-- transaction_id	sale_date	sale_time	customer_id	gender	age	category	quantity	price_per_unit	cogs	total_sale
-- 13				2023-02-08	17:43:00	106			Male	22	Electronics	3			500				245		1500
-- 15				2022-07-01	11:50:00	75			Female	42	Electronics	4			500				210		2000
-- 16				2022-06-25	10:33:00	82			Male	19	Clothing	3			500				180		1500
-- 31				2023-12-31	17:47:00	3			Male	44	Electronics	4			300				129		1200
-- 
--
-- 1956 			2023-06-01 	20:40:00 	62 			Male 	30	Clothing 	3 			500 			170 	1500
-- 1970 			2023-05-22 	17:44:00 	5 			Male 	59 	Electronics 4 			500 			230 	2000



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

-- Result:
-- category		gender	total_trans
-- Beauty		Female	330
-- Beauty		Male	281
-- Clothing		Female	347
-- Clothing		Male	351
-- Electronics	Female	335
-- Electronics	Male	343

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year	

SELECT 
    year,
    month,
    round(avg_sale, 2) AS avg_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS r
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE r = 1;

-- Result:
-- year		month	avg_sale
-- 2022		7		541.34
-- 2023		2		535.53
    

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id, SUM(total_sale) AS total_sales
FROM
    retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Result:
-- customer_id	total_sales
-- 3			38440
-- 1			30750
-- 5			30405
-- 2			25295
-- 4			23580

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT 
    category, COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM
    retail_sales
GROUP BY category;

-- Result:
-- category		cnt_unique_cs
-- Beauty		141
-- Clothing		149
-- Electronics	144

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

-- Result:
-- shift		total_orders
-- Evening		1062
-- Morning		548
-- Afternoon	377


-- End of project

