from pathlib import Path
import pandas as pd

DATA = Path(__file__).resolve().parents[1] / "data/processed/real_estate_sales_sample_50k.csv"

def test_required_columns_exist():
    df = pd.read_csv(DATA, nrows=5)
    assert {"serial_number","date_recorded","town","assessed_value","sale_amount","property_type","state"}.issubset(df.columns)

def test_no_negative_sale_amounts():
    df = pd.read_csv(DATA, usecols=["sale_amount"])
    assert (df["sale_amount"].dropna() >= 0).all()

def test_serial_number_is_unique_in_sample():
    df = pd.read_csv(DATA, usecols=["serial_number"])
    assert df["serial_number"].is_unique
