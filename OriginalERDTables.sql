-- Customers Table
CREATE TABLE Customers (
    customer_id VARCHAR PRIMARY KEY,
    customer_unique_id VARCHAR NOT NULL,
    customer_zip_code_prefix VARCHAR NOT NULL,
    customer_city VARCHAR NOT NULL,
    customer_state VARCHAR NOT NULL
);

-- Products Table
CREATE TABLE Products (
    product_id VARCHAR PRIMARY KEY,
    product_category_name VARCHAR,
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g DECIMAL,
    product_length_cm DECIMAL,
    product_height_cm DECIMAL,
    product_width_cm DECIMAL
);

-- Sellers Table
CREATE TABLE Sellers (
    seller_id VARCHAR PRIMARY KEY,
    seller_zip_code_prefix VARCHAR NOT NULL,
    seller_city VARCHAR NOT NULL,
    seller_state VARCHAR NOT NULL
);

-- Orders Table
CREATE TABLE Orders (
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR NOT NULL,
    order_status VARCHAR NOT NULL,
    order_purchase_timestamp TIMESTAMP NOT NULL,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order_Items Table
CREATE TABLE Order_Items (
    order_id VARCHAR NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR NOT NULL,
    seller_id VARCHAR NOT NULL,
	shipping_limit_date TIMESTAMP NOT NULL,
    price DECIMAL NOT NULL,
    freight_value DECIMAL NOT NULL,
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id)
);

-- Order_Payments Table
CREATE TABLE Order_Payments (
    order_id VARCHAR NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR NOT NULL,
    payment_installments INT NOT NULL,
    payment_value DECIMAL NOT NULL,
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Order_Reviews Table
CREATE TABLE Order_Reviews (
    review_id VARCHAR,
    order_id VARCHAR NOT NULL,
    review_score INT NOT NULL,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP NOT NULL,
    review_answer_timestamp TIMESTAMP NOT NULL,
	PRIMARY KEY (review_id, order_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);


-- Product_Category_Name_Translation Table
CREATE TABLE Product_Category_Name_Translation (
    product_category_name VARCHAR PRIMARY KEY,
    product_category_name_english VARCHAR NOT NULL
);

