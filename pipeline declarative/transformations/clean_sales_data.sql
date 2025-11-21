CREATE MATERIALIZED VIEW clean_sales_data
(
    CONSTRAINT order_id_valid EXPECT (order_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT shipped_date_after_order_date EXPECT (shipped_date >= order_date) ON VIOLATION DROP ROW
)
COMMENT "Cleaned sales data"
AS
SELECT 
    FO.order_id,
    FO.store_id,
    FO.customer_id,
    FO.order_date,
    FO.shipped_date,
    FO.status AS order_status,
    DS.store_name,
    DS.email AS store_email,
    DS.phone AS store_phone,
    DS.street AS store_street,
    DS.city AS store_city,
    DS.state AS store_state,
    DS.zip_code AS store_zip_code,
    DC.customer_name,
    DC.email AS customer_email,
    DC.phone AS customer_phone,
    DC.city AS customer_city,
    DC.state AS customer_state,
    DC.zip_code AS customer_zip_code,
    DP.product_name,
    DP.description AS product_description,
    DP.model_year AS product_model_year,
    DP.stock AS product_stock,
    CAT.category_name AS product_category,
    DP.price AS product_price,
    FOD.quantity,
    FOD.quantity * DP.price AS revenue
FROM bridgestore.silver.fact_orders AS FO
INNER JOIN bridgestore.silver.dim_stores AS DS
    ON FO.store_id = DS.store_id
INNER JOIN bridgestore.silver.dim_customers AS DC
    ON FO.customer_id = DC.customer_id
INNER JOIN bridgestore.silver.fact_order_details AS FOD
    ON FO.order_id = FOD.order_id
INNER JOIN bridgestore.silver.dim_products AS DP
    ON FOD.product_id = DP.product_id
INNER JOIN bridgestore.silver.dim_categories AS CAT
    ON DP.category_id = CAT.category_id;
