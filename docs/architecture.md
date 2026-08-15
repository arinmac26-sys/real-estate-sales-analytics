# Analytics Architecture

```text
Raw Excel → Data Quality / ETL → MySQL Star Schema → KPI / SQL Layer → Tableau → Business Insights
                                      │
                                      ├── dim_date
                                      ├── dim_location
                                      ├── dim_property
                                      └── fact_property_sales
```

Principles: immutable raw layer, explicit staging, dimensional model, indexed fact table, governed KPIs, reproducible QA.
