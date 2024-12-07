# Necesito saber cuales estado son los que menores ventas tienen por subcategoria para mi insight
WITH ranked_sales AS (
    SELECT 
        sub_category, 
        state, 
        ROUND(SUM(sales)) AS total_sales,
        ROW_NUMBER() OVER (PARTITION BY sub_category ORDER BY SUM(sales) ASC) AS row_num
    FROM superstore
    GROUP BY sub_category, state
)
SELECT sub_category, state, total_sales
FROM ranked_sales
WHERE row_num = 1
ORDER BY sub_category;
