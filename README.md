# 🛒 Walmart Sales Analysis
Created by Elethu Filtane

📊 Overview
This project explores Walmart’s sales performance using data from Kaggle.
The goal was to clean, analyze, and visualize the data to uncover insights into profitability, category performance, branch efficiency, and yearly trends.
The analysis combines Python (Pandas) for data cleaning, PostgreSQL for querying and analysis, and Excel for creating an interactive dashboard showcasing key business metrics.

# 🗂️ Dataset
Source: Walmart Sales Dataset (Kaggle)
Data Description: Includes sales transactions with details such as branch, date, category, unit price, quantity, and customer ratings.

# 🧰 Tech Stack
# Tool	    Purpose
Python      (Pandas)	Data cleaning, preprocessing, and exploratory analysis
PostgreSQL	Querying and aggregations
Excel	    Dashboard creation and visualization

# ⚙️ Data Cleaning & Preparation

Performed in Python using Pandas:

* Handled missing values and corrected data types
* Removed duplicates and standardized column names
* Created new calculated fields (total sale)
* Exported the cleaned dataset to PostgreSQL for querying

# 🧮 SQL Analysis
Using PostgreSQL, several analytical queries were run to extract insights, such as:

Busiest day in a month at each branch by number of transactions
Quarterly and annual profit margins
Category-wise performance and customer ratings
Best performing branch based on total sales and profit

# 📈 Excel Dashboard
An interactive Excel dashboard was designed to visualize:
🗓️ Yearly and Quarterly Profit Trends
🏆 Top Performing Branches
🧾 Category-wise Ratings and Profit Distribution
💹 Total Profits Over Time
The dashboard provides management-level insights into branch efficiency, seasonal trends, and customer satisfaction.


# 🔍 Key Insights

- Branch WALM084 had the highest decrease ratio in revenue over the years.
- Fashion accessories and Home lifestyle were the best-performing categories in total sales.
- Q4 consistently showed a spike in profits, suggesting strong holiday demand.
- Branch WALM052 achieved the highest profit margin.