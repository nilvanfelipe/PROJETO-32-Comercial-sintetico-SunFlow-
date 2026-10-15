w# Dicionario de dados

## dClientes

Granularidade: um cliente sintetico por linha.

| Coluna | Tipo sugerido | Descricao |
|---|---|---|
| `IdCliente` | INT | Identificador unico do cliente. |
| `NomeCliente` | VARCHAR(40) | Rotulo sintetico e nao identificavel do cliente. |
| `Cidade` | VARCHAR(50) | Cidade de referencia do cliente. |
| `UF` | CHAR(2) | Unidade federativa da cidade. |
| `SegmentoCliente` | VARCHAR(20) | `Pessoa Fisica`, `Pessoa Juridica` ou `Atacado`. |

## dFornecedores

Granularidade: um fornecedor por linha.

| Coluna | Tipo sugerido | Descricao |
|---|---|---|
| `IdFornecedor` | INT | Identificador unico do fornecedor. |
| `NomeFornecedor` | VARCHAR(50) | Nome empresarial sintetico. |
| `CidadeFornecedor` | VARCHAR(50) | Cidade de referencia do fornecedor. |
| `UFFornecedor` | CHAR(2) | Unidade federativa do fornecedor. |
| `PrazoMedioEntregaDias` | INT | Lead time medio de reposicao em dias. |
| `StatusFornecedor` | VARCHAR(15) | `Ativo`, `Inativo` ou `Bloqueado`. |

## dProdutos

Granularidade: um produto por linha. Preco e custo comerciais pertencem ao fato de itens porque podem variar por venda.

| Coluna | Tipo sugerido | Descricao |
|---|---|---|
| `IdProduto` | INT | Identificador unico do produto. |
| `NomeProduto` | VARCHAR(90) | Descricao sintetica do produto. |
| `IdFornecedor` | INT | Chave estrangeira para `dFornecedores`. |
| `Marca` | VARCHAR(30) | Marca comercial sintetica; nao e sinonimo de fornecedor. |
| `Categoria` | VARCHAR(40) | Categoria principal do produto. |
| `Subcategoria` | VARCHAR(40) | Segmentacao dentro da categoria. |
| `UnidadeMedida` | VARCHAR(5) | Unidade comercial (`UN`). |
| `StatusProduto` | VARCHAR(15) | `Ativo` ou `Inativo`. Somente produtos ativos aparecem nos fatos. |

## fPedidos

Granularidade: um pedido comercial por linha.

| Coluna | Tipo sugerido | Descricao |
|---|---|---|
| `IdPedido` | BIGINT | Identificador unico do pedido. |
| `IdCliente` | INT | Chave estrangeira para `dClientes`. |
| `DataPedido` | DATE | Data de criacao do pedido. |
| `DataAprovacao` | DATE | Data de aprovacao; vazia em pedidos ainda pendentes ou cancelados antes da aprovacao. |
| `DataPrevistaEntrega` | DATE | Data prevista de entrega. |
| `DataEntrega` | DATE | Data efetiva; vazia quando a entrega nao foi concluida. |
| `IdCanalVenda` | SMALLINT | Codigo do canal de venda. |
| `IdFormaPagamento` | SMALLINT | Codigo da forma de pagamento. |
| `StatusPedido` | VARCHAR(25) | Situacao operacional do pedido. |
| `QuantidadeItens` | INT | Soma das unidades das linhas do pedido. |
| `ValorBruto` | DECIMAL(12,2) | Soma de `ValorBrutoItem`. |
| `ValorDesconto` | DECIMAL(12,2) | Soma de `ValorDescontoItem`. |
| `ValorFrete` | DECIMAL(12,2) | Frete cobrado no cabecalho do pedido. |
| `ValorLiquido` | DECIMAL(12,2) | `ValorBruto - ValorDesconto + ValorFrete`. |

## fItensPedidos

Granularidade: uma linha de produto dentro de um pedido.

| Coluna | Tipo sugerido | Descricao |
|---|---|---|
| `IdItemPedido` | BIGINT | Identificador unico da linha do pedido. |
| `IdPedido` | BIGINT | Chave estrangeira para `fPedidos`. |
| `IdProduto` | INT | Chave estrangeira para `dProdutos`. |
| `NumeroItem` | SMALLINT | Sequencia da linha dentro do pedido. |
| `Quantidade` | INT | Unidades do produto na linha. |
| `PrecoUnitario` | DECIMAL(12,2) | Preco de venda unitario no momento do pedido. |
| `CustoUnitario` | DECIMAL(12,2) | Custo unitario de referencia no momento do pedido. |
| `ValorBrutoItem` | DECIMAL(12,2) | `Quantidade * PrecoUnitario`. |
| `ValorDescontoItem` | DECIMAL(12,2) | Desconto comercial da linha. |
| `ValorLiquidoItem` | DECIMAL(12,2) | `ValorBrutoItem - ValorDescontoItem`. |
| `CustoTotalItem` | DECIMAL(12,2) | `Quantidade * CustoUnitario`. |
| `MargemBruta` | DECIMAL(12,2) | `ValorLiquidoItem - CustoTotalItem`. |
| `PercentualMargem` | DECIMAL(8,4) | `MargemBruta / ValorLiquidoItem`, como razao decimal. |
| `StatusItem` | VARCHAR(30) | Situacao operacional da linha. |
