USE DataWarehouse;

-- 3. Join Tables 'silver.crm_sales_details', gold.dim_customers and 'gold.dim_products'

SELECT *
FROM silver.crm_sales_details

/*
Result:

sls_ord_num	sls_prd_key	sls_cust_id	sls_order_dt	sls_ship_dt	sls_due_dt	sls_sales	sls_quantity	sls_price	dwh_create_date
SO43697		BK-R93R-62	21768		2010-12-29		2011-01-05	2011-01-10	3578		1				3578		2025-10-15 17:04:00.9700000
*/


--  (i) Use the dimension's surrogate keys instead of IDs to easily connect facts with dimension
--		• Replace 'silver.crm_sales_details' coulmn 'sls_cust_id' with 'gold.dim_customers' column 'customer_id'
--      • Replace 'silver.crm_sales_details' coulmn 'sls_prd_key' with 'gold.dim_products' column 'product_number'sls_prd_key with  gold.dim_products
--      • Rename the columns to friendly, meaningful names


SELECT
    sd.sls_ord_num,
    pr.product_key,
    cu.customer_key,
    sd.sls_order_dt,
    sd.sls_ship_dt,
    sd.sls_due_dt,
    sd.sls_sales,
    sd.sls_quantity,
    sd.sls_price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id;
