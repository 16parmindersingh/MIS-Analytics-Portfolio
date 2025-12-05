# SQL Retail Sales Analysis 📊💼

## Project Overview
This project analyzes a retail sales dataset using MySQL to derive actionable business insights. The workflow encompasses database creation, data import, and comprehensive SQL-based analysis, showcasing strong MIS analytics and database management skills. It includes raw datasets in CSV format, a detailed SQL script with all analysis queries, and a presentation-style PDF file displaying each query and its output.

The objective is to leverage structured database techniques for MIS reporting, emphasizing data organization, relationship management, and analytical querying through SQL.

---

## Project Preview 
![PDF Preview](pdf_Screenshot.PNG)  
[View Full Project PDF](retail_sales_analysis.pdf)

---

## Dataset Description
The project utilizes a single dataset representing retail transaction details:

- **retail_sales.csv** – Contains transaction data including transaction ID, sale date, sale time, customer ID, gender, age, category, quantity, price per unit, cost of goods sold (COGS), and total sale. This dataset forms the foundation for analyzing sales performance, customer demographics, and category trends.

---

## Tools and Technologies
- **MySQL** – Used for database creation, table setup, data import, and analysis through SQL queries.
- **Microsoft Excel / CSV** – Used as the raw data source for importing into MySQL.
- **PDF Presentation** – `retail_sales_analysis.pdf` contains all executed queries and their results for documentation and visualization.

---

## What I Did in This Project

### 1. Database Creation and Setup
- Created a new MySQL database named `retailsalesdb`.
- Designed the `retail_sales` table with appropriate data types and a primary key on `transaction_id`.
- Established data integrity by aligning table structure with the CSV dataset.

### 2. Data Import
- Imported the raw data from `retail_sales.csv` into the `retail_sales` table using `LOAD DATA INFILE`.
- Validated data integrity by checking for duplicates, nulls, and format consistency (e.g., `sale_date` as `dd-mm-yy` converted to `yyyy-mm-dd`).

### 3. Data Analysis using SQL
- Wrote and executed SQL queries to analyze business metrics, such as:
  - Total sales and unique customer counts.
  - Category-wise and date-specific sales performance.
  - Customer demographics (e.g., average age by category).
  - Best-selling months and top customers by total sales.
  - Order distribution by shift and high-value transactions.
- Documented all queries and results in the project PDF for clear visualization.

### 4. Documentation
- Compiled the analysis into `retail_sales_analysis.pdf`, including all queries, results, and SQL outputs in a structured presentation format.
- Added supporting files (dataset and SQL script) to the repository for reproducibility.

---

## Project Structure
- `retail_sales.csv` – Raw dataset of all retail transactions.
- `SQL Retail Store Analysis.sql` – Contains all SQL queries written and executed for this project.
- `retail_sales_analysis.pdf` – Full analysis report with queries and results.
- `pdf_Screenshot.png` – Preview of the PDF report.
- `Questions_Screenshot.png` – Screenshot showing all 10 queries from basic to advanced.
- `README.md` – Project documentation file.

---

## Skills Demonstrated
This project showcases my ability to:
- Design and manage relational databases using MySQL.
- Perform complex SQL queries with joins, window functions, and aggregations.
- Document MIS reports with a clear structure and professional presentation.
- Translate raw sales data into actionable business insights.

---

## Key Insights
Based on the SQL queries and results, here are the main findings:

- **Sales on Specific Dates (e.g., November 5, 2022)**: 11 transactions occurred, primarily in Clothing and Beauty categories, with total sales ranging from 50 to 1200 per transaction. This highlights daily variability in category performance.
- **High-Volume Clothing Sales in November 2022**: Transactions with quantity >=4 yielded sales up to 2000, indicating strong demand for bulk purchases in Clothing during this period.
- **Category Performance**:
  - Electronics led in net sales (311,445) with 678 orders.
  - Clothing had the highest order volume (698 orders, net sales 309,995).
  - Beauty followed with 611 orders and net sales of 286,790.
  - **Insight**: Electronics generates the highest revenue per order, suggesting a focus on high-value items.
- **Average Age of Beauty Buyers**: 40.42 years, indicating that Beauty products appeal to a middle-aged demographic, which could inform targeted marketing strategies.
- **High-Value Transactions (>1000)**: Numerous transactions exceeded 1000, often in Electronics and Clothing with quantities of 3-4, emphasizing the importance of premium pricing in driving revenue.
- **Transactions by Gender and Category**:
  - Beauty: Female (330), Male (281)
  - Clothing: Female (347), Male (351)
  - Electronics: Female (335), Male (343)
  - **Insight**: Gender distribution is nearly balanced across categories, with a slight male preference in Electronics and Clothing, suggesting inclusive marketing opportunities.
- **Best-Selling Months**:
  - 2022: July (average sale 541.34)
  - 2023: February (average sale 535.53)
  - **Insight**: Seasonal peaks in mid-year (2022) and early-year (2023) could be tied to promotions or holidays, recommending inventory planning around these periods.
- **Top 5 Customers by Total Sales**:
  - Customer ID 3: 38,440
  - ID 1: 30,750
  - ID 5: 30,405
  - ID 2: 25,295
  - ID 4: 23,580
  - **Insight**: These loyal customers account for a significant revenue share, warranting VIP programs or personalized offers to retain them.
- **Unique Customers per Category**:
  - Beauty: 141
  - Clothing: 149
  - Electronics: 144
  - **Insight**: High customer overlap across categories (total unique: 155) indicates cross-selling potential, with Clothing attracting the broadest base.
- **Orders by Shift**:
  - Evening (>17:00): 1062 orders
  - Morning (<12:00): 548 orders
  - Afternoon (12:00-17:00): 377 orders
  - **Insight**: Evening dominates order volume, suggesting extended staffing or promotions during peak hours to capitalize on after-work shopping.

## Overall Business Recommendations
- **Revenue Optimization**: Focus on Electronics for high-margin sales and promote bulk Clothing purchases.
- **Customer Engagement**: Target middle-aged buyers for Beauty and leverage balanced gender data for inclusive campaigns.
- **Operational Efficiency**: Boost evening operations and plan for seasonal peaks in July and February.
- **Growth Opportunities**: Encourage cross-category purchases and reward top customers to increase loyalty and lifetime value.

---

## Why This Project Matters
For MIS and Data Analyst roles, this project highlights my expertise in data modeling, SQL querying, and relational database management—key skills for transforming raw business data into meaningful insights. It demonstrates a structured approach to organizing, analyzing, and presenting analytical work suitable for MIS reporting environments.

---

## How to Replicate the Analysis
### Download the Repository Files
- Clone or download the repository containing the CSV, SQL script, and PDF.

### Set Up Database
- Open MySQL Workbench and create a new database named `retailsalesdb`.
- Import `retail_sales.csv` into the `retail_sales` table using the provided `CREATE TABLE` and `LOAD DATA INFILE` scripts.

### Run the Queries
- Open and execute the queries in `SQL Retail Store Analysis.sql`.
- View and compare your outputs with the documented results in `retail_sales_analysis.pdf`.

---

## Contact Me
For questions, suggestions, or collaboration:

- **GitHub**: [16parmindersingh](https://github.com/16parmindersingh)
- **LinkedIn**: [16parmindersingh](https://www.linkedin.com/in/16parmindersingh)
- **Email**: [sparminder1608@gmail.com](mailto:sparminder1608@gmail.com)

Thank you for checking out my project! This SQL-based MIS analysis demonstrates how structured database querying can power business insights and decision-making. 🚀
