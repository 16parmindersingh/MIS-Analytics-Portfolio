# Pizza Sales Analysis (SQL) 🍕📊

## Project Overview
This project analyzes 12 months of pizza sales data using **MySQL** to generate MIS reports and provide actionable insights for optimizing menu offerings, pricing strategies, and inventory management. By integrating data from multiple tables, I developed a series of SQL queries to answer business questions ranging from basic to advanced, covering total orders, revenue, customer preferences, and temporal trends.

This project showcases my skills in **SQL query writing**, **management reporting**, and **database management**, making it a valuable addition to my portfolio for roles in MIS, business intelligence, or database administration.

---

## Dataset Description
The dataset consists of four CSV files, representing pizza sales data over 12 months in 2015:

- **orders.csv**: Contains order information.
  - Columns: `order_id`, `date`, `time`.
  - Sample Data: 21,380 orders (e.g., order ID 1, date 1/1/2015, time 11:38:36).
- **order_details.csv**: Contains detailed order information.
  - Columns: `order_details_id`, `order_id`, `pizza_id`, `quantity`.
  - Sample Data: 21 rows shown (e.g., order ID 1, pizza ID `hawaiian_m`, quantity 1).
- **pizza_types.csv**: Defines pizza types and categories.
  - Columns: `pizza_type_id`, `name`, `category`, `ingredients`.
  - Categories: Chicken, Classic, Supreme, Veggie.
  - Sample Data: 32 pizza types (e.g., `bbq_ckn`, "The Barbecue Chicken Pizza", category "Chicken").
- **pizzas.csv**: Contains pizza details with sizes and prices.
  - Columns: `pizza_id`, `pizza_type_id`, `size`, `price`.
  - Sizes: S, M, L, XL, XXL.
  - Prices: Range from $12 to $35.95.
  - Sample Data: 96 rows (e.g., `bbq_ckn_s`, type `bbq_ckn`, size S, price 12.75).

### Data Insights
- The dataset includes 21,380 orders across 32 pizza types, categorized into Chicken, Classic, Supreme, and Veggie.
- Each order can include multiple pizzas, with quantities tracked in `order_details.csv`.
- The data spans all of 2015, allowing for temporal analysis (e.g., by hour, day, or cumulative trends).

---

## Tools and Technologies
- **MySQL**: Used for database creation, data import, and query execution.
- **CSV Files**: The raw data files (`orders.csv`, `order_details.csv`, `pizza_types.csv`, `pizzas.csv`) were imported into MySQL tables.

---

## What I Did in This Project
This project follows a structured approach to analyzing pizza sales data using SQL for MIS reporting. Here’s a detailed breakdown of the steps:

### 1. Database Setup
- Created a MySQL database named `pizza_sales`.
- Imported the four CSV files (`orders.csv`, `order_details.csv`, `pizza_types.csv`, `pizzas.csv`) into corresponding tables using MySQL Workbench or a similar tool.
- Verified the data integrity by checking for missing or inconsistent values (e.g., ensuring foreign key relationships between tables).

### 2. Data Exploration
- Explored the tables to understand their structure and relationships:
  - `orders` and `order_details` are linked via `order_id`.
  - `order_details` and `pizzas` are linked via `pizza_id`.
  - `pizzas` and `pizza_types` are linked via `pizza_type_id`.
- Confirmed the dataset was clean and ready for analysis (no major cleaning required).

### 3. SQL Query Development
- Developed 13 SQL queries to answer business questions, categorized into Basic, Intermediate, and Advanced levels:
  - **Basic Queries**:
    1. Total number of orders placed.
    2. Total revenue from pizza sales.
    3. Highest-priced pizza.
    4. Most common pizza size ordered.
    5. Top 5 most ordered pizza types by quantity.
  - **Intermediate Queries**:
    6. Total quantity of each pizza category ordered.
    7. Distribution of orders by hour of the day.
    8. Category-wise distribution of pizza types.
    9. Average number of pizzas ordered per day.
    10. Top 3 pizza types by revenue.
  - **Advanced Queries**:
    11. Percentage contribution of each pizza category to total revenue.
    12. Cumulative revenue over time.
    13. Top 3 pizza types by revenue for each category.
- Used SQL features like `JOIN`, `GROUP BY`, `ORDER BY`, `SUM`, `COUNT`, `ROUND`, subqueries, window functions (`RANK`, `OVER`), and more.

### 4. Insights Generation
- Analyzed the query results to identify trends and patterns in pizza sales for management decision-making.
- Documented the findings in a presentation (`Pizza Sales SQL Project.pdf`) for easy reference.

### Key Output
The project provides a comprehensive analysis of pizza sales through SQL queries, with results that can inform business decisions. The queries are stored in the `sql/` folder as `query1.sql` to `query13.sql`, and the detailed results are presented in `docs/Pizza Sales SQL Project.pdf`.

