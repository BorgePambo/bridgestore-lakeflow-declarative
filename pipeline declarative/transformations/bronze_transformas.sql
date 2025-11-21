------------- 1 CRIANDO A TABELA CUSTOMER NA BRONZE ---------- 
CREATE OR REFRESH STREAMING TABLE bridgestore.bronze.customers AS
SELECT
  _airbyte_data:customer_id,
  _airbyte_data:firstname,
  _airbyte_data:lastname,
  _airbyte_data:email,
  _airbyte_data:phone,
  _airbyte_data:city,
  _airbyte_data:state,
  _airbyte_data:zip_code,
  _airbyte_data:created_at,
  _airbyte_extracted_at
FROM STREAM(bridgestore.airbyte_internal.default_raw__stream_customers);



---------------2 CRIANDO A TABELA CATEGORIES ------------------
CREATE OR REFRESH STREAMING TABLE bridgestore.bronze.categories
COMMENT "Tabela bronze criada a partir do raw categories"
AS
SELECT
  _airbyte_data:category_id,
  _airbyte_data:name,
  _airbyte_extracted_at
FROM STREAM(bridgestore.airbyte_internal.default_raw__stream_categories);


-------------3 CRIANDO A TABELA PRODUTO ---------------
CREATE OR REFRESH STREAMING TABLE bridgestore.bronze.products
COMMENT "Tabela bronze criada a partir do raw products"
AS
SELECT
  _airbyte_data:product_id,
  _airbyte_data:name,
  _airbyte_data:price,
  _airbyte_data:stock,
  _airbyte_data:model_year,
  _airbyte_data:category_id,
  _airbyte_data:description,
  _airbyte_extracted_at
FROM STREAM(bridgestore.airbyte_internal.default_raw__stream_products);


--------------4  CRIANDO A TABELA STORES --------------------
CREATE OR REFRESH STREAMING TABLE bridgestore.bronze.stores
COMMENT "Tabela bronze criada a partir do raw stores"
AS
SELECT
  _airbyte_data:store_id,
  _airbyte_data:store_name,
  _airbyte_data:email,
  _airbyte_data:phone,
  _airbyte_data:street,
  _airbyte_data:city,
  _airbyte_data:state,
  _airbyte_data:zip_code,
  _airbyte_extracted_at
FROM STREAM(bridgestore.airbyte_internal.default_raw__stream_store);


---------------5 CRIANDO A TABELA ORDERS ---------------------------
CREATE OR REFRESH STREAMING TABLE bridgestore.bronze.orders
COMMENT "Tabela bronze criada a partir do raw orders"
AS
SELECT
  _airbyte_data:order_id,
  _airbyte_data:store_id,
  _airbyte_data:customer_id,
  _airbyte_data:order_date,
  _airbyte_data:shipped_date,
  _airbyte_data:status,
  _airbyte_extracted_at
FROM STREAM(bridgestore.airbyte_internal.default_raw__stream_orders);


--------------6 CRIANDO A TABELA ORDERS DETAILS ------------------------

CREATE OR REFRESH STREAMING TABLE bridgestore.bronze.order_details
COMMENT "Tabela bronze criada a partir do raw order_details"
AS
SELECT
  _airbyte_data:detail_id,
  _airbyte_data:order_id,
  _airbyte_data:product_id,
  _airbyte_data:quantity,
  _airbyte_data:unit_price,
  _airbyte_data:discount,
  _airbyte_extracted_at
FROM STREAM(bridgestore.airbyte_internal.default_raw__stream_order_details);





