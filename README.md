# bridgestore-lakeflow-declarative
Pipeline Lakehouse no Databricks para o e-commerce Bridgestore, com ingestão via Airbyte e organização Bronze/Silver/Gold.

BridgeStore Lakehouse Project
📌 Visão Geral

Este projeto tem como objetivo criar um pipeline de dados para análise de vendas da BridgeStore, utilizando arquitetura Lakehouse no Databricks.
O fluxo inclui ingestão de dados, transformação em camadas Silver, e criação de métricas agregadas em camada Gold para análises de negócios.


<img width="990" height="281" alt="imagem_etlpng" src="https://github.com/user-attachments/assets/066697b9-f2ed-4ca5-965b-0d3296b4abbc" />

----
Visão Geral

Este projeto implementa um pipeline de dados completo para análise de vendas da BridgeStore, usando arquitetura Lakehouse. O objetivo é transformar dados transacionais brutos em métricas de negócios confiáveis para suporte a decisões.

🏗️ Arquitetura Funcional do Pipeline

O fluxo de dados segue 3 camadas principais e utiliza ferramentas específicas para cada etapa:

1. Ingestão (Bronze)
    
    Fonte de dados: MySQL transacional (dados de pedidos, clientes, produtos, categorias e lojas)
    
    Ferramenta: Airbyte
    
    Conecta MySQL ao Databricks.
    
    Inferência automática de esquema.
    
    Sincronização incremental ou full refresh.
    
    Objetivo: replicar dados brutos no Data Lake sem alterações.

2. Transformação e Limpeza (Silver)

    Ferramenta: Databricks Lakehouse (Delta Lake + Unity Catalog)
    
    Operações:
    
    Validação de integridade (order_id IS NOT NULL, shipped_date >= order_date)
    
    Enriquecimento de dados com joins entre tabelas transacionais.
    
    Criação de tabela clean_sales_data (silver) com informações combinadas de:
    
    Pedidos
    
    Produtos
    
    Clientes
    
    Lojas
    
    Categorias
    
    Benefício: camada confiável, pronta para análises e agregações Gold.

3. Agregação e Métricas (Gold)

    Ferramenta: Databricks Materialized Views
    
    Objetivo: gerar métricas de negócios diretamente no Lakehouse.
    
    Views criadas:
    
    daily_sales: vendas diárias (quantidade, receita, pedidos)
    
    store_performance: desempenho por loja
    
    customer_lifetime_value: valor total gasto por cliente, ticket médio, primeira e última compra
    
    product_category_performance: vendas por categoria de produto
    
    Filtro importante: pedidos cancelados ou pendentes são excluídos da receita.

⚡ Ferramentas e Tecnologias
Etapa	Ferramenta / Tecnologia	Função
Ingestão	Airbyte	Conectar MySQL ao Data Lake, inferir esquema
Armazenamento	Azure Data Lake (ADLS)	Armazenar arquivos Delta brutos e tratados
Transformação	Databricks + Delta Lake	Limpeza, validação e joins
Catalogação	Unity Catalog	Organização de databases e tabelas
Agregação	Materialized Views (Databricks)	Métricas Gold prontas para análise
🔗 Fluxo Resumido do Pipeline

MySQL → Airbyte → Bronze
Dados transacionais brutos armazenados em Delta Lake.

Bronze → Databricks → Silver
Limpeza, validação e enriquecimento → clean_sales_data.

Silver → Gold
Materialized Views com métricas de vendas e performance:

daily_sales

store_performance

customer_lifetime_value

product_category_performance

Consumo de dados
Dashboards em Databricks SQL ou Power BI, relatórios gerenciais e análises de clientes, lojas e produtos.
