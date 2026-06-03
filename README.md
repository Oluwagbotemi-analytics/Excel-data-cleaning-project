# GO Sales Business Analytics

![Excel](https://img.shields.io/badge/Excel-217346?style=flat&logo=microsoft-excel&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Power Query](https://img.shields.io/badge/Power%20Query-742774?style=flat&logo=microsoft&logoColor=white)

## Overview

An end-to-end business analytics project on the GO Sales dataset. The project covers data cleaning, transformation, KPI development, and interactive dashboard creation to surface actionable insights on revenue performance, retailer behavior, and sales channel trends.

---

## Problem Statement

The GO Sales business needed a clear view of its sales performance across products, retailers, and order channels. Raw transactional data across multiple tables made it difficult to identify top performers, seasonal patterns, and underperforming areas without structured analysis.

---

## Tools & Technologies

| Tool | Purpose |
|------|---------|
| Power Query | Data cleaning and transformation |
| SQL | Sales queries and KPI calculations |
| Microsoft Excel | Pivot analysis, trend evaluation, forecasting |
| Power BI | Interactive dashboard and visualizations |

---

## Dataset

The GO Sales dataset contains transactional records covering:
- Product details and categories
- Retailer information
- Order methods (E-mail, Mail, Sales Visit, Telephone, Web)
- Sales dates spanning a full calendar year

---

## Data Cleaning Process

Carried out in **Power Query**:
- Removed blank cells and duplicate rows
- Corrected column data types and formats
- Fixed spelling errors in categorical fields
- Built relationships between tables: Sales, Products, Retailers, and Order Methods

---

## KPIs Tracked

- Total Revenue
- Average Order Value
- Order Count by Retailer
- Sales Growth Rate (%)
- Sales Distribution by Order Method

---

## Key Findings

- **Seasonal demand:** Sales performance varied significantly across months, with one month contributing disproportionately higher revenue
- **Dominant sales channel:** One order method drove the majority of transactions, indicating a clear customer preference
- **Top product:** Star Lite generated the highest share of total revenue by a significant margin
- **Secondary products:** Canyon Mule Weekender Backpack, Canyon Mule Journey Backpack, and Star Gazer 2 showed balanced performance among themselves
- **Retailer gap:** High-performing retailers drove the bulk of revenue, while a segment of underperforming retailers represents an untapped growth opportunity

---

## Recommendations

- Prioritize high-performing retailers and product categories to protect and grow revenue
- Expand investment in the dominant sales channel while developing weaker channels
- Deploy upselling strategies and performance monitoring for underperforming retailers
- Use seasonal patterns to plan inventory levels and promotional campaigns in advance

---

## Dashboard Highlights

Built in **Power BI** with interactive slicers for retailer, product category, and order method:

- Monthly sales trend — dual-axis line and bar chart
- Sales by order method — donut chart
- Top 5 products by revenue — treemap
- Retailer performance comparison — bar chart
- Cumulative sales over time — area chart

> *Dashboard screenshot coming soon*

---

## Repository Structure

```
├── raw_data.csv                  # Original uncleaned dataset
├── cleaned_data_analyzed.csv     # Cleaned and analysis-ready dataset
├── GO_Sales_Report.pdf           # Full business analytics report
├── queries.sql                   # SQL queries for all 6 analytical categories
└── README.md                     # Project documentation
```

---

## Author

**Oluwagbotemi Olanrewaju**  
Data Analyst  
https://github.com/Oluwagbotemi-analytics
