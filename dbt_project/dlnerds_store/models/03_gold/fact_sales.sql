WITH cte_read_sales AS (
SELECT
    id,
    customer_id,
    product_id,
    sales_date,
    quantity,
    total_amount,
    currency,
    created_at,
    updated_at
FROM {{ ref('sales_cleaned') }}
WHERE sales_date >= '{{ var('sales_start_date') }}'
),

cte_transform_sales AS (
SELECT
    id,
    customer_id,
    product_id,
    sales_date,
    EXTRACT(YEAR FROM sales_date) AS sales_year,
    quantity,
    total_amount,
    currency,
    created_at,
    updated_at
FROM cte_read_sales
)

SELECT * FROM cte_transform_sales