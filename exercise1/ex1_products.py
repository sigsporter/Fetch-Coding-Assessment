import pandas as pd

prod_df = pd.read_csv('data/products_takehome.csv')

## Product Takehome analysis
# Basic Info
prod_cols = prod_df.columns
print("\nShape:")
print(prod_df.shape)
print("\nColumns:")
print(prod_cols)
print("\nData Types:")
print(prod_df.dtypes)
print("\n")

for col in prod_cols:
    print(f"Top/Bottom 5 Values of {col}:")
    print(prod_df[col].value_counts(ascending=False))
    print("\n")

print("Nulls in each column:")
print(prod_df.isnull().sum())
