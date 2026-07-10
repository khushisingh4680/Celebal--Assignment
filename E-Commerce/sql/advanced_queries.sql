<?xml version="1.0" encoding="UTF-8"?><sqlb_project><db path="C:/Users/khush/Desktop/Week-8 Assignment/E-Commerce/database/ecommerce.db" readonly="0" foreign_keys="1" case_sensitive_like="0" temp_store="0" wal_autocheckpoint="1000" synchronous="2"/><attached/><window><main_tabs open="structure browser pragmas query" current="3"/></window><tab_structure><column_width id="0" width="300"/><column_width id="1" width="0"/><column_width id="2" width="100"/><column_width id="3" width="878"/><column_width id="4" width="0"/><expanded_item id="0" parent="1"/><expanded_item id="1" parent="1"/><expanded_item id="2" parent="1"/><expanded_item id="3" parent="1"/></tab_structure><tab_browse><table title="customers" custom_title="0" dock_id="1" table="4,9:maincustomers"/><dock_state state="000000ff00000000fd00000001000000020000000000000000fc0100000001fb000000160064006f0063006b00420072006f00770073006500310100000000ffffffff0000011800ffffff000000000000000000000004000000040000000800000008fc00000000"/><default_encoding codec=""/><browse_table_settings/></tab_browse><tab_sql><sql name="SQL 1*">SELECT
    o.order_date,
    SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) AS daily_revenue,
    SUM(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)))
        OVER (ORDER BY o.order_date) AS running_total
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE oi.quantity &gt; 0
GROUP BY o.order_date
ORDER BY o.order_date;

SELECT *
FROM (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) AS total_spent,
        DENSE_RANK() OVER (
            ORDER BY SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) DESC
        ) AS customer_rank
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE oi.quantity &gt; 0
    GROUP BY c.customer_id, c.customer_name
)
WHERE customer_rank &lt;= 3;

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue
FROM (
    SELECT
        strftime('%Y-%m', order_date) AS month,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE oi.quantity &gt; 0
    GROUP BY month
);

SELECT
    product_id,
    revenue,
    NTILE(4) OVER (ORDER BY revenue DESC) AS revenue_quartile
FROM (
    SELECT
        product_id,
        SUM(quantity * unit_price) AS revenue
    FROM order_items
    WHERE quantity &gt; 0
    GROUP BY product_id
);

WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) AS revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE oi.quantity &gt; 0
    GROUP BY c.customer_id, c.customer_name
)
SELECT *
FROM CustomerRevenue
WHERE revenue &gt; 10000;

SELECT
    o.customer_id,
    MIN(o.order_date) AS first_purchase,
    MAX(o.order_date) AS last_purchase
FROM orders o
GROUP BY o.customer_id;

SELECT
    oi1.product_id AS product1,
    oi2.product_id AS product2,
    COUNT(*) AS frequency
FROM order_items oi1
JOIN order_items oi2
ON oi1.order_id = oi2.order_id
AND oi1.product_id &lt; oi2.product_id
GROUP BY product1, product2
ORDER BY frequency DESC
LIMIT 10;

SELECT
    strftime('%Y-%m', registration_date) AS cohort_month,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY cohort_month
ORDER BY cohort_month;

SELECT
    strftime('%Y', order_date) AS year,
    SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE oi.quantity &gt; 0
GROUP BY year
ORDER BY year;</sql><current_tab id="0"/></tab_sql></sqlb_project>
