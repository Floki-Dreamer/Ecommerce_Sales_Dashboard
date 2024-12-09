-- View para de ranking de los estados con mayores ventar por subcategoria
CREATE VIEW ranked_sales_view AS
WITH ranked_sales AS (
    SELECT 
        sub_category, 
        state, 
        ROUND(SUM(sales)) AS total_sales,
        ROW_NUMBER() OVER (PARTITION BY sub_category ORDER BY SUM(sales) ASC) AS row_num,
        -- Agregar unique_id como primary key
        ROW_NUMBER() OVER () AS unique_id
    FROM superstore
    GROUP BY sub_category, state
)
SELECT unique_id, sub_category, state, total_sales
FROM ranked_sales
WHERE row_num = 1
ORDER BY total_sales DESC;
