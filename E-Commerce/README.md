# E-Commerce Data Analytics System

## Project Overview

This project is an end-to-end E-Commerce Data Analytics System developed using Python, Pandas, SQLite, and SQL. It simulates a real-world e-commerce environment by generating realistic datasets, cleaning and validating the data, storing it in a relational database, performing SQL-based business analysis, and generating dynamic reports through a Command Line Interface (CLI).

---

## Objectives

- Generate realistic e-commerce datasets with intentional inconsistencies.
- Clean and validate data using Pandas.
- Store cleaned data in SQLite.
- Perform SQL analysis using joins, aggregations, window functions, CTEs, and cohort analysis.
- Build a CLI reporting tool for business insights.
- Handle edge cases to ensure system reliability.

---

## Technologies Used

- Python 3.x
- Pandas
- Faker
- SQLite
- SQL
- DB Browser for SQLite

---

## Project Structure

```
E-Commerce/
│
├── data/
│   ├── raw/
│   │   ├── customers.csv
│   │   ├── products.csv
│   │   ├── orders.csv
│   │   └── order_items.csv
│   │
│   └── cleaned/
│       ├── customers.csv
│       ├── products.csv
│       ├── orders.csv
│       └── order_items.csv
│
├── database/
│   └── ecommerce.db
│
├── scripts/
│   ├── generate_data.py
│   ├── clean_data.py
│   ├── load_database.py
│   ├── reports.py
│   ├── cli.py
│   └── tests.py
│
├── sql/
│   ├── basic_queries.sql
│   ├── intermediate_queries.sql
│   └── advanced_queries.sql
│
├── output/
│   └── report.txt
│
├── requirements.txt
└── README.md
```

---

## Dataset

The project generates four datasets:

### Customers
- Customer ID
- Customer Name
- Email
- Registration Date
- Customer Type

### Products
- Product ID
- Product Name
- Category
- Subcategory
- Cost Price

### Orders
- Order ID
- Customer ID
- Order Date
- Order Status
- Region

### Order Items
- Item ID
- Order ID
- Product ID
- Quantity
- Unit Price
- Discount Percentage

---

## Data Cleaning

The cleaning process includes:

- Handling missing values
- Email validation
- Standardizing date formats
- Product name formatting
- Referential integrity checks
- Invalid record detection

---

## Database

The cleaned datasets are loaded into an SQLite database containing four tables:

- customers
- products
- orders
- order_items

---

## SQL Analysis

### Basic Queries

- Revenue by Category
- Top Customers by Spending
- Monthly Order Count

### Intermediate Queries

- Customers without Delivered Orders
- Products with More Returns than Purchases
- Return Rate by Category

### Advanced Queries

- Running Revenue Total
- DENSE_RANK()
- LAG()
- NTILE()
- Common Table Expressions (CTEs)
- Cohort Analysis
- Frequently Bought Together Products
- Year-over-Year Revenue Analysis

---

## CLI Reporting Tool

The command-line reporting tool allows users to:

- Generate Daily Reports
- Generate Weekly Reports
- Generate Monthly Reports

Each report includes:

- Total Orders
- Total Revenue
- Unique Customers
- Top 3 Products
- Previous Period Comparison

The generated report is automatically saved in:

```
output/report.txt
```

---

## Edge Cases Handled

- Missing Customer IDs
- Invalid Email Addresses
- Duplicate Records
- Negative Quantities
- Invalid Discounts
- Invalid Dates
- Empty Result Sets
- Database Connection Errors
- Invalid User Input

---

## How to Run

### Install Dependencies

```
pip install -r requirements.txt
```

### Generate Dataset

```
python scripts/generate_data.py
```

### Clean Dataset

```
python scripts/clean_data.py
```

### Load SQLite Database

```
python scripts/load_database.py
```

### Run CLI Reporting Tool

```
python scripts/cli.py
```

### Execute Tests

```
python scripts/tests.py
```

---

## Output

The project generates:

- Raw CSV Files
- Cleaned CSV Files
- SQLite Database
- SQL Analysis Results
- CLI Reports
- report.txt

---

## Future Enhancements

- Interactive Dashboard using Power BI or Tableau
- Streamlit Web Application
- Automated ETL Pipeline
- Predictive Sales Analytics
- Customer Segmentation using Machine Learning
- Cloud Database Integration

---

## Author

**Khushi singh**

B.Tech (Computer Science Engineering)