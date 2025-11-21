# bridgestore-lakeflow-declarative
Pipeline Lakehouse no Databricks para o e-commerce Bridgestore, com ingestão via Airbyte e organização Bronze/Silver/Gold.

### BridgeStore Lakehouse Project
📌   Visão Geral

Este projeto tem como objetivo criar um pipeline de dados para análise de vendas da BridgeStore, utilizando arquitetura Lakehouse no Databricks.
O fluxo inclui ingestão de dados, transformação em camadas Silver, e criação de métricas agregadas em camada Gold para análises de negócios.


<img width="990" height="281" alt="imagem_etlpng" src="https://github.com/user-attachments/assets/066697b9-f2ed-4ca5-965b-0d3296b4abbc" />

----
### Arquitetura Funcional do Pipeline
              
              MySQL (Transacional)
                     │
                     ▼
              Airbyte (Ingestão)
                     │
                     └─ insere dados no schema internal_airbyte
                           │
                           ▼
                     Bronze Layer (Delta Lake)
                           │
                           ▼
                     Databricks / Delta Lake (Silver Layer)
                           │
                           ├─ Limpeza: remover pedidos inválidos
                           ├─ Enriquecimento: joins entre tabelas
                           └─ clean_sales_data
                           │
                           ▼
                     Gold Layer (Materialized Views)
                           ├─ daily_sales
                           ├─ store_performance
                           ├─ customer_lifetime_value
                           └─ product_category_performance
                           │
                           ▼
                    Dashboards / BI / Relatórios




### Fluxo Funcional

   1-Bronze Layer: dados brutos do MySQL replicados via Airbyte.
    
   2-Silver Layer:
        
        Validação (order_id não nulo, shipped_date >= order_date)
        
        Limpeza de duplicatas e inconsistências
        
        Criação da tabela clean_sales_data com todas as dimensões e fatos
    
   3-Gold Layer: métricas agregadas em materialized views
        
        Ex.: daily_sales, store_performance, customer_lifetime_value, product_category_performance
        
        Exclui pedidos cancelados ou pendentes para receita
        
        Consumo: Dashboards em Databricks SQL ou Power BI


### Conclusão

  Este projeto implementa um pipeline de dados moderno e robusto, unindo Airbyte, Delta Lake e Databricks para construir um Lakehouse completo com camadas Bronze, Silver e Gold.
  A arquitetura garante ingestão confiável, transformações escaláveis e dados altamente otimizados para análises e BI.
    
  Do banco transacional MySQL até a camada Gold com visões materializadas, o fluxo foi projetado seguindo boas práticas de engenharia de dados, garantindo qualidade, governança e performance.
  O resultado final é uma estrutura clara, modular e pronta para servir relatórios, dashboards e aplicações analíticas.


