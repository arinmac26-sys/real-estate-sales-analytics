from pathlib import Path
import pandas as pd

DATA = Path(__file__).resolve().parents[2] / "data/raw/Real_Estate_Sales_2011-2022.xlsx"

def profile(path=DATA):
    df = pd.read_excel(path)
    return {
        "rows": len(df),
        "columns": len(df.columns),
        "duplicate_serial_numbers": int(df["Serial Number"].duplicated().sum()),
        "missing_sale_amount_pct": round(df["Sale Amount"].isna().mean()*100,2),
        "negative_sale_amounts": int((df["Sale Amount"].fillna(0)<0).sum()),
        "invalid_dates": int(pd.to_datetime(df["Date Recorded"], errors="coerce").isna().sum()),
    }

if __name__ == "__main__":
    print(profile())
