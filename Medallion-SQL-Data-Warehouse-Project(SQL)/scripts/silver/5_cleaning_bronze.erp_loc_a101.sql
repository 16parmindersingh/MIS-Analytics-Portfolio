USE DataWarehouse;

-- 5. Check Table bronze.erp_loc_a101 Data

SELECT 
cid,
cntry
FROM bronze.erp_loc_a101;

/*
Result:
cid	cntry
AW-00011000	Australia
*/

-- (i) Get rid of all the '-' in cid column after AW

SELECT 
REPLACE(cid, '-', '') AS cid
FROM bronze.erp_loc_a101;

/*
Result:
cid	cntry
AW00011000	Australia
*/

-- (ii) Data Standardization & Consistency

SELECT DISTINCT cntry
FROM bronze.erp_loc_a101
ORDER BY cntry;

/*
Result:

cntry
NULL
  
Australia
Canada
DE
France
Germany
United Kingdom
United States
US
USA
*/

SELECT DISTINCT
CASE
	WHEN UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
	WHEN UPPER(TRIM(cntry)) IN ('US', 'USA') THEN 'United States'
	WHEN UPPER(TRIM(cntry)) = '' OR cntry IS NULL THEN 'n/a'
	ELSE cntry
END AS cntry
FROM bronze.erp_loc_a101
ORDER BY cntry;

/*
Result:

cntry
Australia
Canada
France
Germany
n/a
United Kingdom
United States
*/

--			(i)		Get rid of all the '-' in cid column after AW
--			(ii)	Data Standardization & Consistency


SELECT
REPLACE(cid, '-', '') AS cid,
CASE
	WHEN UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
	WHEN UPPER(TRIM(cntry)) IN ('US', 'USA') THEN 'United States'
	WHEN UPPER(TRIM(cntry)) = '' OR cntry IS NULL THEN 'n/a'
	ELSE cntry
END AS cntry
FROM bronze.erp_loc_a101;