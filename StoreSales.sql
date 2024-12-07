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

# Los 5 estados con mayores ventas
CREATE VIEW five_ranking_MAX AS
SELECT state, ROUND(SUM(sales)) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 5;

# Me interesa saber que estados son los que menos ventas tienen por subcategoria
CREATE VIEW subcategory_state_sale_MIN AS
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
