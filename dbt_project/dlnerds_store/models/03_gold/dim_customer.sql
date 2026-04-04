WITH cte_read_customer AS (
SELECT
    id,
    name,
    gender,
    date_of_birth,
    email,
    country_code,
    city,
    created_at,
    updated_at
FROM {{ ref('customer_cleaned' )}}
),

cte_read_country AS (
SELECT 
    country_code,
    country_name
FROM {{ ref('country_cleaned')}}
),

cte_transform_customer AS (
SELECT
    id,
    SPLIT_PART(name,' ', 1) AS first_name,
    SPLIT_PART(name,' ', 2) AS last_name,
    gender,
    date_of_birth,
    email,
    country_code,
    city,
    created_at,
    updated_at
FROM cte_read_customer    
),

cte_join_customer_country AS (
SELECT
    customer.id,
    customer.first_name,
    customer.last_name,
    customer.gender,
    customer.date_of_birth,
    customer.email,
    customer.country_code,
    country.country_name,
    customer.city,
    customer.created_at,
    customer.updated_at
FROM cte_transform_customer AS customer
LEFT JOIN cte_read_country AS country
ON customer.country_code = country.country_code
)

SELECT * FROM cte_join_customer_country
