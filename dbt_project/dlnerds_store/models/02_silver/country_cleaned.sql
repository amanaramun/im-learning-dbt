WITH cte_read_country AS (
SELECT DISTINCT
    Code AS country_code,
    Name AS country_name
FROM {{ source('file_system', 'country_raw') }}
),

cte_cast_country AS (
SELECT 
    CAST(country_code AS STRING) AS country_code,
    CAST(country_name AS STRING) AS country_name
FROM cte_read_country
)

SELECT * FROM cte_cast_country