# 🛒 Minicurso de SQL - Modelagem e Consultas em Banco de Dados E-commerce

Este repositório foi criado para documentar e armazenar os scripts desenvolvidos durante os meus estudos práticos de SQL. O projeto simula o banco de dados de um ecossistema de e-commerce, cobrindo desde a criação e modificação das tabelas até análises de dados complexas com junções, agregações e subqueries.

## 🚀 Tecnologias e Conceitos Utilizados
* **Banco de Dados:** MySQL / MariaDB
* **DDL (Data Definition Language):** Criação de tabelas, chaves primárias (`PRIMARY KEY`), chaves estrangeiras (`FOREIGN KEY`), auto-incremento, índices de performance (`INDEX`), além de alterações de estrutura (`ALTER`, `MODIFY`, `DROP`).
* **DML (Data Manipulation Language):** Inserção em massa (`INSERT INTO`), atualização condicional de estoque (`UPDATE`) e remoção segura de registros (`DELETE`).
* **DQL (Data Query Language):** Consultas com filtros avançados (`LIKE`, `ORDER BY`, `LIMIT`), junções de tabelas (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`), operações de conjunto (`UNION`) e subqueries.

---

## 📊 Estrutura do Banco de Dados (Modelagem)

O banco de dados é composto por 5 tabelas interligadas que representam o fluxo de vendas e produtos:

1. **`marcas`**: Armazena os fabricantes (Apple, Samsung, etc.) e seus canais de atendimento.
2. **`produtos`**: Itens à venda, controlando preço, quantidade em estoque e associados a uma marca através de uma chave estrangeira (`id_marca`).
3. **`customers`**: Cadastro de clientes com dados de contato e localização (cidade).
4. **`orders`**: Registro dos cabeçalhos dos pedidos, capturando a data da compra (com valor padrão atual via `NOW()`) e o valor total.
5. **`order_items`**: Tabela associativa (N para N) que conecta os produtos aos seus respectivos pedidos, controlando a quantidade e o preço unitário no momento da venda.

---

## 🔍 Destaques dos Scripts Praticados

Abaixo estão alguns dos principais conceitos de manipulação e análise de dados aplicados no projeto:

### 1. Manipulação Estrutural e Carga de Dados (`first-base-query.sql`)
* Criação de tabelas com relacionamentos dinâmicos via `ALTER TABLE`.
* Criação de índice (`idx_produtos_name`) para otimização de buscas por texto.
* Uso de comandos como `INSERT INTO ... SELECT` para clonar dados específicos de uma tabela para outra de forma automatizada (Tabela espelho de produtos Apple).
* Atualizações dinâmicas de estoque (ex: `SET stock = stock + 20`).

### 2. Consultas Analíticas Avançadas (`second-query.sql`)

* **Análise de Faturamento por Localização:** Agregação de valores utilizando `SUM()`, filtrando por cidades específicas e aplicando uma regra de negócio na métrica agregada através da cláusula `HAVING`:
  ```sql
  SELECT
      c.city,
      SUM(p.total_price) AS total_vendas
  FROM
      customers as c
      INNER JOIN orders as p ON c.id = p.id_customer
  WHERE
      c.city IN ('New York', 'Los Angeles')
  GROUP BY c.city
  HAVING total_vendas > 500;