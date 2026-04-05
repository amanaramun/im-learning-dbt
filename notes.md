## Notes

### ACRYNOMS
- DAG directed acyclic graph
- DBT data build tool
- CTE common table expression; breaking logic into multiple steps, for sas users think of just using alot of smaller data steps instead of one big one
- DRY dont repeat yourself
- YAML Yet Another Markup Language

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

#### DBT test
-`dbt test` will run all generic and singular tests defined for each model and report failures
    -__Generic Test__  defined in YAML files e.g. unique, not_null and accepted_values
    -__singular tests__ written in SQL files

##### generic tests    
- to add generci test, add `data_test` block to the models yml. see 02_silver>customer_cleaned.yml
- if your model has foreign  keys you can ensure there are no extra keys sneaking in by validating it on the source where the keys exist
   ```
    model:
        - name: key1
            description: blah
            dat_type: STRING
            data_test:  
            - relationship:
                to: ref('model sql with key 1')
                field: <key1>

        - name: key2
            description: blah
            dat_type: STRING
            data_test:  
            - relationship:
                to: ref('model sql with key 2')
                field: <key2>        
    ```
##### singular tests
written in sql in the test section see postive_price.sql, the `{{ ref ()}}` denotes this will be done with the results of the sql model.
run by `dbt test --select <sql model name>`


#### DBT workflow
1. `dbt build` or `dbt build --select model`
2. `dbt test`
3. `dbt snapshot`
4. `dbt seed`

or

1. `dbt build` or `dbt build --select <model_name>`


#### DBT documentation
- `dbt docs generate` generates json
- `dbt docs serve` looks at documentation

### jinja 

- `{{ source('source_name','table_name') }}` source() function is used to refrence raw data sources defiend in a .yml
- `{{ ref("model_name") }}` ref() function is used to refrence other dbt models within your project
- `{{ %...% }}` for logic and flow control, write loops or use conditions
- `{{ ... }}` resolvoes to a value directly into SQL think of sas macros
- `{{ #... # }}` comments

    ```
    {{% macro name(args) %}}
        {{ do something}}
    {{ %endmacro% }}    


### misc. remindesr
dummy clean up your sql.
sql statments in CAPS

    SELECT
        blah
    FROM source


`git switch <branch-name>` to switch to an existing branch or git switch -c `<new-branch-name>` to create and switch to a new branch.

`git branch` what branch im on?

`git push -u origin <branch-name>` push with the -u (short for --set-upstream) 