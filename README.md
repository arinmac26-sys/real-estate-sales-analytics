# Real Estate Sales Analytics — Senior Data Analyst Portfolio

End-to-end analytics portfolio project covering **data quality → SQL data model → DDL/DML/DQL → advanced SQL → Python → Tableau → GitHub QA**.

## Business Questions
- How are sales changing over time?
- Which towns/states drive the most sales value?
- Which property types drive transaction volume and value?
- Where are sales-ratio outliers?
- What data-quality issues can affect executive reporting?

## Tech Stack
**MySQL 8+ · SQL · Python/Pandas · Tableau · Git/GitHub · GitHub Actions · pytest**

## Repository Structure
```text
real-estate-sales-analytics/
├── .github/                 # CI + issue templates
├── dashboard/
│   ├── screenshots/         # Portfolio PNGs
│   └── tableau/             # Tableau workbook
├── data/
│   ├── raw/                 # Source workbook
│   └── processed/           # Analytical sample
├── docs/                    # Architecture, KPIs, dictionary, insights
├── python/
│   ├── src/                 # Reusable analytics scripts
│   └── notebooks/
├── sql/
│   ├── ddl/                 # Database + table definitions
│   ├── dml/                 # Load + transform + cleanup
│   ├── dql/                 # Business queries
│   └── advanced/            # CTE/window/rolling analysis
├── tests/
├── requirements.txt
├── .gitignore
└── LICENSE
```

## SQL Execution Order
1. `sql/ddl/01_create_database.sql`
2. `sql/ddl/02_create_tables.sql`
3. `sql/dml/01_load_staging.sql`
4. `sql/dml/02_transform_to_fact.sql`
5. `sql/dml/03_data_quality_cleanup.sql`
6. `sql/dql/*.sql`
7. `sql/advanced/*.sql`

## Python
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python python/src/data_quality.py
python python/src/eda.py
pytest -q
```

## Tableau
The supplied workbook is preserved in `dashboard/tableau/Real_Estate_Sales_Dashboard.twb`.

Dashboard sheets include KPI cards, sales trend, property distribution, residential treemap, map, sales-ratio heatmap and town ranking.

## Senior Analyst Capabilities Demonstrated
- Dimensional modelling and analytical schema design
- SQL CTEs, window functions, rankings and rolling metrics
- Data profiling and quality controls
- KPI governance and metric definitions
- Market segmentation and contribution analysis
- Tableau executive dashboarding
- Git branching, PR and CI workflow
- Business insight documentation

## GitHub / Git LFS
The source workbook is large. For a public repository, Git LFS is recommended:
```bash
git lfs install
git lfs track "data/raw/*.xlsx"
git add .gitattributes
```

## Author
**Arindam Das Biswas** — Senior Data Analytics Portfolio
