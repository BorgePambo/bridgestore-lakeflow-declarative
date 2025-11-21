-------------------------------------------
-- SILVER - DIM CUSTOMERS
-------------------------------------------
CREATE OR REFRESH STREAMING TABLE bridgestore.silver.dim_customers
(
    CONSTRAINT customer_id_valid EXPECT(customer_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT customer_name_valid EXPECT(customer_name IS NOT NULL) ON VIOLATION DROP ROW
)
COMMENT "Silver Tabela de Clientes"
AS
SELECT
    CAST(customer_id AS INT) AS customer_id,
    CONCAT(firstname, ' ', lastname) AS customer_name,
    CAST(email AS STRING) AS email,
    CAST(phone AS STRING) AS phone,
    CAST(city AS STRING) AS city,
    CAST(state AS STRING) AS state,
    CAST(zip_code AS STRING) AS zip_code,
    _airbyte_extracted_at AS extracted_at
FROM STREAM(bridgestore.bronze.customers);

-------------------------------------------
-- SILVER - DIM CATEGORIES
-------------------------------------------
CREATE OR REFRESH STREAMING TABLE bridgestore.silver.dim_categories
(
    CONSTRAINT category_id_valid EXPECT(category_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT category_name_valid EXPECT(category_name IS NOT NULL) ON VIOLATION DROP ROW
)
COMMENT "Silver Tabela de Categorias"
AS
SELECT 
    CAST(category_id AS INT) AS category_id,
    CAST(name AS STRING) AS category_name,
    _airbyte_extracted_at AS extracted_at
FROM STREAM(bridgestore.bronze.categories);

-------------------------------------------
-- SILVER - DIM PRODUCTS
-------------------------------------------
CREATE OR REFRESH STREAMING TABLE bridgestore.silver.dim_products
(
    CONSTRAINT product_id_valid EXPECT(product_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT product_name_valid EXPECT(product_name IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT price_valid EXPECT(price IS NOT NULL) ON VIOLATION DROP ROW
)
COMMENT "Silver Tabela de Produtos"
AS
SELECT 
    CAST(product_id AS INT) AS product_id,
    CAST(name AS STRING) AS product_name,
    CAST(price AS DECIMAL(10,2)) AS price,
    CAST(stock AS INT) AS stock,
    CAST(model_year AS INT) AS model_year,
    CAST(category_id AS INT) AS category_id,
    CAST(description AS STRING) AS description,
    _airbyte_extracted_at AS extracted_at
FROM STREAM(bridgestore.bronze.products);

-------------------------------------------
-- SILVER - DIM STORES
-------------------------------------------
CREATE OR REFRESH STREAMING TABLE bridgestore.silver.dim_stores
(
    CONSTRAINT store_id_valid EXPECT(store_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT store_name_valid EXPECT(store_name IS NOT NULL) ON VIOLATION DROP ROW
)
COMMENT "Silver Tabela de Lojas"
AS
SELECT
    CAST(store_id AS INT) AS store_id,
    CAST(store_name AS STRING) AS store_name,
    CAST(email AS STRING) AS email,
    CAST(phone AS STRING) AS phone,
    CAST(street AS STRING) AS street,
    CAST(city AS STRING) AS city,
    CAST(state AS STRING) AS state,
    CAST(zip_code AS STRING) AS zip_code,
    _airbyte_extracted_at AS extracted_at
FROM STREAM(bridgestore.bronze.stores);

-------------------------------------------
-- SILVER - FACT ORDERS
-------------------------------------------
CREATE OR REFRESH STREAMING TABLE bridgestore.silver.fact_orders
(
    CONSTRAINT order_id_valid EXPECT(order_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT order_date_valid EXPECT(order_date IS NOT NULL) ON VIOLATION DROP ROW
)
COMMENT "Silver Fato Orders"
AS
SELECT
    CAST(order_id AS INT) AS order_id,
    CAST(store_id AS INT) AS store_id,
    CAST(customer_id AS INT) AS customer_id,
    CAST(order_date AS DATE) AS order_date,
    CAST(shipped_date AS DATE) AS shipped_date,
    CAST(status AS STRING) AS status,
    _airbyte_extracted_at AS extracted_at
FROM STREAM(bridgestore.bronze.orders);

-------------------------------------------
-- SILVER - FACT ORDER DETAILS
-------------------------------------------
CREATE OR REFRESH STREAMING TABLE bridgestore.silver.fact_order_details
(
    CONSTRAINT detail_id_valid EXPECT(detail_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT quantity_valid EXPECT(quantity IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT unit_price_valid EXPECT(unit_price IS NOT NULL) 
)
COMMENT "Silver Fato Order Details"
AS
SELECT
    CAST(detail_id AS INT) AS detail_id,
    CAST(order_id AS INT) AS order_id,
    CAST(product_id AS INT) AS product_id,
    CAST(quantity AS INT) AS quantity,
    CAST(unit_price AS DECIMAL(10,2)) AS unit_price,
    CAST(discount AS DECIMAL(5,2)) AS discount,
    _airbyte_extracted_at AS extracted_at
FROM STREAM(bridgestore.bronze.order_details);

-------------------------------------------

