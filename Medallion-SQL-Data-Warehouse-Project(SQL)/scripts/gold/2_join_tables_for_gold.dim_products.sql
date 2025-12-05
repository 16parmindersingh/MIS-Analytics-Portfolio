USE DataWarehouse;

-- 2. Join Tables 'silver.crm_prd_info' and 'silver.erp_px_cat_g1v2'

SELECT 
	pn.prd_id,
	pn.cat_id,
	pn.prd_key,
	pn.prd_nm,
	pn.prd_cost,
	pn.prd_line,
	pn.prd_start_dt,
	pc.cat,
	pc.subcat,
	pc.maintenance
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL; -- Filter out all historical data

/*
RESULT:
prd_id	cat_id	prd_key	prd_nm					prd_cost	prd_line	prd_start_dt	cat	subcat						maintenance
478		AC_BC	BC-M005	Mountain Bottle Cage	4			Mountain	2013-07-01		Accessories	Bottles and Cages	No
479		AC_BC	BC-R205	Road Bottle Cage		3			Road		2013-07-01		Accessories	Bottles and Cages	No
*/

-- (i) CHECKING IF ANY DUPLICATES AFTER JOIN

SELECT prd_key, COUNT(*) FROM(
SELECT 
	pn.prd_id,
	pn.cat_id,
	pn.prd_key,
	pn.prd_nm,
	pn.prd_cost,
	pn.prd_line,
	pn.prd_start_dt,
	pc.cat,
	pc.subcat,
	pc.maintenance
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL -- Filter out all historical data
)t GROUP BY prd_key
HAVING COUNT (*) >1;

-- RESULT: NO DUPLICATES




--			• Rename the columns to friendly, meaningful names
--			• Add 'product_key' column holding Serial Numbers.


SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key, -- Surrogate key
    pn.prd_id       AS product_id,
    pn.prd_key      AS product_number,
    pn.prd_nm       AS product_name,
    pn.cat_id       AS category_id,
    pc.cat          AS category,
    pc.subcat       AS subcategory,
    pc.maintenance  AS maintenance,
    pn.prd_cost     AS cost,
    pn.prd_line     AS product_line,
    pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL; -- Filter out all historical data