# 🪙 Data Catalog for Gold Layer

## 🧾 Overview
The **Gold Layer** represents the **business-ready data** designed for analytics, reporting, and machine learning use cases.  
It organizes cleaned and integrated data from CRM and ERP sources into **dimension** and **fact** tables that follow a **star schema** pattern.

---

## 🌟 Tables Overview

### 1️⃣ **gold.dim_customers**
**Purpose:** Stores customer details enriched with demographic and geographic data for business insights.

| Column Name     | Data Type     | Description                                                                                   |
|-----------------|---------------|-----------------------------------------------------------------------------------------------|
| customer_key    | INT           | Surrogate key uniquely identifying each customer record in the dimension table.               |
| customer_id     | INT           | Unique numerical identifier assigned to each customer.                                        |
| customer_number | NVARCHAR(50)  | Alphanumeric identifier representing the customer, used for tracking and referencing.         |
| first_name      | NVARCHAR(50)  | The customer's first name.                                                                    |
| last_name       | NVARCHAR(50)  | The customer's last name or family name.                                                      |
| country         | NVARCHAR(50)  | The country of residence for the customer (e.g., 'Australia').                               |
| marital_status  | NVARCHAR(50)  | The marital status of the customer (e.g., 'Married', 'Single').                              |
| gender          | NVARCHAR(50)  | The gender of the customer (e.g., 'Male', 'Female', 'n/a').                                  |
| birthdate       | DATE          | The date of birth of the customer, formatted as `YYYY-MM-DD`.                                 |
| create_date     | DATE          | The date when the customer record was created in the system.                                  |

---

### 2️⃣ **gold.dim_products**
**Purpose:** Contains product-related attributes used for category, cost, and maintenance-based analytics.

| Column Name          | Data Type     | Description                                                                                   |
|----------------------|---------------|-----------------------------------------------------------------------------------------------|
| product_key          | INT           | Surrogate key uniquely identifying each product record.                                       |
| product_id           | INT           | Unique identifier assigned to each product.                                                   |
| product_number       | NVARCHAR(50)  | Structured alphanumeric code representing the product (e.g., 'BK-M68B-42').                  |
| product_name         | NVARCHAR(50)  | Descriptive product name including details such as type, color, and size.                    |
| category_id          | NVARCHAR(50)  | Identifier for the product's category (e.g., 'CAT100').                                      |
| category             | NVARCHAR(50)  | Broader product classification (e.g., 'Bikes', 'Components').                                |
| subcategory          | NVARCHAR(50)  | More detailed classification within the category (e.g., 'Mountain Bikes').                   |
| maintenance_required | NVARCHAR(50)  | Indicates if the product requires maintenance ('Yes'/'No').                                  |
| cost                 | INT           | Base cost of the product in whole currency units.                                            |
| product_line         | NVARCHAR(50)  | Product line or series name (e.g., 'Road', 'Mountain').                                     |
| start_date           | DATE          | Date when the product became available for sale or use.                                      |

---

### 3️⃣ **gold.fact_sales**
**Purpose:** Stores transactional sales facts for trend and performance analysis.

| Column Name   | Data Type     | Description                                                                                   |
|---------------|---------------|-----------------------------------------------------------------------------------------------|
| order_number  | NVARCHAR(50)  | Unique alphanumeric identifier for each sales order (e.g., 'SO54496').                       |
| product_key   | INT           | Foreign key linking to the product dimension.                                                 |
| customer_key  | INT           | Foreign key linking to the customer dimension.                                                |
| order_date    | DATE          | Date when the order was placed.                                                               |
| shipping_date | DATE          | Date when the order was shipped.                                                              |
| due_date      | DATE          | Payment due date for the order.                                                               |
| sales_amount  | INT           | Total sales value for the transaction.                                                        |
| quantity      | INT           | Number of product units sold.                                                                 |
| price         | INT           | Price per product unit.                                                                       |

---

## 📊 Relationships

- **gold.fact_sales** ↔ **gold.dim_customers** → via `customer_key`
- **gold.fact_sales** ↔ **gold.dim_products** → via `product_key`

This schema forms the **core star model** for reporting and BI dashboards in the Medallion SQL Data Warehouse.

---

## 🧩 Usage Example

```sql
-- Example: Total sales by country and category
SELECT 
    c.country,
    p.category,
    SUM(f.sales_amount) AS total_sales,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
JOIN gold.dim_customers c ON f.customer_key = c.customer_key
JOIN gold.dim_products p ON f.product_key = p.product_key
GROUP BY c.country, p.category
ORDER BY total_sales DESC;
