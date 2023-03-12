## Postgres Database and Server Information

### Nghi's SQL Practice Database

- **server**: 104.225.217.176
- **port**: 8502
- **database**
  - practice_data
  - financial_portfolio
- **username** : postgres
- **password** : nghi2023!

#### Docker Instructions

1. Log onto virtual private server.
2. Using docker, instantiate the following command:

```bash
docker run --name nghi_sql_practice_db -e "POSTGRES_PASSWORD=nghi2023!" -p 8502:5432 -itd postgres:latest
```
