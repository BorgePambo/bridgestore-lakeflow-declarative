-- 1️⃣ Daily Sales
CREATE OR REFRESH MATERIALIZED VIEW  bridgestore.gold.daily_sales
COMMENT "Daily sales data (excluindo pedidos cancelados e pendentes)"
AS
SELECT 
    order_date AS sales_date,
    SUM(quantity) AS total_quantity,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM bridgestore.silver.clean_sales_data
WHERE order_status NOT IN ('cancelado', 'pendente')
GROUP BY order_date
ORDER BY sales_date ASC;

-- 2️⃣ Store Performance
CREATE OR REFRESH MATERIALIZED VIEW  bridgestore.gold.store_performance
COMMENT "Store performance data (excluindo pedidos cancelados e pendentes)"
AS
SELECT 
    store_id,
    store_name,
    SUM(quantity) AS total_quantity_sold,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM bridgestore.silver.clean_sales_data
WHERE order_status NOT IN ('cancelado', 'pendente')
GROUP BY store_id, store_name
ORDER BY total_revenue DESC;

-- 3️⃣ Customer Lifetime Value
CREATE OR REFRESH MATERIALIZED VIEW  bridgestore.gold.customer_lifetime_value
COMMENT "Customer lifetime value (excluindo pedidos cancelados e pendentes)"
AS
SELECT
    customer_id,
    customer_name,
    SUM(revenue) AS lifetime_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    AVG(revenue) AS avg_order_value,
    MIN(order_date) AS first_purchase,
    MAX(order_date) AS last_purchase
FROM bridgestore.silver.clean_sales_data
WHERE order_status NOT IN ('cancelado', 'pendente')
GROUP BY customer_id, customer_name
ORDER BY lifetime_revenue DESC;

-- 4️⃣ Product Category Performance
CREATE OR REFRESH MATERIALIZED VIEW  bridgestore.gold.product_category_performance
COMMENT "Product category performance (excluindo pedidos cancelados e pendentes)"
AS
SELECT
    product_category,
    SUM(quantity) AS total_quantity_sold,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT product_name) AS total_products_sold
FROM bridgestore.silver.clean_sales_data
WHERE order_status NOT IN ('cancelado', 'pendente')
GROUP BY product_category
ORDER BY total_revenue DESC;
