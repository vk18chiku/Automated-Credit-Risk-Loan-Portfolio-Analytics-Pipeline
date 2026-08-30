# 🏦 Automated Credit Risk & Loan Portfolio Analytics Pipeline

An end-to-end automated data analytics and credit risk pipeline that transforms large-scale loan data into a structured MySQL database and an interactive Power BI dashboard.

Raw Financial Data → Python ETL → Feature Engineering → Risk Classification → MySQL → Power BI DirectQuery → Business Insights

---

## 📌 Project Overview

This project is an end-to-end automated data analytics pipeline designed to evaluate credit risk and analyze a large-scale loan portfolio.

The pipeline automates the extraction, transformation, and loading (ETL) of financial data and delivers an interactive Power BI dashboard for analyzing:

* Loan portfolio performance
* Default risk
* Borrower segmentation
* Credit grade behavior
* Loan purpose distribution
* Financial risk indicators

The project demonstrates a complete analytics workflow from raw financial data to actionable business insights using Python, MySQL, and Power BI.

---

## 🗄 Data Source & Privacy Note

The dataset used in this project is the Lending Club Loan Data (2007–2018).

The original dataset contains hundreds of thousands of financial records covering borrower characteristics, loan details, repayment status, and credit-related information.

> Note: The raw CSV dataset is not included in this repository due to GitHub file-size limitations.

Dataset source:

https://www.kaggle.com/datasets/wordsforthewise/lending-club

---

# 📊 Dashboard Preview

## Executive Portfolio Overview

<p align="center">
  <img src="Screenshot 2026-08-30 231021.png">
</p>

The executive dashboard provides a high-level view of the loan portfolio, including:

* Total Loans
* Total Funded Amount
* Default Rate
* Loan Status Breakdown
* Top Loan Purposes
* Funding Trend Over Time
* Portfolio Risk Breakdown
* Loan Term filters
* Issue Date filters

---

## Risk & Default Deep Dive

<p align="center">
  <img src="./screenshots/screenshots/risk_default_deep_dive.png" alt="Risk and Default Deep Dive Dashboard" width="1000">
</p>

The Risk & Default Deep Dive dashboard focuses on borrower risk and default behavior, including:

* Average Interest Rate
* Average Debt-to-Income Ratio
* Total Default Amount
* Default Rate by Credit Grade
* Employment Stability vs Defaults
* Default by Home Ownership
* Borrower Risk Matrix
* Credit Grade filters
* Risk Category filters

---

# 🛠 Tech Stack & Tools

| Category                         | Tools                                  |
| -------------------------------- | -------------------------------------- |
| Data Extraction & Transformation | Python, Pandas                         |
| Database Management              | MySQL                                  |
| Database Connectivity            | SQLAlchemy, PyMySQL                    |
| Feature Engineering              | Python, Pandas                         |
| Business Intelligence            | Power BI                               |
| Data Visualization               | Power BI                               |
| Database Reporting               | Power BI DirectQuery                   |
| Workflow Automation              | Windows Task Scheduler, Python Scripts |
| Version Control                  | Git, GitHub                            |

---

# 🚀 Key Features & Automation

## 1. Automated Python ETL Pipeline

Developed an optimized Python ETL pipeline using Pandas to process approximately 400K loan records efficiently.

The pipeline uses:

* Chunking to process data in manageable batches
* `usecols` to load only required columns
* Data cleaning and transformation
* Missing-value handling
* Data type optimization
* Automated feature engineering

These techniques help reduce memory consumption and improve processing performance when working with large CSV files.

---

## 2. Custom Risk Feature Engineering

Implemented business rules in Python to classify borrowers into three risk categories:

* 🟢 Low Risk
* 🟡 Medium Risk
* 🔴 High Risk
The risk classification uses borrower financial characteristics such as:

* Debt-to-Income (DTI) ratio
* Annual income
* Credit-related attributes
* Loan characteristics

This enables the portfolio to be analyzed across different borrower risk segments.

---

## 3. MySQL Database Integration

The transformed dataset is automatically loaded into a MySQL database using:

* SQLAlchemy
* PyMySQL

MySQL acts as the structured database layer between the Python ETL pipeline and Power BI.

This provides a centralized and queryable source for analytics and reporting.

---

## 4. Power BI DirectQuery Integration

Power BI is connected to the MySQL database using DirectQuery.

This allows Power BI reports to query the underlying database directly rather than importing the complete dataset into the Power BI model.

The architecture demonstrates how a BI reporting layer can be connected to a database-backed analytics pipeline.

---

## 5. Interactive Financial Risk Dashboard

Built an executive-style Power BI dashboard focused on:

* Loan portfolio performance
* Default risk
* Borrower segmentation
* Credit grade analysis
* Loan purpose analysis
* Financial risk indicators

The dashboard provides interactive filtering and drill-down capabilities for portfolio analysis.

---

# 📊 Core Business Metrics Analyzed

## 1. Total Loan Portfolio

Measures the overall number and financial value of loans within the analyzed portfolio.

---

## 2. Defaulted Loan Value

Measures the total monetary value associated with loans classified as:

* Default
* Charged Off

This provides an indication of the financial exposure associated with credit losses.

---

## 3. Overall Default Rate

Measures the percentage of loans classified as defaulted or charged off within the analyzed loan portfolio.

This serves as a key indicator of overall portfolio credit quality.

---

## 4. Risk Segmentation

Loan performance and default behavior are analyzed across:

* Low Risk
* Medium Risk
* High Risk
* Credit Grades A–G
* Loan Purposes

This helps identify segments with relatively higher or lower credit risk.

---

## 5. Borrower Profiling

