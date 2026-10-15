# Conjunto de dados comercial sintetico - 250 mil pedidos

Este pacote contem dados **inteiramente sinteticos**, preparados para estudos de engenharia de dados, SQL, ETL e Power BI. Nomes, empresas, marcas e transacoes nao representam pessoas ou negocios reais.

## Conteudo

| Arquivo | Linhas de dados | Granularidade |
|---|---:|---|
| `dados/dClientes.csv` | 50.000 | um cliente por linha |
| `dados/dFornecedores.csv` | 500 | um fornecedor por linha |
| `dados/dProdutos.csv` | 10.000 | um produto por linha |
| `dados/fPedidos.csv` | 250.000 | um pedido por linha |
| `dados/fItensPedidos.csv` | 750.000 | um produto dentro de um pedido por linha |

Cada pedido possui exatamente tres linhas em `fItensPedidos`, totalizando 750.000 itens. A coluna `QuantidadeItens` de `fPedidos` e a soma das unidades compradas, e nao a contagem de linhas.

## Formato e carga

- Codificacao: UTF-8.
- Delimitador: virgula (`,`).
- Decimal: ponto (`.`), sem simbolo monetario.
- Datas: ISO `AAAA-MM-DD`.
- Campos vazios em datas representam `NULL`.
- Todos os CSVs possuem cabecalho e usam os nomes de coluna definidos no dicionario de dados.

Ordem segura de carga: `dFornecedores`, `dProdutos`, `dClientes`, `fPedidos`, `fItensPedidos`.

Os arquivos em `sql/` trazem uma definicao relacional de apoio. Consulte `documentacao/` antes de criar medidas ou indicadores: la estao as granularidades, formulas, relacionamentos e limitacoes intencionais do conjunto.
