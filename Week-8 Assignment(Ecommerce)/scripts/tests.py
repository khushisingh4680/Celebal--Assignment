import pandas as pd
import sqlite3
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

CLEAN_DATA = os.path.join(BASE_DIR, "data", "cleaned")
DATABASE = os.path.join(BASE_DIR, "database", "ecommerce.db")


def test_database_connection():
    print("\n===== Database Connection Test =====")

    if not os.path.exists(DATABASE):
        print("Database not found.")
        return

    conn = sqlite3.connect(DATABASE)
    print("Database connected successfully.")
    conn.close()


def test_missing_values():
    print("\n===== Missing Values Test =====")

    customers = pd.read_csv(os.path.join(CLEAN_DATA, "customers.csv"))
    orders = pd.read_csv(os.path.join(CLEAN_DATA, "orders.csv"))

    print("Missing Emails:", customers["email"].isnull().sum())
    print("Missing Customer IDs:", orders["customer_id"].isnull().sum())


def test_negative_quantity():
    print("\n===== Negative Quantity Test =====")

    order_items = pd.read_csv(os.path.join(CLEAN_DATA, "order_items.csv"))

    negative = order_items[order_items["quantity"] < 0]

    print("Negative Quantity Records:", len(negative))


def test_duplicate_customers():
    print("\n===== Duplicate Customer IDs =====")

    customers = pd.read_csv(os.path.join(CLEAN_DATA, "customers.csv"))

    duplicates = customers["customer_id"].duplicated().sum()

    print("Duplicate Customer IDs:", duplicates)


def test_invalid_discount():
    print("\n===== Invalid Discount Test =====")

    order_items = pd.read_csv(os.path.join(CLEAN_DATA, "order_items.csv"))

    invalid = order_items[
        (order_items["discount_percent"] < 0) |
        (order_items["discount_percent"] > 100)
    ]

    print("Invalid Discounts:", len(invalid))


def test_invalid_dates():
    print("\n===== Invalid Date Test =====")

    orders = pd.read_csv(os.path.join(CLEAN_DATA, "orders.csv"))

    dates = pd.to_datetime(
        orders["order_date"],
        errors="coerce",
        format="mixed"
    )

    invalid = dates.isna().sum()

    print("Invalid Dates:", invalid)


if __name__ == "__main__":

    test_database_connection()
    test_missing_values()
    test_negative_quantity()
    test_duplicate_customers()
    test_invalid_discount()
    test_invalid_dates()

    print("\nAll tests completed successfully.")