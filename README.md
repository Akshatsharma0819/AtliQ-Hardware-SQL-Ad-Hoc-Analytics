# 🛒 AtliQ Hardware: SQL Ad-Hoc Analytics

### 📊 Business Context
AtliQ Hardwares, a global computer hardware manufacturer, required rapid, data-driven answers to ad-hoc queries from the executive team. Traditional Excel-based reporting was too slow to support dynamic decision-making regarding product growth, market revenue, and customer volume.

### 🎯 Project Objective
Acted as a Data Analyst to translate 10 urgent executive requests into optimized SQL queries, extracting real-time business insights directly from the company's relational database.

### 🛠️ Tech Stack & Database
* **Tool:** MySQL / MySQL Workbench
* **Database Design:** Star Schema (2 Fact tables, 2 Dimension tables)
* **Key SQL Concepts Applied:** * Common Table Expressions (CTEs)
  * Window Functions (`DENSE_RANK`, `PARTITION BY`)
  * Multi-Table `JOIN` operations
  * Subqueries & Data Aggregation (`GROUP BY`, `SUM`, `MAX`)
  * Time-Intelligence (`YEAR()`, `MONTHNAME()`)

### 💡 Top 4 Business Insights Discovered
1. **Revenue Concentration:** Amazon emerged as the #1 customer by total gross revenue, despite other regional platforms having higher overall unit volume. 
2. **Geographic Dominance:** The USA market generated the highest total gross sales in 2021, marking it as the primary target for future marketing spend.
3. **Seasonality:** May 2021 was identified as the peak month for total sold quantity, indicating a need for inventory ramp-up in late Q1.
4. **Product Growth:** The product portfolio grew by ~40% between 2020 and 2021, driven primarily by the "Notebook" and "Accessories" segments.

### 📁 Repository Contents
* `1_database_setup.sql`: DDL and DML scripts used to generate the schema and load the mock dataset.
* `2_ad_hoc_queries.sql`: The complete set of commented SQL queries written to answer the 10 executive requests.
