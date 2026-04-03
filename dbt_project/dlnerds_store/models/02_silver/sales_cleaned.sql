{{ config(
    materialized='incremental',
    incremental_strategy='delete+insert',
    unique_key='id'
) }}

WITH cte_read_sales AS (
SELECT
    customer_id,
    product_id,
    sales_date,
    quantity,
    total_amount,
    currency,
    created_at,
    updated_at
FROM {{ source('file_system', 'sales_raw') }}
WHERE quantity IS NOT NULL
AND total_amount IS NOT NULL
),

cte_cast_sales AS (
SELECT 
    CAST(customer_id AS STRING) AS customer_id,
    CAST(product_id AS STRING) AS product_id,
    CAST(sales_date AS DATE) AS sales_date,
    CAST(quantity AS INTEGER) AS quantity,
    CAST(total_amount AS FLOAT) AS total_amount,
    CAST(currency AS STRING) AS currency,
    CAST(created_at AS TIMESTAMP) AS created_at,
    CAST(updated_at AS TIMESTAMP) AS updated_at
FROM cte_read_sales
),

cte_calculate_sales AS (
SELECT 
    {{ dbt_utils.generate_surrogate_key([
            'customer_id',
            'product_id',
            'sales_date'
    ]) }} AS id,
    customer_id,
    product_id,
    sales_date,
    quantity,
    total_amount,
    currency,
    created_at,
    updated_at
FROM cte_cast_sales
)

SELECT * FROM cte_calculate_sales
{% if is_incremental() %}
WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
{% endif %}