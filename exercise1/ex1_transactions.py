import pandas as pd

tran_df = pd.read_csv('data/transaction_takehome.csv')

## Transaction Takehome analysis
# Basic Info
tran_cols = tran_df.columns
print("\nShape:")
print(tran_df.shape)
print("\nColumns:")
print(tran_cols)
print("\nData Types:")
print(tran_df.dtypes)
print("\n")

# Value Counts
for col in tran_cols:
    print(f"Top/Bottom 5 Values of {col}:")
    print(tran_df[col].value_counts(ascending=False))
    print("\n")

# Nulls
print("Nulls in each column:")
print(tran_df.isnull().sum())