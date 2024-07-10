# Data-Engeering-Brazil-Ecommerce
This repository presents my ongoing project on creating an end-to-end data pipeline using the [Brazil Ecommerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). This is project showcases my hands-on experience in different data-specific skills. 

So far, the project steps done:

- Creating a Entity Relationship Diagram through analyzing the original CSV files. Tools: Draw.IO, MS Excel
- Developing a database and loading the data from CSV files. Tools: PostgreSQL


## ERD (data model) from the Original Dataset
![ERD1](https://github.com/nna01/Data-Engeering-Brazil-Ecommerce/assets/28835420/3bda5137-3d7d-4706-8f70-2bddfbac94db)


## Implementing the data model (ERD) using PostGreSQL 
- Create a new database named: brazilEcommerce
- Open query tool -> run the sql commands in the file Tables.sql
- Open PSQL tool -> run the following commands. Change the path to the path of the csv files.


\copy Customers FROM '/path/olist_customers_dataset.csv' DELIMITER ',' CSV HEADER;
\copy Orders FROM '/path/olist_orders_dataset.csv' DELIMITER ',' CSV HEADER;
\copy Order_Items FROM '/path/olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER;
\copy Order_Payments FROM '/path/olist_order_payments_dataset.csv' DELIMITER ',' CSV HEADER;
\copy Order_Reviews FROM '/path/olist_order_reviews_dataset.csv' DELIMITER ',' CSV HEADER;
\copy Products FROM '/path/olist_products_dataset.csv' DELIMITER ',' CSV HEADER;
\copy Sellers FROM '/path/olist_sellers_dataset.csv' DELIMITER ',' CSV HEADER;
\copy Product_Category_Name_Translation FROM '/path/product_category_name_translation.csv' DELIMITER ',' CSV HEADER;



