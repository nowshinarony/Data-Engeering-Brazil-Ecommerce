#Create a vitual environment before running the code
import pandas as pd
from sqlalchemy import create_engine
from datetime import datetime


# Database connection strings
original_conn = "postgresql://postgres:123456@localhost:5432/brazilEcommerce"
star_schema_conn = "postgresql://postgres:123456@localhost:5432/BrazilEcommerceStar"



# Create SQLAlchemy engine for the original and new databases
original_engine = create_engine(original_conn)
star_schema_engine = create_engine(star_schema_conn)


# Load data from original database
customers = pd.read_sql("SELECT * FROM customers", original_engine)
sellers = pd.read_sql("SELECT * FROM sellers", original_conn)
orders = pd.read_sql("SELECT order_id, order_purchase_timestamp, order_estimated_delivery_date, order_delivered_customer_date, order_approved_at FROM orders", original_conn)
order_reviews = pd.read_sql("SELECT * FROM order_reviews", original_conn)
order_payments = pd.read_sql("SELECT * FROM order_payments", original_conn)

# Insert data into the new database using the to_sql method
customers.to_sql('dim_customers', star_schema_engine, if_exists='append', index=False)
sellers.to_sql('dim_sellers', star_schema_engine, if_exists='append', index=False)
orders.to_sql('dim_orders', star_schema_engine, if_exists='append', index=False)
order_reviews.to_sql('dim_reviews', star_schema_engine, if_exists='append', index=False)
order_payments.to_sql('dim_payments', star_schema_engine, if_exists='append', index=False)


product_query = '''
SELECT Products.product_id,
        Products.product_category_name,
        Product_category_name_translation.product_category_name_english,
        Products.product_name_length,
        Products.product_description_length,
        Products.product_photos_qty,
        Products.product_weight_g,
        Products.product_length_cm, 
        Products.product_height_cm,
        Products.product_width_cm
    From Product_category_name_translation FULL JOIN
    Products ON Products.product_category_name = Product_category_name_translation.product_category_name
	'''

products = pd.read_sql(product_query, original_conn)
products.to_sql('dim_products', star_schema_engine, if_exists='append', index=False)



# Transform the data: Extract date information
orders['order_purchase_timestamp'] = pd.to_datetime(orders['order_purchase_timestamp'])
order_dates = orders['order_purchase_timestamp'].dt.date.drop_duplicates()

# Create a DataFrame for dim_order_dates
order_dates_df = pd.DataFrame({
    'order_date_id': order_dates,
    'year': order_dates.apply(lambda x: x.year),
    'quarter': order_dates.apply(lambda x: (x.month - 1) // 3 + 1),
    'month': order_dates.apply(lambda x: x.month),
    'day': order_dates.apply(lambda x: x.day),
    'week': order_dates.apply(lambda x: x.isocalendar()[1]),
    'day_of_week': order_dates.apply(lambda x: x.weekday()),
    'is_weekend': order_dates.apply(lambda x: x.weekday() >= 5)
})

# Load transformed data into dim_order_dates table
order_dates_df.to_sql('dim_order_dates', star_schema_engine, if_exists='append', index=False)


# SQL query to get data for the fact_order_items table
fact_order_items_query = """
SELECT 
    orders.order_id,
    orders.customer_id,
    order_items.product_id,
    order_items.seller_id,
    orders.order_status,
    order_items.price,
    order_items.freight_value,
    order_items.shipping_limit_date,
    orders.order_purchase_timestamp::date AS order_date_id,
    COUNT(order_items.order_id) OVER (PARTITION BY orders.order_id) AS total_items
FROM 
    orders 
JOIN 
    order_items 
    ON orders.order_id = order_items.order_id
JOIN 
    customers 
    ON orders.customer_id = customers.customer_id;
"""

# Load data into a pandas DataFrame
fact_order_items_df = pd.read_sql(fact_order_items_query, original_engine)

# Load the transformed data into the fact_order_items table
fact_order_items_df.to_sql('fact_order_items', star_schema_engine, if_exists='append', index=False)





