# Hartford Jobs Analytics Dashboard

A full-stack data pipeline and analytics dashboard built to demonstrate skills relevant to the **Application & Data Developer** role at **The Hartford**.

This project scrapes job postings from The Hartford careers site, loads them into a PostgreSQL data warehouse, runs SQL analytics, and exposes results through a Flask dashboard with CSV export functionality.

---

## Project Overview

This application implements an end-to-end workflow:

```text
Hartford Careers Site
        ↓
Python Web Scraper
        ↓
PostgreSQL Staging Table
        ↓
SQL Transformations
        ↓
Star Schema Data Warehouse
        ↓
Analytics Queries
        ↓
Flask Dashboard + CSV Export

```
The goal was to simulate a typical data engineering and application developer workflow, including:

- automated data ingestion

- ETL pipeline design

- dimensional modeling

- SQL analytics

- lightweight application developmen

# Features
## Web Scraping
The scraper extracts structured job data including:

- job title

- location

- category

- employment type

- work mode (remote / hybrid / in-office)

- salary range

- job description

- job reference ID

## Data Pipeline
Scraped data is loaded into PostgreSQL using a two-stage ETL process.
### Staging Layer
Raw scraped job data is inserted into a staging table.
### Warehouse Layer
SQL transformation scripts populate a star schema warehouse.

Schema design:
```text
fact_jobs
│
├── dim_location
├── dim_category
├── dim_employment_type
└── dim_work_mode
```

## Analytics Queries
The dashboard executes reusable SQL queries such as:

- Jobs by location

- Jobs by category

- Jobs by work mode

- Average salary overall

- Average salary by category

- Average salary by location

- Average salary by work mode

- Average salary by category/location combinations

- Category distribution by location

- Category distribution by work mode

- Work mode breakdown by category

- Top paying jobs

- Full export query

## CSV Export
The full dataset can be exported directly from the dashboard.

Export filenames automatically include timestamps, for example:
```text
hartford_jobs_export_20260312_164015.csv
```


