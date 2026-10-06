# Fraud Detection — Project Documentation

# 1. Purpose and scope

This portfolio project connects exploratory analysis and machine learning in Python with a SQL Server reporting layer and a Power BI report. It investigates fraud patterns, missing information, model feature importance, and prediction performance using the IEEE-CIS Fraud Detection dataset.

The project is an analytical demonstration. It does not block transactions, recover funds, or operate as a live fraud detection service.

# 2. Data sources and grain

Source: [IEEE-CIS Fraud Detection on Kaggle](https://www.kaggle.com/competitions/ieee-fraud-detection/data).


# 3. Python analysis and modeling

# Exploratory analysis

- Inspect row counts, column types, duplicate identifiers, missing values, and constant or fully empty columns.
- Classify features into groups such as card, address, email, device, identity, and anonymized numeric features.

# Feature preparation

The documented model input contains 433 features: 31 categorical and 402 numeric/bool features. Engineered features include `HasIdentity` and transaction hour (`TranHour` in the reporting export). Model-specific preparation is applied to categorical and numeric inputs; preprocessing fitted on training data must be reused for validation and competition test data.

The target `isFraud` and transaction identifier are excluded from model inputs. Transaction time is used to order the chronological split. Calendar dates derived from an assumed origin should not be presented as verified event dates.

# Chronological validation

* Training:  472,432 Transactions (80%)
* Validation: 118,108 Trsancations (20%)


# Model results

it is kept in kept in `Data/processed/`, the foles name is **model_comparison**
Selected model: **LightGBM Tuned**. Its Kaggle public score is [0.932229] and private score is [0.909055]


# 4. Processed exports and SQL Server

The final Python notebook prepares four tables for SQL. Local exports are kept in `Data/processed/`.
Database: `FraudDetection`; schema: `dbo`.


# 5. Reporting scope and model behavior

Only the [118,108] chronological validation transactions are loaded into the SQL transaction reporting table and used in Power BI transaction analysis. Training and Kaggle test transactions are excluded from the dashboard.

ModelComparison, ThresholdComparison, and FeatureImportance are summary tables. 

The report uses Import mode. Summary tables can remain disconnected from the transaction table. If a date dimension is used, relate its unique date column to a date-only transaction column and document any assumed date origin.

# 6. Prediction definitions & metric logic

* Stored default threshold: [0.20]

* True Positive (TP): Actual fraud correctly flagged.
* False Positive (FP): Legitimate transaction incorrectly flagged.
* False Negative (FN): Actual fraud missed by the model.
* True Negative (TN): Legitimate transaction correctly classified.

* Precision: TP / (TP + FP)
* Recall: TP / (TP + FN)
* F1 Score: 2 × Precision × Recall / (Precision + Recall) 

# Cards in power BI Report:
* Total Transactions: Transaction row count 
* Transaction - Fraud: Count where ActualFraud = 1
* % Fraud Rat: Transaction - Fraud / Total Transactions 
* $ Fraud Amount: Sum Amount where ActualFraud = 1

* % Mising Idintity Info.: Count where HasIdentity = false / Total Transactions 
* % Avail. Identity - Fraud: raud count where HasIdentity = true / Transaction count where HasIdentity = true 
* % Missing Identity - Fraud: Fraud count where HasIdentity = false / Transaction count where HasIdentity = false 

* Features:  Number of features/Columns used as model inputs: 433 
* % Top 20 Cum. Importance:  Sum of normalized importance for the 20 highest-ranked features

* % Predectied Fraud: Count where PredictedFraud = 1 / Total Transactions 
* % Recall - Threshold 0.2: TP / (TP + FN), using threshold 0.20 
* % Precision - Threshold 0.2: TP / (TP + FP), using threshold 0.20
* % F1 Score - Threshold 0.2: 2 × Precision × Recall / (Precision + Recall), using threshold 0.20


# 8. Power BI report pages
* Fraud Patterns: Explore actual fraud patterns.
  -  content: Transaction totals, fraud rate and amount, and product, amount, time, and category comparisons.
* Missing Data: Explore data availability and its association with fraud.
  -  content: Identity availability cards and missing-versus-available comparisons
* Important Features: Explain model reliance on features.
  -  content: Ranked gain importance, cumulative importance, and selected feature analysis.
* Model Performance: Evaluate detection performance and model quality.
  -  content: Model comparison, alert rate, precision, recall, F1, and prediction outcomes.


# 9. Repository and deliverables
* Data/: raw and processed files retained locally.
* Documentation/: Technical project documentation and supporting metric notes.
* Output/: Saved models and (threshold, and importance summaries for Catboost for reviewing)
* Power BI/: Dashboard presentation (.pptx) and report template (.pbit)
* Python/: Analysis, modeling, and SQL loading notebooks.
* SQL/: Validation, and reporting SQL scripts.
* README.md:  Project overview, results.



# 10. Reproduction sequence

1. Download source data from Kaggle under its applicable terms.
2. Place files at the paths used by the notebooks.
3. Install the notebook dependencies using the final project's verified dependency list.
4. Run EDA, baseline modeling, model comparison/tuning, and export notebooks in order.
5. Prepare SQL Server and the FraudDetection database; configure the local Python connection.
6. Load the four exports and run validation SQL before creating reporting views.
7. Open the PBIT, configure its source, and refresh.