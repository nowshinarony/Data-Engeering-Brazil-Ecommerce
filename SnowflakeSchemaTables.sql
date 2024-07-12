-- Dimension Tables
CREATE TABLE Dim_Orders (
    order_id VARCHAR PRIMARY KEY,
    order_purchase_timestamp TIMESTAMP,
    order_estimated_delivery_date DATE,
    order_delivered_customer_date DATE,
    order_approved_at TIMESTAMP
);

CREATE TABLE Dim_Customers (
    customer_id VARCHAR PRIMARY KEY,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix VARCHAR,
    customer_city VARCHAR,
    customer_state VARCHAR
);

CREATE TABLE Dim_Products (
    product_id VARCHAR PRIMARY KEY,
    product_category_name VARCHAR,
    product_category_name_english VARCHAR,
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g DECIMAL,
    product_length_cm DECIMAL,
    product_height_cm DECIMAL,
    product_width_cm DECIMAL
);


CREATE TABLE Dim_Sellers (
    seller_id VARCHAR PRIMARY KEY,
    seller_zip_code_prefix VARCHAR,
    seller_city VARCHAR,
    seller_state VARCHAR
);


CREATE TABLE Dim_Order_Dates (
    order_date_id DATE PRIMARY KEY,
    year INT,
    quarter INT,
    month INT,
    day INT,
    week INT,
    day_of_week INT,
    is_weekend BOOLEAN
);


CREATE TABLE Dim_Payments (
    order_id VARCHAR NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR NOT NULL,
    payment_installments INT NOT NULL,
    payment_value DECIMAL NOT NULL,
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES dim_orders(order_id)
);

	

CREATE TABLE Dim_Reviews (
    review_id VARCHAR,
	order_id VARCHAR,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
	PRIMARY KEY (review_id,order_id),
	FOREIGN KEY (order_id) REFERENCES Dim_Orders(order_id)
);

Select * From DIM_Orders;


-- Fact Table
CREATE TABLE Fact_Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id VARCHAR NOT NULL,
    product_id VARCHAR NOT NULL,
    seller_id VARCHAR NOT NULL,
    customer_id VARCHAR NOT NULL,
    order_date_id DATE NOT NULL,
    payment_id VARCHAR,
    review_id VARCHAR,
    order_status VARCHAR,
    price DECIMAL NOT NULL,
    freight_value DECIMAL,
    shipping_limit_date DATE,
    FOREIGN KEY (order_id) REFERENCES Dim_Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Dim_Products(product_id),
    FOREIGN KEY (seller_id) REFERENCES Dim_Sellers(seller_id),
    FOREIGN KEY (customer_id) REFERENCES Dim_Customers(customer_id),
    FOREIGN KEY (order_date_id) REFERENCES Dim_Order_Dates(order_date_id),
    FOREIGN KEY (payment_id) REFERENCES Dim_Payments(payment_id),
    FOREIGN KEY (review_id) REFERENCES Dim_Reviews(review_id)
);

Select * from Fact_Order_Items;

SELECT rolname, rolpassword FROM pg_authid;

DROP TABLE IF EXISTS fact_order_items;
DROP TABLE IF EXISTS dim_reviews;
DROP TABLE IF EXISTS dim_payments;

DELETE FROM fact_order_items;
DELETE FROM dim_reviews;
DELETE FROM dim_payments;
DELETE FROM dim_orders;
DELETE FROM dim_products;
DELETE FROM dim_sellers;
DELETE FROM dim_customers;
DELETE FROM dim_order_dates;

Select order_date_id, Count(order_id) FROM 
	fact_order_items group by order_date_id;

Select * FROM dim_reviews;
Select * FROM dim_payments;
Select * FROM dim_orders;
Select * FROM dim_products;
Select * FROM dim_sellers;
Select * FROM dim_customers;
Select * FROM dim_order_dates;






