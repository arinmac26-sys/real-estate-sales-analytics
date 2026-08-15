from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

DATA = Path(__file__).resolve().parents[2] / "data/raw/Real_Estate_Sales_2011-2022.xlsx"
df = pd.read_excel(DATA)
df["Date Recorded"] = pd.to_datetime(df["Date Recorded"], errors="coerce")
df["Sale Amount"] = pd.to_numeric(df["Sale Amount"], errors="coerce")
df["year"] = df["Date Recorded"].dt.year

annual = df.dropna(subset=["Sale Amount"]).groupby("year").agg(
    transactions=("Serial Number","count"),
    sales_value=("Sale Amount","sum"),
    avg_sale=("Sale Amount","mean")
).reset_index()
print(annual)
annual.plot(x="year", y="sales_value", kind="line", marker="o", legend=False)
plt.title("Annual Sales Value")
plt.tight_layout()
plt.show()
