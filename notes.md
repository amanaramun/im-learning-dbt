## Notes

### Misc commands you never remember

`pyhton3 -m venv .venv`

`.venv\Script\activate`


#### creating a new file in powershell
`New-item -Path "./generate_schema_name.sql" -ItemType File`

#### duckdb commands
`duckdb -ui dlnerds_store.duckdb`

### DBT commands
- `dbt init <project name>`
- `dbt list -- select "sources:"` prints out all the data configed by the sources.yml found in 01_bronze>model
- `dbt seed`  oad all csv files into the seeds/ directory into the warehouse
- `dbt run --select <something.sql>` runs sql code in models
- `dbt run --select tag:<tag>` runs all models with the <tag>  found in dbt_project.yml
- `dbt compile  --select <somthing.sql>` compiles the sql code from model 

### jinja 