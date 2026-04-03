WITH cte_read_customer AS(
SELECT
    ID AS id,
    Name AS name,
    Gender AS gender,
    dateofbirth AS date_of_birth,
    email AS email,
    country AS country_code,
    city AS city,
    created_at AS created_at,
    updated_at AS updated_at
FROM {{ source('file_system', 'customer_raw')}}
),

cte_clean_customer as (
    CAST(id AS STRING) AS id, 
    CAST(name AS STRING) AS name,
    CAST(gender AS STRING) AS gender,
    CAST(
        strptime(date_of_birth, '%d.%m.%y') AS DATE
        ) AS date_of_birth,
    CAST(email AS STRING) AS email,
    CAST(country_code AS STRING) AS country_code,
    CAST(city AS STRING) AS city, 
    CAST(created_at AS TIMESTAMP) AS created_at,
    CAST(updated_at AS TIMESTAMP) AS updated_at,    
FROM cte_read_customer
)
cte_clean_customer AS(
SELECT  
    id,
    name,
    gender,
    date_of_birth,
    email,
    CASE
        WHEN coutnry_code 
            IS NOT NULL 
            AND country_code != ''
            THEN country_code    
        WHEN city like 'LAS%'
            THEN 'US'
        WHEN city = 'New York'
            THEN 'US'
        WHEN city = 'Stuttgart'
            THEN 'DE'
        ELSE
            NULL
    END as country_code,
    city,
    created_at,
    updated_at
FROM cte_cast_customer
)   

SELECT * FROM cte_clean_customer