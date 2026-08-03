
# Nashville Housing Data Cleaning using SQL

A SQL data cleaning project focused on preparing a real-world housing dataset for analysis by transforming, standardizing, and improving data quality using Microsoft SQL Server.

The project demonstrates common data cleaning techniques used by Data Analysts and Data Engineers, including handling missing values, standardizing formats, splitting columns, removing duplicates, and optimizing the dataset for downstream analytics.

## Project Objective

The objective of this project is to clean and transform raw housing sales data into a structured, analysis-ready dataset using SQL queries.

## Features

- Bulk import CSV data into SQL Server
- Standardize date formats
- Populate missing property addresses
- Split property and owner addresses into separate columns
- Standardize categorical values
- Remove duplicate records
- Drop unnecessary columns
- Prepare a clean dataset for reporting and analysis

## Tech Stack

- Microsoft SQL Server
- SQL
- SQL Server Management Studio (SSMS)
- CSV Dataset


## 📂 Repository Structure

```text
  Data Cleaning/
│
├── Housing_data.csv
├── Data Cleaning.sql
├── README.md

```
## Project Workflow

```text
Raw Housing CSV
        │
        ▼
Bulk Import into SQL Server
        │
        ▼
Standardize Date Format
        │
        ▼
Handle Missing Property Addresses
        │
        ▼
Split Address Fields
(Property, City, State)
        │
        ▼
Standardize Categorical Values
(Y/N → Yes/No)
        │
        ▼
Remove Duplicate Records
        │
        ▼
Drop Unused Columns
        │
        ▼
Clean & Analysis-Ready Dataset
```

## Data Cleaning Steps

### 1. Import Data
- Created SQL table
- Imported CSV using **BULK INSERT**

### 2. Standardize Date Format
- Converted `SaleDate` to SQL Date datatype

### 3. Handle Missing Values
- Populated missing `PropertyAddress` values using self joins based on `ParcelID`

### 4. Split Address Columns
Separated addresses into individual fields:

**Property Address**
- Property Address
- Property City

**Owner Address**
- Owner Address
- Owner City
- Owner State

### 5. Standardize Data
Converted:

- Y → Yes
- N → No

in the `SoldAsVacant` column.

### 6. Remove Duplicate Records
Used the `ROW_NUMBER()` window function to identify and delete duplicate records based on:

- ParcelID
- Property Address
- Sale Date
- Sale Price
- Legal Reference

### 7. Remove Unnecessary Columns
Dropped unused columns including:

- OwnerAddress
- PropertyAddress
- TaxDistrict

## SQL Concepts Demonstrated

- BULK INSERT
- UPDATE Statements
- Self Joins
- Common Table Expressions (CTEs)
- ROW_NUMBER()
- Window Functions
- CASE Statements
- ISNULL()
- PARSENAME()
- SUBSTRING()
- CHARINDEX()
- ALTER TABLE
- DROP COLUMN
- Data Standardization
- Duplicate Removal

## Skills Demonstrated

- SQL Data Cleaning
- Data Wrangling
- Data Transformation
- Data Quality Improvement
- SQL Server
- Data Preparation
- Window Functions
- Query Optimization
- Analytical SQL

## 📁 Dataset

The project uses the **Nashville Housing Dataset**, containing housing sales information such as:

- Property Details
- Owner Information
- Sale Price
- Sale Date
- Property Address
- Land Value
- Building Value
- Property Characteristics
