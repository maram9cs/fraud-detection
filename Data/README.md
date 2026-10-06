# Dataset Instructions

This project uses the IEEE-CIS Fraud Detection dataset on [Kaggle]
Link: https://www.kaggle.com/competitions/ieee-fraud-detection/data

The files names that we need to download form the competition source are:
* `train_transaction.csv`
* `train_identity.csv`
* `test_transaction.csv`
* `test_identity.csv`

*Files excluded from the repository*

# Processed SQL Export Tables
In this project, `Data/processed/` contains the four tables exported from the final Python notebook for loading into SQL Server.

* ScoredValidation: 118,108 transactions (Validation set) *excluded from the repository*
* ModelComparison: Aggregate model evaluation results
* ThresholdComparison: Aggregate evaluation results at different thresholds
* FeatureImportance: Model feature importance results


