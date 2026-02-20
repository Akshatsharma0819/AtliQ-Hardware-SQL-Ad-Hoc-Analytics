 use atliq_hardware_db
 # Ques 1
select distinct market
from dim_customers
where region = 'APAC'

# Ques 2
Select segment, COUNT(DISTINCT product_code) AS product_count
FROM dim_products
GROUP BY segment
ORDER BY product_count DESC;

# Ques 3
WITH product_count_2020 AS (
    SELECT COUNT(DISTINCT product_code) AS unique_products_2020
    FROM fact_gross_price
    WHERE fiscal_year = 2020
),
product_count_2021 AS (
    SELECT COUNT(DISTINCT product_code) AS unique_products_2021
    FROM fact_gross_price
    WHERE fiscal_year = 2021
)
SELECT 
    unique_products_2020,
    unique_products_2021,
    ROUND((unique_products_2021 - unique_products_2020) * 100.0 / unique_products_2020, 2) AS percentage_chg
FROM product_count_2020
CROSS JOIN product_count_2021;


#Ques 4
WITH count_2020 AS (
    SELECT 
        p.segment, 
        COUNT(DISTINCT p.product_code) AS product_count_2020
    FROM dim_products p
    JOIN fact_gross_price gp ON p.product_code = gp.product_code
    WHERE gp.fiscal_year = 2020
    GROUP BY p.segment
),
count_2021 AS (
    SELECT 
        p.segment, 
        COUNT(DISTINCT p.product_code) AS product_count_2021
    FROM dim_products p
    JOIN fact_gross_price gp ON p.product_code = gp.product_code
    WHERE gp.fiscal_year = 2021
    GROUP BY p.segment
)
SELECT 
    c20.segment,
    c20.product_count_2020,
    c21.product_count_2021,
    (c21.product_count_2021 - c20.product_count_2020) AS difference
FROM count_2020 c20
JOIN count_2021 c21 ON c20.segment = c21.segment
ORDER BY difference DESC;


#Ques 5
SELECT 
    p.product_code, 
    p.product, 
    gp.gross_price
FROM dim_products p
JOIN fact_gross_price gp ON p.product_code = gp.product_code
WHERE gp.gross_price = (SELECT MAX(gross_price) FROM fact_gross_price)
   OR gp.gross_price = (SELECT MIN(gross_price) FROM fact_gross_price)
ORDER BY gp.gross_price DESC;


#Ques 6
SELECT 
    c.customer_code, 
    c.customer, 
    SUM(s.sold_quantity) AS total_quantity
FROM fact_sales_monthly s
JOIN dim_customers c ON s.customer_code = c.customer_code
WHERE YEAR(s.date) = 2021
GROUP BY c.customer_code, c.customer
ORDER BY total_quantity DESC
LIMIT 5;


#Ques 7
SELECT 
    c.customer_code, 
    c.customer, 
    ROUND(SUM(s.sold_quantity * gp.gross_price), 2) AS total_gross_sales
FROM fact_sales_monthly s
JOIN dim_customers c 
    ON s.customer_code = c.customer_code
JOIN fact_gross_price gp 
    ON s.product_code = gp.product_code 
    AND YEAR(s.date) = gp.fiscal_year
WHERE YEAR(s.date) = 2021
GROUP BY c.customer_code, c.customer
ORDER BY total_gross_sales DESC;


#Ques 8
SELECT 
    MONTHNAME(date) AS month,
    SUM(sold_quantity) AS total_sold
FROM fact_sales_monthly
WHERE YEAR(date) = 2021
GROUP BY MONTHNAME(date)
ORDER BY total_sold DESC
LIMIT 1;


#Ques 9
SELECT 
    c.market, 
    ROUND(SUM(s.sold_quantity * gp.gross_price), 2) AS total_gross_sales
FROM fact_sales_monthly s
JOIN dim_customers c 
    ON s.customer_code = c.customer_code
JOIN fact_gross_price gp 
    ON s.product_code = gp.product_code 
    AND YEAR(s.date) = gp.fiscal_year
WHERE YEAR(s.date) = 2021
GROUP BY c.market
ORDER BY total_gross_sales DESC
LIMIT 1;


#Ques 10
SELECT 
    c.market, 
    ROUND(SUM(s.sold_quantity * gp.gross_price), 2) AS total_gross_sales
FROM fact_sales_monthly s
JOIN dim_customers c 
    ON s.customer_code = c.customer_code
JOIN fact_gross_price gp 
    ON s.product_code = gp.product_code 
    AND YEAR(s.date) = gp.fiscal_year
WHERE YEAR(s.date) = 2021
GROUP BY c.market
ORDER BY total_gross_sales DESC
LIMIT 1;