# E-Commerce Sales & Profit Analytics

An end-to-end Data Analyst portfolio project using **Excel, SQL, Power
BI and DAX** to analyze e-commerce sales, profitability, products,
regions, customers and business risks.

## Project Overview

This project follows an analytics workflow:

**Data validation → SQL analysis → Power BI modeling/visualization → DAX
calculations → Business insights → Management recommendations**

The final deliverable is a four-page Power BI dashboard designed for
both operational analysis and management decision support.

------------------------------------------------------------------------

## Dataset

**File:** `Data/global_ecommerce_sales.csv`

The dataset contains **2,000 rows and 15 columns**.

### Date range

`01-01-2024` to `31-12-2025`

### Main columns

-   `Order_ID`
-   `Order_Date`
-   `Customer_Name`
-   `Customer_Segment`
-   `Country`
-   `Region`
-   `Product_Category`
-   `Product_Name`
-   `Quantity`
-   `Unit_Price`
-   `Discount_Percent`
-   `Total_Sales`
-   `Shipping_Cost`
-   `Profit`
-   `Payment_Method`

### Data quality checks completed

-   2,000 total rows
-   2,000 unique Order IDs
-   No duplicate Order IDs
-   No missing values
-   Date values checked
-   Numeric columns checked
-   Categories, regions, countries and payment methods reviewed
-   Sales calculations validated

### Sales calculation

Because `Discount_Percent` is stored as a percentage from 0 to 30, the
correct calculation is:

``` text
Total Sales = Quantity × Unit Price × (1 - Discount_Percent / 100)
```

Example:

``` text
4 × 97.93 × (1 - 20/100)
= 313.376
≈ 313.38
```

------------------------------------------------------------------------

# Excel

Excel was used for the initial data-quality and validation workflow.

## Excel tasks completed

1.  Checked duplicate values.
2.  Checked missing/blank values.
3.  Checked date formats.
4.  Worked with dates stored as text.
5.  Standardized date formats where required.
6.  Identified numeric columns.
7.  Distinguished numeric date serials from ordinary numeric measures.
8.  Checked ranges for quantity, unit price, discount, sales, shipping
    cost and profit.
9.  Validated the sales calculation.
10. Prepared the dataset for SQL and Power BI analysis.

The detailed Excel work is available in:

`Excel/steps.xlsx`

------------------------------------------------------------------------

# SQL

SQL was used to develop and demonstrate business-analysis querying
skills.

**SQL file:** `SQL/queries.sql`

The SQL script contains **40 analytical questions/queries**, progressing
from basic aggregation to more advanced analysis.

## SQL topics covered

-   `SELECT`
-   `DISTINCT`
-   `WHERE`
-   `ORDER BY`
-   `GROUP BY`
-   `HAVING`
-   `COUNT`
-   `SUM`
-   `AVG`
-   `MIN`
-   `MAX`
-   `INNER JOIN`
-   `LEFT JOIN`
-   Subqueries
-   CTEs
-   `CASE`
-   Window functions
-   `RANK`
-   `LAG`
-   Running totals
-   Month-over-month growth
-   Product ranking within categories
-   Customer analysis
-   Profitability analysis

## Examples of SQL analysis

### Total Sales

``` sql
SELECT ROUND(SUM(Total_Sales), 2) AS total_sales
FROM global_ecommerce_sales;
```

### Sales by Region

``` sql
SELECT
    Region,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM global_ecommerce_sales
GROUP BY Region;
```

### Top Products

``` sql
SELECT
    Product_Name,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM global_ecommerce_sales
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 10;
```

### Loss-Making Orders

``` sql
SELECT
    Order_ID,
    Product_Name,
    Total_Sales,
    Profit
FROM global_ecommerce_sales
WHERE Profit < 0;
```

### Running Sales Total

The project also uses CTEs and window functions to calculate monthly
sales and a running total.

### Product Ranking

Products are ranked within each product category using:

``` sql
RANK() OVER (
    PARTITION BY Product_Category
    ORDER BY Total_Sales DESC
)
```

The complete SQL practice and analysis is available in
`SQL/queries.sql`.

------------------------------------------------------------------------

