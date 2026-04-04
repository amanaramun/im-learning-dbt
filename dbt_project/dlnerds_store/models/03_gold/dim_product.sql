WITH cte_read_product AS(
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
FROM {{ ref('product_cleaned') }} 
),

{% set tiers = [
        {'min': 0, 'max': 29.99, "name":'low'},
        {'min': 30, 'max': 59.99, "name":'medium'},
        {'min': 60, 'max': 199.99, "name":'high'},

] %} 

cte_transform_product AS (
SELECT
    id,
    name,
    code,
    category,
    price,
    currency,
    CASE 
        {% for tier in tiers %}
        WHEN price
            BETWEEN {{ tier.min }}
            AND {{ tier.max }}
            THEN '{{ tier.name }}' 
        {% endfor %}
        ELSE null
    END as tiers,
    color,
    created_at,
    updated_at
FROM cte_read_product
)

SELECT * FROM cte_transform_product
