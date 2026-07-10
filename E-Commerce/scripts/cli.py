import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUTPUT_FILE = os.path.join(BASE_DIR, "output", "report.txt")
from report import generate_report

print("====== E-Commerce Reporting Tool ======")

print("1. Daily Report")
print("2. Weekly Report")
print("3. Monthly Report")

choice = input("Enter your choice: ")

start_date = input("Enter Start Date (YYYY-MM-DD): ")
end_date = input("Enter End Date (YYYY-MM-DD): ")

orders, revenue, customers, products = generate_report(start_date, end_date)

print("\n===== REPORT =====")

print("\nTotal Orders")
print(orders)

print("\nRevenue")
print(revenue)

print("\nUnique Customers")
print(customers)

print("\nTop 3 Products")
print(products)

with open(OUTPUT_FILE, "w") as f:
    f.write("====== E-Commerce Report ======\n\n")

    f.write(f"Start Date: {start_date}\n")
    f.write(f"End Date: {end_date}\n\n")

    f.write("Total Orders\n")
    f.write(orders.to_string(index=False))
    f.write("\n\n")

    f.write("Revenue\n")
    f.write(revenue.to_string(index=False))
    f.write("\n\n")

    f.write("Unique Customers\n")
    f.write(customers.to_string(index=False))
    f.write("\n\n")

    f.write("Top 3 Products\n")
    f.write(products.to_string(index=False))

print("\nReport saved successfully in output/report.txt")