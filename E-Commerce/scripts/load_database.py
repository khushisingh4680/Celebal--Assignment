import pandas as pd
import sqlite3
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

CLEAN_DATA = os.path.join(BASE_DIR, "data", "cleaned")
DATABASE = os.path.join(BASE_DIR, "database", "ecommerce.db")

customers = pd.read_csv(os.path.join(CLEAN_DATA, "customers.csv"))
products = pd.read_csv(os.path.join(CLEAN_DATA, "products.csv"))
orders = pd.read_csv(os.path.join(CLEAN_DATA, "orders.csv"))
order_items = pd.read_csv(os.path.join(CLEAN_DATA, "order_items.csv"))

conn = sqlite3.connect(DATABASE)

customers.to_sql("customers", conn, if_exists="replace", index=False)
products.to_sql("products", conn, if_exists="replace", index=False)
orders.to_sql("orders", conn, if_exists="replace", index=False)
order_items.to_sql("order_items", conn, if_exists="replace", index=False)

conn.close()

print("Database created successfully!")