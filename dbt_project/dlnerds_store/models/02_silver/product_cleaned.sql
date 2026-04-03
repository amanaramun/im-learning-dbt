WITH cte_read_product AS (
SELECT
    id,
    name,
    code,
    category,
    price,
    currency,
    color,
    created_at,
    updated_at
FROM {{ source('file_system', 'product_raw') }}
),

cte_cast_product AS (
SELECT 
    CAST(id AS STRING) AS id,
    CAST(name AS STRING) AS name,
    CAST(code AS STRING) AS code,
    CAST(category AS STRING) AS category,
    CAST(price AS FLOAT) AS price,
    CAST(currency AS STRING) AS currency,
    CAST(color AS STRING) AS color,
    CAST(created_at AS TIMESTAMP) AS created_at,
    CAST(updated_at AS TIMESTAMP) AS updated_at
FROM cte_read_product
),

cte_clean_product AS (
SELECT 
    id,
    replace(name, '_', ' ') AS name,
    code,
    category,
    price,
    currency,
    LOWER(color) AS color,
    created_at,
    updated_at
FROM cte_cast_product
)

SELECT * FROM cte_clean_product