# Power BI

**Power BI file:** `Power Bi/E-commerce sales.pbix`

The final report contains four pages.

## Page 1 --- Executive Overview

### Purpose

Answer:

> **How is the business performing overall?**

### Main KPIs

-   Total Sales
-   Total Profit
-   Total Orders
-   Profit Margin
-   Average Order Value
-   Loss-Making Orders

### Main visuals

-   Monthly Sales Trend
-   Sales by Region
-   Sales vs Profit by Category
-   Profit by Product Category
-   Interactive slicers

------------------------------------------------------------------------

## Page 2 --- Product & Profitability

### Purpose

Answer:

> **Which products are driving sales and profit, and which products
> require attention?**

### Main analysis

-   Top 8 Products by Sales
-   Top 8 Products by Profit
-   Top 8 Products by Profit Margin
-   Loss-Making Products
-   Key Product Insights
-   Product/region/category filtering

------------------------------------------------------------------------

## Page 3 --- Regional & Customer Analysis

### Purpose

Answer:

> **Where are sales coming from and which customer segments are driving
> performance?**

### Main analysis

-   Sales by Region
-   Profit by Region
-   Sales by Payment Method
-   Sales by Customer Segment
-   Top 8 Countries by Sales
-   Regional & Customer Insights

### Slicers

-   Region
-   Country
-   Customer Segment

------------------------------------------------------------------------

## Page 4 --- Business Insights & Recommendations

### Purpose

Answer:

> **What should management do based on the analysis?**

### KPI cards

-   Best Sales Product
-   Best Profit Product
-   Best Region
-   Loss-Making Orders

### Key findings

-   What Is Working
-   Growth Opportunity
-   Key Risk

### Management recommendations

-   Expand European Market
-   Target Consumer Segment
-   Reduce Loss-Making Orders
-   Review loss-making products
-   Protect high-profit products

------------------------------------------------------------------------

# DAX

DAX was used to create reusable business metrics and dynamic insight
calculations.

## Core measures

### Total Sales

``` dax
Total Sales =
SUM(global_ecommerce_sales[Total_Sales])
```

### Total Profit

``` dax
Total Profit =
SUM(global_ecommerce_sales[Profit])
```

### Total Orders

``` dax
Total Orders =
DISTINCTCOUNT(global_ecommerce_sales[Order_ID])
```

### Profit Margin

``` dax
Profit Margin =
DIVIDE([Total Profit], [Total Sales], 0)
```

### Average Order Value

``` dax
Average Order Value =
DIVIDE([Total Sales], [Total Orders], 0)
```

## Dynamic insight pattern

The project also uses `TOPN`, `CONCATENATEX` and `MAXX` to identify the
leading product/region/customer and display its corresponding value.

Example:

``` dax
Top Sales Insight =
VAR TopProduct =
    TOPN(
        1,
        ALL(global_ecommerce_sales[Product_Name]),
        [Total Sales],
        DESC
    )
VAR ProductName =
    CONCATENATEX(
        TopProduct,
        global_ecommerce_sales[Product_Name],
        ", "
    )
VAR SalesValue =
    MAXX(TopProduct, [Total Sales])
RETURN
    ProductName & "   " &
    FORMAT(SalesValue / 1000, "0.00") & "K Sales"
```

------------------------------------------------------------------------

# Key Business Findings

Based on the completed dashboard analysis:

  Area                    Finding
  ----------------------- ------------------------------------------
  Top Sales Product       Standing Desk Converter --- 46.61K Sales
  Top Profit Product      Ergonomic Office Chair --- 15.10K Profit
  Top Region              Europe --- 137.01K Sales
  Top Country             Mexico --- 47.22K Sales
  Top Customer Segment    Consumer --- 256.29K Sales
  Loss-Making Orders      272
  Lowest Profit Product   Paper Clips Box 500pc --- -79.95 Profit

## Overall KPIs

  KPI                 Result
  ---------------- ---------
  Total Sales        484.56K
  Total Profit       158.87K
  Total Orders         2,000
  Total Quantity       7,115
  Profit Margin        32.8%

------------------------------------------------------------------------

