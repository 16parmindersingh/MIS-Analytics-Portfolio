USE DataWarehouse;

-- 1. Check Table bronze.crm_cust_info Data

SELECT TOP (1000) [cst_id]
	,[cst_key]
	,[cst_firstname]
	,[cst_lastname]
	,[cst_marital_status]
	,[cst_gndr]
	,[cst_create_date]
FROM [DataWarehouse].[bronze].[crm_cust_info]


-- (i) Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result


SELECT 
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

/*
RESULT
cst_id	(No column name)
29449	2
29473	2
29433	2
NULL	3
29483	2
29466	3
*/

SELECT
*
FROM(
SELECT
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
FROM bronze.crm_cust_info
)t WHERE flag_last = 1;

/*
RESULT - all unique values including 1 null value

cst_id	cst_key		cst_firstname	cst_lastname	cst_marital_status	cst_gndr	cst_create_date	flag_last
NULL	PO25		NULL			NULL			NULL				NULL		NULL			1
11000	AW00011000	 Jon			Yang 			M					M			2025-10-06		1
11001	AW00011001	Eugene			Huang  			S					M			2025-10-06		1
11002	AW00011002	Ruben			Torres			M					M			2025-10-06		1
11003	AW00011003	Christy			Zhu				S					F			2025-10-06		1
*/


-- (ii) Check For Unwanted Spaces
-- Expectation: No Results

SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

/*
RESULT - Many values has spaces

cst_firstname
 Jon
 Elizabeth
  Lauren
*/

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

/*
RESULT - Many values has spaces

cst_lastname
 Torres
  Zhu
 Walker
 */

SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

-- RESULT - No result as no space


-- (iii) DATA STANDARDIZATION & CONSISTENCY
-- Expectation: Readable Format

SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info;

/*
RESULT:

cst_gndr
NULL
F
M
*/

SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info;

/*
RESULT:

cst_marital_status
S
NULL
M
*/

/*
	(i)		Removing Nulls and Duplicates in Primary Key
	(ii)	Removing the Unwanted Spaces
	(iii)	Data Standardization and Consistency
*/

SELECT
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
	WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
	ELSE 'n/a'
END cst_marital_status, -- Normalize marital status values to readable format
CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
	WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	ELSE 'n/a'
END cst_gndr, -- Normalize gender values to readable format
cst_create_date
FROM(
SELECT
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
FROM bronze.crm_cust_info
WHERE cst_id IS NOT NULL
)t WHERE flag_last = 1; -- Select the most recent record per customer