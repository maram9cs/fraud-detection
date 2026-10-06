# Fraud Detection Project

An end-to-end analytics portfolio project using the IEEE-CIS Fraud Detection dataset. The project explores fraud patterns, compares ML models, and turns validation predictions into SQL reporting tables and a Power BI report.

# Project objectives

- Identify transaction segments associated with higher actual fraud rates
- Investigate whether missing information is associated with different fraud rates
- Compare models and examine the most important features of the selected model
- Evaluate the trade-off between fraud detection and false alerts

# Tools

Python (pandas, scikit-learn, CatBoost, LightGBM ...), VS, Jupyter NB, SQLAlchemy, SQL Server, Power BI

# Dataset 
Source: Fraud Detection on Kaggle (https://www.kaggle.com/competitions/ieee-fraud-detection).
Note: 
*Data is not included in this repository*, you can download it directly from Kaggle 


# Reporting Scope

Only the [118,108] transactions from the chronological validation set were loaded into the SQL transaction reporting table and used to build the Power BI dashboard. Training transactions and Kaggle test transactions are excluded from the dashboard

# SQL reporting layer

The FraudDetection database contains four loaded tables:
* ScoredValidation: Validation transactions, actual labels, probabilities, predictions, and reporting features
* ModelComparison: Model evaluation summaries
* ThresholdComparison: valuation summaries at alternative thresholds
* FeatureImportance: Tuned model feature importance 


# Power BI report

Has four pages:
* Fraud Patterns: Which transaction segments have higher actual fraud rates?
* Missing Data: How do fraud rates differ when information is missing or available?
* Important Features: Which features contribute most to the selected model?
* Model Performance: What is detected, what is missed, and how do alternative thresholds compare?

# The Power BI template

`.pbix` working file is excluded because it contains imported transaction data. Opening the template requires configuring the data source and loading the SQL reporting tables locally.


# Key Findings

- Fraud rates differ by identity availability: [1.96%] without identity information versus [9.34%] with it.
- V258 is the leading feature, contributing [13.10%] of model gain importance.
- High missingness alone does not justify removing a feature
- At threshold 0.20, the model detects [50.15%] of fraud transactions with [59.52%] precision.


