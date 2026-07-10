<?xml version="1.0" encoding="UTF-8"?><sqlb_project><db path="C:/Users/khush/Desktop/Week-8 Assignment/E-Commerce/database/ecommerce.db" readonly="0" foreign_keys="1" case_sensitive_like="0" temp_store="0" wal_autocheckpoint="1000" synchronous="2"/><attached/><window><main_tabs open="structure browser pragmas query" current="3"/></window><tab_structure><column_width id="0" width="300"/><column_width id="1" width="0"/><column_width id="2" width="100"/><column_width id="3" width="878"/><column_width id="4" width="0"/><expanded_item id="0" parent="1"/><expanded_item id="1" parent="1"/><expanded_item id="2" parent="1"/><expanded_item id="3" parent="1"/></tab_structure><tab_browse><table title="customers" custom_title="0" dock_id="1" table="4,9:maincustomers"/><dock_state state="000000ff00000000fd00000001000000020000000000000000fc0100000001fb000000160064006f0063006b00420072006f00770073006500310100000000ffffffff0000011800ffffff000000000000000000000004000000040000000800000008fc00000000"/><default_encoding codec=""/><browse_table_settings/></tab_browse><tab_sql><sql name="SQL 1*">SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)), 2) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
WHERE oi.quantity &gt; 0
GROUP BY p.category
ORDER BY total_revenue DESC;

SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)), 2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE oi.quantity &gt; 0
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

SELECT
    strftime('%Y-%m', order_date) AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;</sql><current_tab id="0"/></tab_sql></sqlb_project>
