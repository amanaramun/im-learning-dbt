## Notes

### ACRYNOMS
- DBT data build tool
- CTE common table expression; breaking logic into multiple steps, for sas users think of just using alot of smaller data steps instead of one big one
- YAML
- DRY dont repeat yourself

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

- `{{ source('source_name','table_name') }}` source() function is used to refrence raw data sources defiend in a .yml
- `{{ ref("model_name") }}` ref() function is used to refrence other dbt models within your project
- `{{ %...% }}` for logic and flow control, write loops or use conditions
- `{{ ... }}` resolvoes to a value directly into SQL think of sas macros
- `{{ #... # }}` comments


    {{% macro name(args) %}}
        {{ do something}}
    {{ %endmacro% }}    


### misc. remindesr
dummy clean up your sql.
sql statments in CAPS


    SELECT
        blah
    FROM source
