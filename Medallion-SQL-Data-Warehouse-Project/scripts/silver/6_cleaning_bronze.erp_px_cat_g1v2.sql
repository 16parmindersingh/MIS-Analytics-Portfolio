USE DataWarehouse;

-- 6. Check Table bronze.erp_px_cat_g1v2 Data

SELECT 
id,
cat,
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2;

/*
Result:

id		cat	subcat		maintenance
AC_BR	Accessories		Bike Racks	Yes
AC_BS	Accessories		Bike Stands	No
AC_BC	Accessories		Bottles and Cages	No
*/

-- (i) Check For Unwanted Spaces

SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

-- Result: Everything is fine

-- (ii) Data Standardization & Consistency

SELECT DISTINCT id
FROM bronze.erp_px_cat_g1v2;

-- Result: Everything is fine

SELECT DISTINCT cat
FROM bronze.erp_px_cat_g1v2;

-- Result: Everything is fine

SELECT DISTINCT subcat
FROM bronze.erp_px_cat_g1v2;

-- Result: Everything is fine

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2;

-- Result: Everything is fine