import pandas as pd
import random
from faker import Faker
import os

from datetime import datetime, timedelta


BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RAW_DATA = os.path.join(BASE_DIR, "data", "raw")

fake = Faker()

def generate_customers():
    customers = []

    for i in range(500):
        customer_id = f"C{i+1:04d}"      # Starts from C0001
        name = fake.name()
        email = fake.email()
        registration_date = fake.date_between(start_date='-2y', end_date='today')
        customer_type = random.choice(["REGULAR", "PREMIUM", "VIP"])

        if random.random() < 0.02:
            email = email.replace("@", "")

        customers.append([
            customer_id,
            name,
            email,
            registration_date,
            customer_type
        ])

    df = pd.DataFrame(
        customers,
        columns=[
            "customer_id",
            "customer_name",
            "email",
            "registration_date",
            "customer_type"
        ]
    )

    df.to_csv(os.path.join(RAW_DATA, "customers.csv"), index=False)

    print("customers.csv generated successfully!")

generate_customers()

def generate_products():
    products = []

    categories = {
        "Electronics": ["Mobile", "Laptop", "Headphones", "Smart Watch"],
        "Clothing": ["Shirt", "Jeans", "Jacket", "T-Shirt"],
        "Home": ["Chair", "Table", "Lamp", "Sofa"],
        "Books": ["Novel", "Science", "History", "Programming"]
    }

    for i in range(1, 501):

        category = random.choice(list(categories.keys()))
        subcategory = random.choice(categories[category])

        product_name = subcategory

        # Mixed case / extra spaces
        if random.random() < 0.05:
            product_name = " " + product_name.upper() + " "

        products.append([
            f"P{i:04d}",
            product_name,
            category,
            subcategory,
            round(random.uniform(100,5000),2)
        ])

    df = pd.DataFrame(products,columns=[
        "product_id",
        "product_name",
        "category",
        "subcategory",
        "cost_price"
    ])

    df.to_csv(os.path.join(RAW_DATA,"products.csv"),index=False)

    print("products.csv generated successfully!")

generate_products()

def generate_orders():

    orders=[]

    status_list=[
        "PLACED",
        "SHIPPED",
        "DELIVERED",
        "CANCELLED",
        "RETURNED"
    ]

    regions=["North","South","East","West"]

    for i in range(1,501):

        customer_id=f"C{random.randint(1,500):04d}"

        # 5% NULL customer id
        if random.random()<0.05:
            customer_id=""

        order_date=datetime.now()-timedelta(days=random.randint(1,730))

        # Wrong format in some rows
        if random.random()<0.05:
            order_date=order_date.strftime("%d-%m-%Y")
        else:
            order_date=order_date.strftime("%Y-%m-%d %H:%M:%S")

        orders.append([
            f"O{i:04d}",
            customer_id,
            order_date,
            random.choice(status_list),
            random.choice(regions)
        ])

    df=pd.DataFrame(orders,columns=[
        "order_id",
        "customer_id",
        "order_date",
        "status",
        "region_code"
    ])

    df.to_csv(os.path.join(RAW_DATA,"orders.csv"),index=False)

    print("orders.csv generated successfully!")

generate_orders()

def generate_order_items():

    items=[]

    for i in range(1,1001):

        quantity=random.randint(1,5)

        # 3% negative quantity
        if random.random()<0.03:
            quantity=-quantity

        items.append([
            f"I{i:05d}",
            f"O{random.randint(1,500):04d}",
            f"P{random.randint(1,500):04d}",
            quantity,
            round(random.uniform(100,5000),2),
            round(random.uniform(0,100),2)
        ])

    df=pd.DataFrame(items,columns=[
        "item_id",
        "order_id",
        "product_id",
        "quantity",
        "unit_price",
        "discount_percent"
    ])

    df.to_csv(os.path.join(RAW_DATA,"order_items.csv"),index=False)

    print("order_items.csv generated successfully!")

generate_order_items()