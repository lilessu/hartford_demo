Hartford Jobs Analytics Dashboard

A full-stack data pipeline and analytics dashboard built to demonstrate skills relevant to the Application & Data Developer role at The Hartford.

This project scrapes job postings from The Hartford careers site, loads them into a PostgreSQL data warehouse, performs SQL-based analytics, and exposes the results through a lightweight Flask dashboard with export functionality.

Project Overview

This application implements an end-to-end workflow:

Hartford Careers Site
        ↓
Python Web Scraper
        ↓
Staging Table (PostgreSQL)
        ↓
SQL Transformations
        ↓
Star Schema Data Warehouse
        ↓
Analytics Queries
        ↓
Flask Dashboard + CSV Export

The goal was to simulate a typical data engineering / application developer workflow, including:

data ingestion

ETL pipeline

dimensional modeling

analytics queries

simple application layer

Features
Web Scraping

Scrapes all Hartford job postings

Extracts structured job data including:

title

location

category

employment type

work mode

salary ranges

description

job reference ID

Data Pipeline

Loads scraped data into a PostgreSQL staging table

Performs SQL transformations to populate a star schema warehouse

Warehouse schema:

fact_jobs
│
├── dim_location
├── dim_category
├── dim_employment_type
└── dim_work_mode
Analytics Queries

The dashboard executes prebuilt SQL queries such as:

Jobs by location

Jobs by category

Jobs by work mode

Average salary overall

Average salary by category

Average salary by location

Average salary by work mode

Salary by category/location combinations

Category distribution by location

Category distribution by work mode

Top paying jobs

Work mode breakdown by category

CSV Export

The full dataset can be exported as a CSV file directly from the dashboard.

Export filenames automatically include timestamps:

hartford_jobs_export_20260312_164015.csv
Web Dashboard

A simple Flask UI allows users to:

refresh job data

run analytics queries

view results in a table

download full dataset exports

Technology Stack

Backend

Python

Flask

PostgreSQL

psycopg2

pandas

Data Pipeline

BeautifulSoup

requests

SQL ETL scripts

Frontend

HTML

CSS

Inter font

lightweight dashboard layout