# Management Recommendations

## 1. Expand the European Market

Europe is the highest-sales region.

**Action:** Increase marketing investment, maintain product availability
and strengthen customer retention in Europe.

## 2. Target the Consumer Segment

Consumer customers generate the highest sales among the customer
segments.

**Action:** Prioritize targeted promotions, personalized offers,
cross-selling and retention campaigns.

## 3. Reduce Loss-Making Orders

The dashboard identifies 272 loss-making orders.

**Action:** Review pricing, discounts, shipping costs and product-level
margins to identify the causes of negative profit.

## 4. Review Loss-Making Products

Paper Clips Box 500pc has negative profit.

**Action:** Investigate procurement cost, pricing, discounting and
shipping cost before increasing sales volume.

## 5. Protect High-Profit Products

Ergonomic Office Chair is a leading profit contributor.

**Action:** Maintain availability and monitor its margin so that higher
sales do not come at the expense of profitability.

------------------------------------------------------------------------

# Dashboard Design

The report was intentionally designed around a simple
business-storytelling structure:

**Page 1:** What is happening?\
**Page 2:** Which products are driving performance?\
**Page 3:** Where are sales coming from and who are the customers?\
**Page 4:** What should management do?

Design work included:

-   Consistent dark navy headers
-   Color-coded KPI cards
-   Light background containers
-   Consistent chart titles
-   Interactive slicers
-   Page navigation
-   Dynamic insight cards
-   Top 8 views to avoid overcrowding
-   Management recommendation cards
-   Tested visual interactions and filters

------------------------------------------------------------------------

# Validation & Testing

The completed report was tested for:

-   Date slicer behavior
-   Region filtering
-   Product filtering
-   Customer filtering
-   KPI updates
-   Dynamic insight values
-   Cross-filtering
-   Page navigation
-   Visual layout
-   Final dashboard usability

All major tests were completed successfully during the project build.

------------------------------------------------------------------------

# Tools & Technologies

  Tool          Purpose
  ------------- --------------------------------------
  Excel         Data validation and preparation
  MySQL / SQL   Querying and analytical calculations
  Power BI      Dashboard and visualization
  DAX           Measures and dynamic insights
  GitHub        Portfolio/project sharing

------------------------------------------------------------------------

# Project Folder Structure

``` text
E-commerce_Data_Analytics/
│
├── Data/
│   └── global_ecommerce_sales.csv
│
├── Excel/
│   └── steps.xlsx
│
├── SQL/
│   └── queries.sql
│
├── Power Bi/
│   └── E-commerce sales.pbix
│
└── Documentation/
    ├── Ecommerce_Data_Analyst_Project_Documentation.docx
    └── SQL_query.docx
```

------------------------------------------------------------------------

# Resume Description

## E-Commerce Sales & Profit Analytics Dashboard \| Power BI

Developed an interactive 4-page Power BI dashboard to analyze sales,
profitability, product performance, regional performance and customer
segments. Created DAX measures for Total Sales, Total Profit, Total
Orders, Profit Margin, Average Order Value and loss-making orders;
implemented interactive slicers, page navigation and dynamic insight
cards; and translated analytical findings into management
recommendations focused on European market growth, Consumer-segment
targeting and reduction of loss-making orders.

------------------------------------------------------------------------

# Interview Project Summary

A concise explanation:

> I developed an E-Commerce Sales & Profit Analytics Dashboard using
> Excel, SQL, Power BI and DAX. I first validated the dataset in Excel,
> then used SQL for business analysis and aggregation. In Power BI, I
> created four pages covering executive performance, product
> profitability, regional/customer analysis and management
> recommendations. I created DAX measures for key KPIs and dynamic
> insights, added interactive slicers and page navigation, and used the
> analysis to identify high-performing products and markets as well as
> loss-making orders. The final dashboard converts those findings into
> management recommendations.

------------------------------------------------------------------------

# Project Outcome

This project demonstrates an end-to-end Data Analyst workflow:

**Data Quality → SQL Analysis → Power BI → DAX → Visualization →
Business Insights → Recommendations**

The key objective was not only to display data, but to turn the data
into **actionable business information**.
