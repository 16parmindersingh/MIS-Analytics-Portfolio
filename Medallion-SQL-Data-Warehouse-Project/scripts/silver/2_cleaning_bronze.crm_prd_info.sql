USE DataWarehouse;

-- 2. Check Table bronze.crm_prd_info Data

SELECT TOP (1000) [prd_id]
	,[prd_key]
	,[prd_nm]
	,[prd_cost]
	,[prd_line]
	,[prd_start_dt]
	,[prd_end_dt]
FROM [DataWarehouse].[bronze].[crm_prd_info]

-- (i) Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result


SELECT 
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Result - zero duplicate and null values

-- (ii) Compare table 'bronze.crm_cust_info' column 'prd_key' with 'bronze.erp_px_cat_g1v2' column 'id'
--		and 'bronze.crm_sales_details' column sls_prd_key
SELECT DISTINCT id 
FROM bronze.erp_px_cat_g1v2;

/*
Result

id
AC_BC
AC_BR
AC_BS
*/

SELECT DISTINCT sls_prd_key
FROM bronze.crm_sales_details;

/*
Result

sls_prd_key
TI-R982
BK-T79Y-46
BK-R79Y-44
*/

SELECT	DISTINCT prd_key
FROM bronze.crm_prd_info;

/*
Result:

prd_key
AC-BC-BC-M005
AC-BC-BC-R205
AC-BC-WB-H098
*/

-- Take 5 initial characters into new column and apply underscore between them

SELECT
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id
FROM bronze.crm_prd_info;

/*
Result:

cat_id
CO_RF
CO_RF
AC_HE
*/

-- Take last characters from 7th into new column and apply underscore between them

SELECT
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key
FROM bronze.crm_prd_info;


-- Inluding these new id columns to the whole table

SELECT prd_id
	,prd_key
	,REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id
	,SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key
	,prd_nm
	,prd_cost
	,prd_line
	,prd_start_dt
	,prd_end_dt
FROM bronze.crm_prd_info

-- (iii) Check For Unwanted Spaces
-- Expectation: No Results

SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Result: Zero Values has unwanted space

-- (iv) Check For Nulls or Negative Numbers
-- Expectation: No Results

SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Result: 2 values are null
-- So we replace them with 0

SELECT ISNULL(prd_cost, 0) AS prd_cost
FROM bronze.crm_prd_info;

-- (v) DATA STANDARDIZATION & CONSISTENCY
-- Expectation: Readable Format

SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;

/*
RESULT:

prd_line
NULL
M 
R 
S 
T 
*/


SELECT 
CASE UPPER(TRIM(prd_line))
	WHEN 'M' THEN 'Mountain'
	WHEN 'R' THEN 'Road'
	WHEN 'S' THEN 'other Sale'
	WHEN 'T' THEN 'Touring'
	ELSE 'n/a'
END AS prd_line
FROM bronze.crm_prd_info;

-- (vi) Check for Invalid Date Orders
-- Expectation: prd_start_dt and prd_end_dt well organised and understandable

SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

/*
Result:
prd_id	prd_key				prd_nm					prd_cost	prd_line	prd_start_dt				prd_end_dt
212		AC-HE-HL-U509-R		Sport-100 Helmet- Red	12			S 			2011-07-01 00:00:00.000		2007-12-28 00:00:00.000
213		AC-HE-HL-U509-R		Sport-100 Helmet- Red	14			S 			2012-07-01 00:00:00.000		2008-12-27 00:00:00.000
*/

SELECT 
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info;

	
/*	
	(i)		Removing Nulls or Duplicates in Primary Key
	(ii)	Compare table 'bronze.crm_cust_info' column 'prd_key' with 'bronze.erp_px_cat_g1v2' column 
			'id' and 'bronze.crm_sales_details' column sls_prd_key
	(iii)	Removing Unwanted Spaces
	(iv)	Removing Nulls or Negative Numbers
	(v)		DATA STANDARDIZATION & CONSISTENCY
	(vi)	Organising Invalid Date Orders
*/


SELECT
			prd_id,
			REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id, -- Extract category ID
			SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,        -- Extract product key
			prd_nm,
			ISNULL(prd_cost, 0) AS prd_cost,
			CASE 
				WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
				WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
				WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
				WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
				ELSE 'n/a'
			END AS prd_line, -- Map product line codes to descriptive values
			CAST(prd_start_dt AS DATE) AS prd_start_dt,
			CAST(
				LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 
				AS DATE
			) AS prd_end_dt -- Calculate end date as one day before the next start date
		FROM bronze.crm_prd_info;