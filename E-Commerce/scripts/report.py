import sqlite3
import pandas as pd
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATABASE = os.path.join(BASE_DIR, "database", "ecommerce.db")


def generate_report(start_date, end_date):

    conn = sqlite3.connect(DATABASE)

    # Total Orders
    total_orders = pd.read_sql_query(f"""
        SELECT COUNT(*) AS total_orders
        FROM orders
        WHERE DATE(order_date)
        BETWEEN '{start_date}' AND '{end_date}';
    """, conn)

    # Total Revenue
    revenue = pd.read_sql_query(f"""
        SELECT ROUND(SUM(oi.quantity * oi.unit_price *
        (1 - oi.discount_percent/100)),2) AS revenue
        FROM orders o
        JOIN order_items oi
        ON o.order_id = oi.order_id
        WHERE DATE(o.order_date)
        BETWEEN '{start_date}' AND '{end_date}'
        AND oi.quantity > 0;
    """, conn)

    # Unique Customers
    customers = pd.read_sql_query(f"""
        SELECT COUNT(DISTINCT customer_id)
        AS unique_customers
        FROM orders
        WHERE DATE(order_date)
        BETWEEN '{start_date}' AND '{end_date}';
    """, conn)

    # Top 3 Products
    top_products = pd.read_sql_query(f"""
        SELECT
            p.product_name,
            SUM(oi.quantity) AS quantity_sold
        FROM order_items oi
        JOIN orders o
        ON oi.order_id = o.order_id
        JOIN products p
        ON oi.product_id = p.product_id
        WHERE DATE(o.order_date)
        BETWEEN '{start_date}' AND '{end_date}'
        GROUP BY p.product_name
        ORDER BY quantity_sold DESC
        LIMIT 3;
    """, conn)

    conn.close()

    return total_orders, revenue, customers, top_products