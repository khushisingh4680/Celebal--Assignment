import pandas as pd
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

RAW_DATA = os.path.join(BASE_DIR, "data", "raw")
CLEAN_DATA = os.path.join(BASE_DIR, "data", "cleaned")

customers = pd.read_csv(os.path.join(RAW_DATA, "customers.csv"))
products = pd.read_csv(os.path.join(RAW_DATA, "products.csv"))
orders = pd.read_csv(os.path.join(RAW_DATA, "orders.csv"))
order_items = pd.read_csv(os.path.join(RAW_DATA, "order_items.csv"))

print(customers.head())
print(products.head())
print(orders.head())
print(order_items.head())


def clean_orders():
    global orders

    # Replace missing values
    orders["customer_id"] = orders["customer_id"].fillna("Unknown")

    # Convert to string
    orders["customer_id"] = orders["customer_id"].astype(str)

    # Replace blank strings
    orders["customer_id"] = orders["customer_id"].str.strip()
    orders.loc[orders["customer_id"] == "", "customer_id"] = "Unknown"

    # Convert dates
    orders["order_date"] = pd.to_datetime(
        orders["order_date"],
        format="mixed",
        dayfirst=True,
        errors="coerce"
    )

    print("Orders cleaned successfully.")

def clean_products():
    global products

    products["product_name"] = (
        products["product_name"]
        .str.strip()
        .str.title()
    )

    print("Products cleaned successfully.")

def validate_emails():
    invalid = customers[
        ~customers["email"].str.contains("@", na=False)
    ]

    print("\nInvalid Emails:")
    print(invalid[["customer_id", "email"]])

    return invalid

def check_referential_integrity():

    invalid_orders = order_items[
        ~order_items["order_id"].isin(orders["order_id"])
    ]

    print("\nInvalid Order References:")
    print(invalid_orders)

    return invalid_orders

order_items = order_items[order_items["quantity"] > 0]

clean_orders()
clean_products()
validate_emails()
check_referential_integrity()

customers.to_csv(os.path.join(CLEAN_DATA, "customers.csv"), index=False)
products.to_csv(os.path.join(CLEAN_DATA, "products.csv"), index=False)
orders.to_csv(os.path.join(CLEAN_DATA, "orders.csv"), index=False)
order_items.to_csv(os.path.join(CLEAN_DATA, "order_items.csv"), index=False)

print("\nCleaned files saved successfully.")