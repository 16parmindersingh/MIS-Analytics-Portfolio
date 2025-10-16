USE DataWarehouse;

-- 3. Check Table bronze.crm_sales_details Data

SELECT TOP (1000) [sls_ord_num]
	,[sls_prd_key]
	,[sls_cust_id]
	,[sls_order_dt]
	,[sls_ship_dt]
	,[sls_due_dt]
	,[sls_sales]
	,[sls_quantity]
	,[sls_price]
FROM [DataWarehouse].[bronze].[crm_sales_details]

-- (i) Check for Invalid Dates

SELECT sls_order_dt
FROM bronze.crm_sales_details;

-- Result all the dates are integers
-- sls_order_dt
-- 20101229

SELECT sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0;

-- Result: Many values are 0

SELECT sls_order_dt
FROM bronze.crm_sales_details
WHERE LEN(sls_order_dt) != 8
	OR sls_order_dt > 20500101
	OR sls_order_dt < 19000101;

-- Result: 32154 , 5489

SELECT 
CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
	ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
END AS sls_order_dt
FROM bronze.crm_sales_details;

-- Result: ALL 0, 32154,  5489 values are replaced with NULL and then all the integers are cast as Date 
-- sls_order_dt
-- 2010-12-29
-- 2010-12-30

-- We do the the same for the sls_ship_dt and sls_due_dt as well

SELECT 
CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
	ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
END AS sls_ship_dt
FROM bronze.crm_sales_details;

-----

SELECT 
CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
	ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
END AS sls_due_dt
FROM bronze.crm_sales_details;


-- Check for Invalid Date Orders

SELECT
*
FROM
bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_due_dt > sls_due_dt;

-- Result: No mistakes found

-- (ii) Check Data Consistency: Between Sales, Quantity, and Price
-- >> Sales = Quantity * Price
-- >> Values must not be Null, Zero, or Negative.

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL 
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

/*
Result: Many Values are Null, negative and calculations are wrong.

sls_sales	sls_quantity	sls_price
NULL		1				35
-54			1				54
-35			1				35
*/


SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price <=0
	THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price
END AS sls_price
FROM bronze.crm_sales_details;

/*
RESULT: Now everthing is rectified

old_sls_sales	sls_quantity	old_sls_price	sls_sales	sls_price
25				3				25				75			25
-35				1				35				35			35
*/


-- (i) Correcting Invalid Dates
-- (ii) Data Consistency: Between Sales, Quantity, and Price
-- >> Sales = Quantity * Price
-- >> Values must not be Null, Zero, or Negative.


SELECT
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
	ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
END AS sls_order_dt,
CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
	ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
END AS sls_ship_dt,
CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
	ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
END AS sls_due_dt,
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price <=0
	THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price
END AS sls_price
FROM bronze.crm_sales_details;
