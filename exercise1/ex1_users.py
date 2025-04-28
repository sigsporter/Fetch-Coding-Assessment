import pandas as pd

user_df = pd.read_csv('data/user_takehome.csv')

## User Takehome analysis

# Basic Info
user_cols = user_df.columns
print("\nShape:")
print(user_df.shape)
print("\nColumns:")
print(user_cols)
print("\nData Types:")
print(user_df.dtypes)
print("\n")

for col in user_cols:
    print(f"Top/Bottom 5 Values of {col}:")
    print(user_df[col].value_counts(ascending=False))
    print("\n")

print("Nulls in each column:")
print(user_df.isnull().sum())