The project analyzes relationships between borrower characteristics and loan outcomes, including:

* Annual Income
* Debt-to-Income Ratio
* Home Ownership
* Employment Length
* Credit Grade
* Loan Purpose
* Loan Status

---

# 🔍 Key Business Questions

The dashboard can be used to answer questions such as:

### Portfolio Performance

* What is the total funded loan amount?
* How many loans are present in the portfolio?
* How has funding changed over time?
* Which loan purposes account for the largest portfolio exposure?

### Credit Risk

* Which credit grades have higher default exposure?
* Which risk categories contain the highest concentration of risky borrowers?
* How does DTI relate to default behavior?
* What is the total financial exposure from defaulted loans?

### Borrower Analysis

* Does employment stability relate to default behavior?
* How does home ownership relate to loan outcomes?
* How does borrower income vary across risk categories?

---

# 🔄 End-to-End Data Pipeline

copy


Raw Lending Club CSV
        ↓
     Python
     Pandas
        ↓
Data Cleaning & Transformation
        ↓
Feature Engineering
        ↓
Risk Classification
        ↓
      MySQL
        ↓
   Power BI
   DirectQuery
        ↓
Interactive Risk Dashboard
        ↓
Business Insights

---

# ⚙️ Automation Workflow

The project is designed to minimize manual data-processing steps.

copy


Raw Dataset
     ↓
Python ETL Script
     ↓
Data Cleaning
     ↓
Feature Engineering
     ↓
Risk Classification
     ↓
MySQL Database
     ↓
Power BI DirectQuery
     ↓
Dashboard Analysis

The Python ETL process can be scheduled using Windows Task Scheduler, allowing the pipeline to run automatically at predefined intervals.

---

# 📁 Project Structure
copy


Credit-Risk-Loan-Analytics-Pipeline/
│
├── README.md
├── LICENSE
│
├── el_pipeline.py
├── risk_analytics_queries.sql
├── Dashboard.pbix
│
└── screenshots/
    └── screenshots/
        ├── executive_portfolio_overview.png
        └── risk_default_deep_dive.png

> Note: The nested screenshots/screenshots/ structure reflects the current repository structure. If you later move the two images directly into the first screenshots folder, change the image paths in this README to ./screenshots/filename.png.

---

# ▶️ How to Run This Project

## 1. Clone the Repository

Bash


git clone https://github.com/Jay1912-pixel/Credit-Risk-Loan-Analytics-Pipeline.git
cd Credit-Risk-Loan-Analytics-Pipeline

## 2. Download the Dataset

Download the Lending Club dataset from Kaggle and place the CSV file in your local project directory.

Dataset:

https://www.kaggle.com/datasets/wordsforthewise/lending-club

---

## 3. Install Python Dependencies

Bash


pip install pandas sqlalchemy pymysql

---

## 4. Configure MySQL

Create a MySQL database:

SQL


CREATE DATABASE credit_risk_db;

Configure the MySQL connection details in the Python ETL script.

---

## 5. Run the ETL Pipeline

Run:

Bash


python el_pipeline.py

The pipeline performs:

1. Raw CSV extraction
2. Chunk-based processing
3. Data cleaning
4. Data transformation
5. Feature engineering
6. Risk classification
7. MySQL loading

---

## 6. Connect Power BI to MySQL

Open:

copy


Dashboard.pbix

Connect Power BI to the MySQL database using DirectQuery.

---

## 7. Explore the Dashboard

Use the interactive dashboard filters to analyze:

* Loan term
* Issue date
* Credit grade
* Risk category
* Loan status
* Loan purpose
* Borrower characteristics

---

# 📈 Dashboard Pages

| Dashboard                    | Focus                                                                   |
| ---------------------------- | ----------------------------------------------------------------------- |
| Executive Portfolio Overview | Portfolio KPIs, funding trends, loan status and risk distribution       |
| Risk & Default Deep Dive     | Default behavior, credit grades, borrower risk and financial indicators |

---

# 💡 Business Insights

The dashboard can help identify:

* High-risk borrower segments
* Credit grades associated with greater default exposure
* Loan purposes with significant portfolio exposure
* Relationships between DTI and default behavior
* Differences in default behavior across employment categories
* Differences in loan outcomes based on home ownership

These insights can support better credit risk monitoring, portfolio management, and borrower segmentation.

---

# 🧠 Skills Demonstrated

This project demonstrates practical experience with:

* Python
* Pandas
* SQL
* MySQL
* ETL Pipelines
* Data Cleaning
* Feature Engineering
* SQLAlchemy
* PyMySQL
* Power BI
* DirectQuery
* Data Visualization
* Credit Risk Analytics
* Financial Analytics
* Business Intelligence
* Workflow Automation
* Git & GitHub

---

# ⭐️ Project Highlights

* 400K+ loan records processed
* Automated Python ETL pipeline
* Memory-efficient CSV processing using chunking
* Selective column loading using usecols
* Custom borrower risk classification
* MySQL database integration
* Power BI DirectQuery implementation
* Interactive credit risk dashboard
* Credit grade and default analysis
* Loan purpose analysis
* Borrower profiling
* Automated workflow capability using Windows Task Scheduler

---

# 👨‍💻 Author

Uttam Kumar Mahato

B.Tech — Electronics & Communication Engineering(ES & IOT)
IIIT Ranchi

Data Analytics Skills: SQL • Python • Power BI • MySQL • Excel

GitHub:https://github.com/vk18chiku/Automated-Credit-Risk-Loan-Portfolio-Analytics-Pipeline


Kaggle
All Lending Club loan data
2007 through current Lending Club accepted and rejected loan data
