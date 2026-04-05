SELECT *
FROM {{ ref('product_cleaned') }}
WHERE price <= 0