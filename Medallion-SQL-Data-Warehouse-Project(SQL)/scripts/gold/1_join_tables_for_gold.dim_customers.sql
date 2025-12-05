USE DataWarehouse;

-- 1. Join Tables 'silver.crm_cust_info', 'silver.erp_cust_az12' and 'silver.erp_loc_a101'

SELECT 
	ci.cst_id,
	ci.cst_key,
	ci.cst_firstname,
	ci.cst_lastname,
	ci.cst_marital_status,
	ci.cst_gndr,
	ci.cst_create_date,
	ca.bdate,
	ca.gen,
	la.cntry
FROM silver.crm_cust_info ci

LEFT JOIN silver.erp_cust_az12 ca
ON		  ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON		  ci.cst_key = la.cid;

/*
RESULT:
cst_id	cst_key		cst_firstname	cst_lastname	cst_marital_status	cst_gndr	cst_create_date			bdate		gen		cntry
11000	AW00011000	Jon				Yang			Married				Male		2025-10-06				1971-10-06	Male	Australia
*/

-- (i) CHECKING IF ANY DUPLICATES AFTER JOIN

SELECT cst_id, COUNT(*) FROM
(SELECT 
	ci.cst_id,
	ci.cst_key,
	ci.cst_firstname,
	ci.cst_lastname,
	ci.cst_marital_status,
	ci.cst_gndr,
	ci.cst_create_date,
	ca.bdate,
	ca.gen,
	la.cntry
FROM silver.crm_cust_info ci

LEFT JOIN silver.erp_cust_az12 ca
ON		  ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON		  ci.cst_key = la.cid
)t GROUP BY cst_id
HAVING COUNT(*) > 1;

-- RESULT: NO DUPLICATES

-- (ii) Data Integration as after joining the tables we are getting two columns 'cst_gndr' AND 'gen' for gender

SELECT 
	ci.cst_gndr,
	ca.gen
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON		  ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON		  ci.cst_key = la.cid
ORDER BY 1,2 ;

/*
Result:

cst_gndr	gen
Female		n/a
Female		Male
Male		n/a
Male		Female
n/a			Null
*/

-- As Master Source of Customer Data is CRM we take 'cst_gndr' value in 'gen'



SELECT 
	ci.cst_gndr,
	ca.gen,CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the Master for gender info
		ELSE COALESCE(ca.gen, 'n/a')
	END AS new_gen
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON		  ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON		  ci.cst_key = la.cid
ORDER BY 1,2;

-- Result: Now everything good in 'new_gen' column



--		(i) Join Tables without any duplicate values
--		(ii) Data Integration:Clubbing two columns 'cst_gndr' AND 'gen' 'into new_gen'
--			• Rename the columns to friendly, meaningful names
--			• Add 'customer_key' column holding Serial Numbers.


SELECT
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key, -- Surrogate key
    ci.cst_id                          AS customer_id,
    ci.cst_key                         AS customer_number,
    ci.cst_firstname                   AS first_name,
    ci.cst_lastname                    AS last_name,
    la.cntry                           AS country,
    ci.cst_marital_status              AS marital_status,
    CASE 
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the primary source for gender
        ELSE COALESCE(ca.gen, 'n/a')  			   -- Fallback to ERP data
    END                                AS gender,
    ca.bdate                           AS birthdate,
    ci.cst_create_date                 AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
    ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
    ON ci.cst_key = la.cid;
