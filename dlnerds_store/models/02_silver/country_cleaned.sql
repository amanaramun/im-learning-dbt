with cte_read_country AS (
SELECT DISTICNT
    Code as country_code,
    Name as country_name
FROM {{ source('file_system','country_raw') }}
),

cte_cast_as_country AS(
SELECT
    CAST(coutnry_code as STRING) as country_code,
    CAST(country_name as STRING) as country_name
FROM cte_read_country
)

SELECT * FROM cte_read_country