---

## Results and Insights
### Basic Insights
- **Total Orders**: 21,380 orders were placed in 2015.
- **Total Revenue**: $817,860.05 generated from pizza sales.
- **Highest-Priced Pizza**: "The Greek Pizza" at $35.95.
- **Most Common Pizza Size**: Large (L) with 18,526 orders.
- **Top 5 Most Ordered Pizza Types**:
  - The Classic Deluxe Pizza: 2,453 units
  - The Barbecue Chicken Pizza: 2,432 units
  - The Hawaiian Pizza: 2,422 units
  - The Pepperoni Pizza: 2,418 units
  - The Thai Chicken Pizza: 2,371 units

### Intermediate Insights
- **Quantity by Pizza Category**:
  - Classic: 14,888 units
  - Supreme: 11,987 units
  - Chicken: 11,034 units
  - Veggie: 11,149 units
- **Category-Wise Distribution of Pizza Types**:
  - Classic: 8 types
  - Supreme: 9 types
  - Veggie: 9 types
  - Chicken: 6 types
- **Average Pizzas Ordered Per Day**: 138 pizzas.
- **Top 3 Pizza Types by Revenue**:
  - The Thai Chicken Pizza: $43,434.25
  - The Barbecue Chicken Pizza: $42,768
  - The California Chicken Pizza: $41,409.5

### Advanced Insights
- **Cumulative Revenue Over Time** (sample for January 2015):
  - 2015-01-01: $2,713.85
  - 2015-01-02: $5,445.75
  - 2015-01-03: $8,108.15
  - (Full results in `Pizza Sales SQL Project.pdf`)
- **Percentage Contribution to Revenue** and **Top 3 Pizza Types by Revenue per Category**: Queries provided in `query11.sql` and `query13.sql`, with results in the PDF.

### Business Implications
- **Menu Optimization**: Focus on popular pizzas like The Classic Deluxe and The Thai Chicken Pizza for promotions.
- **Pricing Strategy**: The Greek Pizza, while the highest-priced, may need marketing to boost sales.
- **Inventory Management**: Stock more Large-sized pizzas, as they are the most ordered.
- **Management Recommendations**: Use these insights to integrate into MIS systems for real-time sales tracking and forecasting.

---

## Project Structure
- **data/**: Contains the raw data files.
  - `orders.csv`: Order-level data.
  - `order_details.csv`: Detailed order information.
  - `pizzas.csv`: Pizza menu details.
  - `pizza_types.csv`: Categories and types of pizzas.
- **sql/**: Contains SQL scripts for the analysis.
  - `query1.sql` to `query13.sql`: Scripts addressing the 13 business questions.
- **docs/**: Contains supporting documents.
  - `Pizza Sales SQL Project.pdf`: A presentation summarizing the queries and results.
  - `Questions.txt`: The list of questions solved by the queries.
- **README.md**: Provides an overview and instructions for the project.

---

## Skills Demonstrated
This project highlights my ability to:
- Use **MySQL** for database management and query execution in support of management reporting.
- Write complex SQL queries using `JOIN`, `GROUP BY`, `ORDER BY`, aggregations (`SUM`, `COUNT`), subqueries, and window functions (`RANK`, `OVER`).
- Analyze sales data to extract actionable business insights for decision-support systems.
- Structure and document a data analysis project for clarity and reproducibility.

---

## Why This Project Matters
For recruiters, this project showcases my skills in **SQL** and **management reporting**, which are essential for roles in MIS, business intelligence, or database administration. It demonstrates my ability to work with relational databases, write efficient queries, and derive meaningful insights from data to support strategic business decisions.

For others, this project provides a practical example of how SQL can be used to analyze sales data, with applications in menu optimization, pricing strategies, and inventory management for a pizza business.

---

## How to Replicate the Analysis
1. **Set Up the Database**:
   - Create a MySQL database (e.g., `pizza_sales`).
   - Import the CSV files from the `data/` folder into MySQL tables using MySQL Workbench or a similar tool.
2. **Execute SQL Scripts**:
   - Run the SQL scripts in the `sql/` folder (`query1.sql` to `query13.sql`) in numerical order to replicate the analysis.
3. **Review Results**:
   - Check the `docs/Pizza Sales SQL Project.pdf` for a detailed explanation of the queries and results.

---

## Contact Me
For any questions or collaboration opportunities, please reach out to:
- **GitHub**: [16parmindersingh](https://github.com/16parmindersingh)
- **Email**: [sparminder1608@gmail.com](mailto:sparminder1608@gmail.com)
- **LinkedIn**: [16parmindersingh](https://www.linkedin.com/in/16parmindersingh)

---

Thank you for checking out my project! I’m excited to continue growing my MIS skills and applying them to real-world challenges. 🚀
