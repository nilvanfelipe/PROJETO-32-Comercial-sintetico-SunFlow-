# Regras de negocio e premissas

## Relacionamentos

```text
dClientes[IdCliente]       1:N fPedidos[IdCliente]
fPedidos[IdPedido]         1:N fItensPedidos[IdPedido]
dProdutos[IdProduto]       1:N fItensPedidos[IdProduto]
dFornecedores[IdFornecedor] 1:N dProdutos[IdFornecedor]
```

O modelo foi mantido propositalmente proximo de uma cadeia comercial didatica. `Marca` e um atributo de produto e nao substitui a dimensao de fornecedores.

## Regras calculadas

```text
ValorBrutoItem    = Quantidade * PrecoUnitario
ValorLiquidoItem  = ValorBrutoItem - ValorDescontoItem
CustoTotalItem    = Quantidade * CustoUnitario
MargemBruta       = ValorLiquidoItem - CustoTotalItem
PercentualMargem  = MargemBruta / ValorLiquidoItem

QuantidadeItens = SOMA(fItensPedidos[Quantidade]) por IdPedido
ValorBruto      = SOMA(fItensPedidos[ValorBrutoItem]) por IdPedido
ValorDesconto   = SOMA(fItensPedidos[ValorDescontoItem]) por IdPedido
ValorLiquido    = ValorBruto - ValorDesconto + ValorFrete
```

Os valores foram calculados em centavos durante a geracao, de modo que a reconciliacao monetaria entre pedido e itens nao sofre erro de arredondamento.

## Codigos de apoio

| Campo | Codigo | Significado |
|---|---:|---|
| `IdCanalVenda` | 1 | E-commerce |
|  | 2 | Marketplace |
|  | 3 | Loja fisica |
|  | 4 | Televendas |
| `IdFormaPagamento` | 1 | Pix |
|  | 2 | Cartao de credito |
|  | 3 | Boleto |
|  | 4 | Carteira digital |

## Status e leitura analitica

- Pedidos: `Entregue`, `Em Transporte`, `Aprovado`, `Pendente` e `Cancelado`.
- Itens: `Faturado`, `Devolvido`, `Em Transporte`, `Aguardando Faturamento`, `Pendente` e `Cancelado`.
- Os valores financeiros representam o valor comercial originalmente registrado. Itens cancelados ou devolvidos **nao** sao estornados neste conjunto, pois nao existe uma tabela de devolucoes/estornos. Para analises de receita realizada, aplique o filtro de status adequado ou crie uma regra de estorno explicita no ETL.

## Limites intencionais

Esta e uma base sintetica, nao uma simulacao contabil completa. Ela nao inclui impostos, parcelas de pagamento, estoque, devolucoes financeiras, CEP, dados pessoais reais, dimensao calendario nem dimensoes de canal/pagamento. Esses itens podem ser adicionados como uma proxima camada de modelagem.
