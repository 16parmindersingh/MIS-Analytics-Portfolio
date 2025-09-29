# Super Store Sales Analysis Dashboard 📊💰

![Dashboard Screenshot 1](Dashboard1.png)
![Dashboard Screenshot 2](Dashboard2.png)

## Project Overview
This project analyzes superstore sales data from 2019 to 2021 using **Microsoft Power BI** to create an interactive dashboard with actionable insights and a 15-day sales forecast. By leveraging raw CSV data, time series analysis, and interactive visualizations, I addressed business questions on sales trends, regional performance, and forecasting to support strategic decision-making for a supermarket's growth, efficiency, and customer satisfaction.

This project showcases my skills in **Power BI**, **data analysis**, **time series forecasting**, and **dashboard development**, making it a strong addition to my portfolio for roles in MIS, business intelligence, or data analytics.

---

## Dataset Description
The dataset consists of two CSV files, representing sales and related data from 2019 to 2021:

- **orders.csv**: Contains detailed order information.
  - Columns: `Order Date`, `Customer Name`, `State`, `Category`, `Sub-Category`, `Product Name`, `Sales`, `Quantity`, `Profit`, `Region`, etc.
  - Sample Data: Thousands of orders (e.g., 01-01-2019, John Doe, California, Technology, Phones, $500.00, 3, $150.00).
  - Categories: Furniture, Office Supplies, Technology.
  - Sub-Categories: Chairs, Phones, Binders, etc.
  - Data Insight: Covers multiple U.S. states with varying sales and profit figures for comprehensive regional and temporal analysis.
- **returns.csv**: Contains return transaction details.
  - Columns: `Order ID`, `Return Date`, `Reason`, etc.
  - Sample Data: Tracks returns linked to orders for loss analysis.

---

## Tools and Technologies
- **Microsoft Power BI**: Used for data preparation, DAX measures, time series forecasting, chart visualization, and interactive dashboard development.
- **CSV Files**: Raw data files (`orders.csv` and `returns.csv`) were imported and processed in Power BI.

---

## What I Did in This Project
This project follows a structured approach to analyzing sales data using Power BI for MIS reporting and forecasting. Here’s a detailed breakdown of the steps:

### 1. Data Preparation
- Imported `orders.csv` and `returns.csv` into Power BI and cleaned the dataset for analysis.

### 2. Data Exploration
- Explored the data to understand sales distribution across states, categories, and time periods from 2019 to 2021.
- Confirmed the dataset supported time series analysis and regional breakdowns.

### 3. Dashboard Development
- Created DAX measures (e.g., Total Sales, Sum of Sales by State) and applied a Top N filter to display the top 10 states.
- Designed an interactive dashboard with a 15-day sales forecast line chart, a clustered bar chart for state sales, and filters for dynamic exploration.
- Added visualizations to highlight trends and regional performance.

### 4. Sales Forecasting
- Leveraged historic data and applied time series analysis to generate a 15-day sales forecast using Power BI's forecasting tool.
- Validated forecast trends against historical sales patterns.

### 5. Insights Generation
- Analyzed results to identify key trends, such as top-performing states and seasonal sales patterns, for management decision-making.
- Documented findings within the Power BI report for easy reference.

### Key Output
The project delivers a comprehensive Power BI dashboard with a 15-day sales forecast and actionable insights, included in this repository.

---

## Results and Insights
### Overall Sales Performance
- **Sales Forecast**: The 15-day forecast indicates a potential upward trend, with sales projected to reach 10k by January 2021, based on historical data from 2019-2020.
- **Top States**: California and Texas lead with the highest sales, while states like Wyoming show minimal contribution, suggesting expansion opportunities.
- **Seasonal Trends**: Sales peak in later months, aligning with holiday seasons, recommending targeted promotions.

### Category and Product Insights
- **Top Revenue Generators**: Technology (e.g., Phones) and Furniture (e.g., Chairs) dominate sales, similar to prior trends.
- **Profit Trends**: Technology shows strong profit growth, while low-profit items like Fasteners suggest optimization needs.

### Geographic and Customer Insights
- **Regional Distribution**: California exceeds 20% of total sales, followed by New York and Texas, with underperforming states like West Virginia indicating growth potential.
- **Customer Impact**: Top customers contribute significant profits, while loss-making customers suggest a need for segmentation review.

### Business Implications
- **Category Optimization**: Focus on high-profit categories like Technology and reduce emphasis on low-sales items.
- **Regional Strategy**: Target underperforming states with tailored marketing campaigns.
- **Management Recommendations**: Use forecast insights to plan inventory and promotions for Q4 growth.

---

## Project Structure
- **orders.csv**: Raw sales dataset with detailed order information.
- **returns.csv**: Raw return dataset with transaction details.
- **SuperStoreAnalysis.pbix**: Full Power BI report with dashboard, forecasts, and DAX measures.
- **Dashboard1.png** & **Dashboard2.png**: Screenshots of the forecast and state sales views.

---

## Skills Demonstrated
This project highlights my ability to:
- Use **Microsoft Power BI** for data modeling, including DAX measures and time series forecasting.
- Build interactive dashboards with filters, slicers, and advanced visualizations.
- Analyze sales data to extract actionable insights for strategic decision-support.

---

## Why This Project Matters
For recruiters, this project showcases my expertise in **Power BI**, **time series analysis**, and **interactive reporting**, essential for roles in MIS, business intelligence, or data analytics. It demonstrates my ability to transform raw data into strategic insights.

For others, this project offers a practical example of using Power BI for sales forecasting and dashboard creation, with applications in retail strategy and performance optimization.

---

## How to Replicate the Analysis
1. **Open the PBIX File**:
   - Open `SuperStoreAnalysis.pbix` in Power BI Desktop (compatible with latest versions).
2. **Explore the Dashboard**:
   - Use filters and slicers to explore sales by state, category, or date range.
3. **Review Forecast**:
   - Check the 15-day forecast visual and adjust settings in the Analytics pane if needed.

---

## Contact Me
For any questions or collaboration opportunities, please reach out to:
- **GitHub**: [16parmindersingh](https://github.com/16parmindersingh)
- **Email**: [sparminder1608@gmail.com](mailto:sparminder1608@gmail.com)
- **LinkedIn**: [16parmindersingh](https://www.linkedin.com/in/16parmindersingh)

---

Thank you for checking out my project! I’m excited to continue enhancing my data analytics skills and applying them to real-world challenges. 🚀
