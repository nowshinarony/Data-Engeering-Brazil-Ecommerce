# Data-Engeering-Brazil-Ecommerce
This repository presents my ongoing project on creating an end-to-end data pipeline using the [Brazil Ecommerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). This is project showcases my hands-on experience in different data-specific skills. 

My computer is: Macbook Air M2 OS: 14.5

So far, the project steps done:

- Creating a Entity Relationship Diagram through analyzing the original CSV files. Tools: Draw.IO, MS Excel
- Developing a database and loading the data from CSV files. Tools: PostgreSQL


## ERD (data model) from the Original Dataset
![ERD1](https://github.com/nna01/Data-Engeering-Brazil-Ecommerce/assets/28835420/7b1d0ce6-de03-4bab-9472-74a66493b589)


## Implementing the data model (ERD) using PostGreSQL 
- Create a new database named: brazilEcommerce
- Open query tool -> run the sql commands in the file [OriginalERDTables.sql](OriginalERDTables.sql)
- Open PSQL tool -> run the commands in file [loadDatafromCSV.rtf](loadDatafromCSV.rtf). Change the path to the path of your csv files.

## Deciding whether to transform ERD to Star or Snowflake Schema
- First I tried to implement a Star Schema. However, the Star Schema was not enabling the inclusion of all data tables such as reviews and payments. I googled and chatgpt ed option. However, neither gave me feasible answers. No matter what I did, some data would go missing. 
- Thus, after two days of brainstorming and trying to implement different version on PostgreSQL, I opted for a Snowflake schema which worked out well.


## Snowflake Schema Diagram

![Snowflake_Schema](https://github.com/user-attachments/assets/d84301e9-9f1c-4578-a032-6bb2c03baeb4)


## Implementing the Snowflake Schema using PostGreSQL 
- First I created a new database named BrazilEcommerceStar
- Then, I created the tables from the SnowflakeSchemaTable.sql script
- Afterwards, I implemented a python script (ETLforSnowflakeSchema.py) to load data from previous database (brazilEcommerce), transform some data, then load into the new database tables (BrazilEcommerceStar)

### Running the python script
To run the script I first created a virtual environment using my terminal and the following commands:
  
- cd /path/to/your/project
- virtualenv venv
- source venv/bin/activate
- pip install pandas sqlalchemy psycopg2
  (these are required to import the python script)


Then I ran the script in the virtual environment.
   

