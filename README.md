# sql-data-warehouse-tutorial-project

This project is a hands-on implementation of a modern data warehouse and analytics solution. From building warehouse to generating actionable insights. This project was completed as a tutorial-based learning project. The purpose was to follow and implement the concepts taught while gaining practical experience with data warehousing and data analytics.

## Data Architecture

The data architecture for this project follows Medallion Architecture Bronze, Silver, and Gold layers:
<img width="1000" height="656" alt="Data Architecture" src="https://github.com/user-attachments/assets/22c21cea-0365-423c-b360-c3ecacf88a52" />

1. Bronze Layer: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. Silver Layer: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. Gold Layer: Houses business-ready data modeled into a star schema required for reporting and analytics.


## Project overview

This project involves:

1. Data Architecture: Designing a Modern Data Warehouse Using Medallion Architecture Bronze, Silver, and Gold layers.
2. ETL Pipelines: Extracting, transforming, and loading data from source systems into the warehouse.
3. Data Modeling: Developing fact and dimension tables optimized for analytical queries.
4. Analytics & Reporting: Creating SQL-based reports and dashboards for actionable insights.

## Project Requirement

### Building the Data Warehouse (Data Engineering)
#### Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
* Data Sources: Import data from two source systems (ERP and CRM) provided as CSV files.
* Data Quality: Cleanse and resolve data quality issues prior to analysis.
* Integration: Combine both sources into a single, user-friendly data model designed for analytical queries.
* Scope: Focus on the latest dataset only; historization of data is not required.
* Documentation: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

## BI: Analytics & Reporting (Data Analysis)
#### Objective
Develop SQL-based analytics to deliver detailed insights into:

* Customer Behavior
* Product Performance
* Sales Trends

These insights empower stakeholders with key business metrics, enabling strategic decision-making.
