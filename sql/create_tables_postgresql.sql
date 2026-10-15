-- DDL de referencia (PostgreSQL). As aspas preservam os nomes dos CSVs.
CREATE TABLE "dFornecedores" (
  "IdFornecedor" INT PRIMARY KEY,
  "NomeFornecedor" VARCHAR(50) NOT NULL,
  "CidadeFornecedor" VARCHAR(50) NOT NULL,
  "UFFornecedor" CHAR(2) NOT NULL,
  "PrazoMedioEntregaDias" INT NOT NULL,
  "StatusFornecedor" VARCHAR(15) NOT NULL
);

CREATE TABLE "dClientes" (
  "IdCliente" INT PRIMARY KEY,
  "NomeCliente" VARCHAR(40) NOT NULL,
  "Cidade" VARCHAR(50) NOT NULL,
  "UF" CHAR(2) NOT NULL,
  "SegmentoCliente" VARCHAR(20) NOT NULL
);

CREATE TABLE "dProdutos" (
  "IdProduto" INT PRIMARY KEY,
  "NomeProduto" VARCHAR(90) NOT NULL,
  "IdFornecedor" INT NOT NULL REFERENCES "dFornecedores"("IdFornecedor"),
  "Marca" VARCHAR(30) NOT NULL,
  "Categoria" VARCHAR(40) NOT NULL,
  "Subcategoria" VARCHAR(40) NOT NULL,
  "UnidadeMedida" VARCHAR(5) NOT NULL,
  "StatusProduto" VARCHAR(15) NOT NULL
);

CREATE TABLE "fPedidos" (
  "IdPedido" BIGINT PRIMARY KEY,
  "IdCliente" INT NOT NULL REFERENCES "dClientes"("IdCliente"),
  "DataPedido" DATE NOT NULL,
  "DataAprovacao" DATE NULL,
  "DataPrevistaEntrega" DATE NOT NULL,
  "DataEntrega" DATE NULL,
  "IdCanalVenda" SMALLINT NOT NULL,
  "IdFormaPagamento" SMALLINT NOT NULL,
  "StatusPedido" VARCHAR(25) NOT NULL,
  "QuantidadeItens" INT NOT NULL,
  "ValorBruto" DECIMAL(12,2) NOT NULL,
  "ValorDesconto" DECIMAL(12,2) NOT NULL,
  "ValorFrete" DECIMAL(12,2) NOT NULL,
  "ValorLiquido" DECIMAL(12,2) NOT NULL
);

CREATE TABLE "fItensPedidos" (
  "IdItemPedido" BIGINT PRIMARY KEY,
  "IdPedido" BIGINT NOT NULL REFERENCES "fPedidos"("IdPedido"),
  "IdProduto" INT NOT NULL REFERENCES "dProdutos"("IdProduto"),
  "NumeroItem" SMALLINT NOT NULL,
  "Quantidade" INT NOT NULL,
  "PrecoUnitario" DECIMAL(12,2) NOT NULL,
  "CustoUnitario" DECIMAL(12,2) NOT NULL,
  "ValorBrutoItem" DECIMAL(12,2) NOT NULL,
  "ValorDescontoItem" DECIMAL(12,2) NOT NULL,
  "ValorLiquidoItem" DECIMAL(12,2) NOT NULL,
  "CustoTotalItem" DECIMAL(12,2) NOT NULL,
  "MargemBruta" DECIMAL(12,2) NOT NULL,
  "PercentualMargem" DECIMAL(8,4) NOT NULL,
  "StatusItem" VARCHAR(30) NOT NULL,
  CONSTRAINT "uq_fItensPedidos_pedido_item" UNIQUE ("IdPedido", "NumeroItem")
);

CREATE INDEX "ix_fPedidos_cliente_data" ON "fPedidos" ("IdCliente", "DataPedido");
CREATE INDEX "ix_fItensPedidos_pedido" ON "fItensPedidos" ("IdPedido");
CREATE INDEX "ix_fItensPedidos_produto" ON "fItensPedidos" ("IdProduto");
CREATE INDEX "ix_dProdutos_fornecedor" ON "dProdutos" ("IdFornecedor");
