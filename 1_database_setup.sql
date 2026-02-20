
-- 1. Clean Slate (Reset if exists)
DROP DATABASE IF EXISTS atliq_hardware_db;
CREATE DATABASE atliq_hardware_db;
USE atliq_hardware_db;

-- 2. Create Dimension Tables
CREATE TABLE dim_customers (
    customer_code VARCHAR(10) PRIMARY KEY,
    customer VARCHAR(50),
    market VARCHAR(20),
    region VARCHAR(20)
);

CREATE TABLE dim_products (
    product_code VARCHAR(10) PRIMARY KEY,
    division VARCHAR(20),
    segment VARCHAR(20),
    category VARCHAR(20),
    product VARCHAR(50)
);

-- 3. Create Fact Tables
CREATE TABLE fact_gross_price (
    product_code VARCHAR(10),
    fiscal_year INT,
    gross_price DECIMAL(10,2),
    PRIMARY KEY (product_code, fiscal_year)
);

CREATE TABLE fact_sales_monthly (
    date DATE,
    product_code VARCHAR(10),
    customer_code VARCHAR(10),
    sold_quantity INT
);

-- 4. Load Mock Data
-- Customers
INSERT INTO dim_customers VALUES 
('C001', 'AtliQ Exclusive', 'India', 'APAC'),
('C002', 'Amazon', 'USA', 'NA'),
('C003', 'Croma', 'India', 'APAC'),
('C004', 'Best Buy', 'USA', 'NA'),
('C005', 'Flipkart', 'India', 'APAC'),
('C006', 'Coolblue', 'Netherlands', 'EU'),
('C007', 'Acclaimed Stores', 'India', 'APAC');

-- Products
INSERT INTO dim_products VALUES
('P001', 'P & A', 'Peripherals', 'Mouse', 'AtliQ Mouse Gen1'),
('P002', 'P & A', 'Accessories', 'Keyboard', 'AtliQ Keyboard Basic'),
('P003', 'N & S', 'Notebook', 'Laptop', 'AtliQ Book 15'),
('P004', 'N & S', 'Notebook', 'Laptop', 'AtliQ Book Pro'),
('P005', 'P & A', 'Peripherals', 'Mouse', 'AtliQ Mouse Gen2');

-- Prices (Cost per unit)
INSERT INTO fact_gross_price VALUES
('P001', 2020, 15.50), ('P001', 2021, 16.20),
('P002', 2020, 25.00), ('P002', 2021, 26.50),
('P003', 2020, 800.00), ('P003', 2021, 850.00),
('P004', 2020, 1200.00), ('P004', 2021, 1250.00),
('P005', 2020, 18.00), ('P005', 2021, 20.00);

-- Sales (Transactions)
INSERT INTO fact_sales_monthly VALUES
('2020-09-01', 'P001', 'C001', 100), ('2020-09-01', 'P003', 'C002', 50),
('2020-10-01', 'P002', 'C003', 200), ('2020-11-01', 'P005', 'C004', 150),
('2021-03-01', 'P001', 'C001', 120), ('2021-03-01', 'P003', 'C002', 60),
('2021-04-01', 'P004', 'C005', 30), ('2021-05-01', 'P005', 'C002', 180),
('2021-05-01', 'P002', 'C006', 400), ('2021-06-01', 'P001', 'C007', 50);


-- 1. Add the new products to the master list
INSERT INTO dim_products VALUES
('P006', 'N & S', 'Notebook', 'Laptop', 'AtliQ Book Air'),
('P007', 'P & A', 'Accessories', 'Mouse', 'AtliQ Gaming Mouse');

-- 2. Add their prices ONLY for 2021 (So they don't exist in 2020)
INSERT INTO fact_gross_price VALUES
('P006', 2021, 950.00),
('P007', 2021, 35.00);