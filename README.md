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

## Features



