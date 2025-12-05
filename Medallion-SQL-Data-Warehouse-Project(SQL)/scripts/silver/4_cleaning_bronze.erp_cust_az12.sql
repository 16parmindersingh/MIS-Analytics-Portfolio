USE DataWarehouse;

-- 4. Check Table bronze.erp_cust_az12 Data

SELECT
cid,
bdate,
gen
FROM bronze.erp_cust_az12;

/*
Result:
cid				bdate		gen
NASAW00011000	1971-10-06	Male
AW00026288		1978-11-07	Female
*/
-- (i) Removing unnecessary NAS from cid column value

SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
	ELSE cid
END AS cid
FROM bronze.erp_cust_az12;

/*
Result:
cid	
AW00011000
AW00026288
*/

-- (ii) Identify Out-Of-Range Dates

SELECT DISTINCT
bdate
FROM bronze.erp_cust_az12
WHERE bdate > GETDATE();

/*
Result: Many Dates are Out-Of-Range 

bdate
2038-10-17
2065-12-12
*/

SELECT
CASE WHEN bdate > GETDATE() THEN NULL
	ELSE bdate
END AS bdate
FROM bronze.erp_cust_az12;

-- Result: all the Dates are in range now



-- (iii) Data Standardization & Consistency

SELECT DISTINCT gen
FROM bronze.erp_cust_az12;

/*
Result:

gen
NULL
F 
  
Male
Female
M 

*/

SELECT DISTINCT
CASE
	WHEN UPPER(TRIM(gen)) IN ('F', 'Female') THEN 'Female'
	WHEN UPPER(TRIM(gen)) IN ('M', 'Male')THEN 'Male'
	ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12;

/*
Result:

gen
Male
n/a
Female
*/

--		(i)		Removing unnecessary NAS from cid column value
--		(ii)	Making Dates in the Range
--		(iii)	Data Standardization & Consistency


SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
	ELSE cid
END AS cid,
CASE WHEN bdate > GETDATE() THEN NULL
	ELSE bdate
END AS bdate,
CASE
	WHEN UPPER(TRIM(gen)) IN ('F', 'Female') THEN 'Female'
	WHEN UPPER(TRIM(gen)) IN ('M', 'Male')THEN 'Male'
	ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12;