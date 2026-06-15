CREATE TABLE "pedido"(
    "id_pedido" BIGINT NOT NULL,
    "forma_pagamento" VARCHAR(255) NOT NULL,
    "status" BOOLEAN NOT NULL,
    "observacoes" VARCHAR(255) NOT NULL,
    "data_hora" TIMESTAMP(0) WITH
        TIME zone NOT NULL,
        "fk_id_garcom" BIGINT NOT NULL,
        "fk_id_mesa" BIGINT NOT NULL
);
ALTER TABLE
    "pedido" ADD PRIMARY KEY("id_pedido");
CREATE TABLE "mesa"(
    "id_mesa" BIGINT NOT NULL,
    "capacidade" INTEGER NOT NULL,
    "status" BOOLEAN NOT NULL,
    "localizacao" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "mesa" ADD PRIMARY KEY("id_mesa");
CREATE TABLE "garçom"(
    "id_garcom" BIGINT NOT NULL,
    "telefones" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "data_contratacao" TIMESTAMP(0) WITH
        TIME zone NOT NULL,
        "cpf" CHAR(11) NOT NULL
);
ALTER TABLE
    "garçom" ADD PRIMARY KEY("id_garcom");
ALTER TABLE
    "garçom" ADD CONSTRAINT "garçom_email_unique" UNIQUE("email");
ALTER TABLE
    "garçom" ADD CONSTRAINT "garçom_cpf_unique" UNIQUE("cpf");
CREATE TABLE "conta_usuario"(
    "id_conta" BIGINT NOT NULL,
    "nivel_acesso" INTEGER NOT NULL,
    "status" BOOLEAN NOT NULL,
    "login" VARCHAR(255) NOT NULL,
    "senha" VARCHAR(255) NOT NULL,
    "fk_id_garcom" BIGINT NOT NULL
);
ALTER TABLE
    "conta_usuario" ADD PRIMARY KEY("id_conta");
ALTER TABLE
    "conta_usuario" ADD CONSTRAINT "conta_usuario_login_unique" UNIQUE("login");
CREATE TABLE "item_pedido"(
    "id_item_pedido" BIGINT NOT NULL,
    "observacao" VARCHAR(255) NOT NULL,
    "quantidade" BIGINT NOT NULL,
    "fk_id_pedido" BIGINT NOT NULL,
    "fk_id_prato" BIGINT NOT NULL
);
ALTER TABLE
    "item_pedido" ADD PRIMARY KEY("id_item_pedido");
CREATE TABLE "prato"(
    "id_prato" BIGINT NOT NULL,
    "preco" BIGINT NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "categoria" VARCHAR(255) NOT NULL,
    "tempo_preparo" TIME(0) WITHOUT TIME ZONE NOT NULL,
    "descricao" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "prato" ADD PRIMARY KEY("id_prato");
CREATE TABLE "receita_prato"(
    "id_receita_prato" BIGINT NOT NULL,
    "quantidade" BIGINT NOT NULL,
    "fk_id_prato" BIGINT NOT NULL,
    "fk_id_ingrediente" BIGINT NOT NULL
);
ALTER TABLE
    "receita_prato" ADD PRIMARY KEY("id_receita_prato");
CREATE TABLE "ingredientes"(
    "id_ingrediente" BIGINT NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "quantidade_estoque" BIGINT NOT NULL,
    "unidade" VARCHAR(255) NOT NULL,
    "data_validade" TIMESTAMP(0) WITH
        TIME zone NOT NULL,
        "estoque_minimo" BIGINT NOT NULL
);
ALTER TABLE
    "ingredientes" ADD PRIMARY KEY("id_ingrediente");
ALTER TABLE
    "item_pedido" ADD CONSTRAINT "item_pedido_fk_id_prato_foreign" FOREIGN KEY("fk_id_prato") REFERENCES "prato"("id_prato");
ALTER TABLE
    "conta_usuario" ADD CONSTRAINT "conta_usuario_fk_id_garcom_foreign" FOREIGN KEY("fk_id_garcom") REFERENCES "garçom"("id_garcom");
ALTER TABLE
    "mesa" ADD CONSTRAINT "mesa_id_mesa_foreign" FOREIGN KEY("id_mesa") REFERENCES "pedido"("fk_id_mesa");
ALTER TABLE
    "receita_prato" ADD CONSTRAINT "receita_prato_fk_id_prato_foreign" FOREIGN KEY("fk_id_prato") REFERENCES "prato"("id_prato");
ALTER TABLE
    "pedido" ADD CONSTRAINT "pedido_fk_id_garcom_foreign" FOREIGN KEY("fk_id_garcom") REFERENCES "garçom"("id_garcom");
ALTER TABLE
    "item_pedido" ADD CONSTRAINT "item_pedido_fk_id_pedido_foreign" FOREIGN KEY("fk_id_pedido") REFERENCES "pedido"("id_pedido");
ALTER TABLE
    "receita_prato" ADD CONSTRAINT "receita_prato_fk_id_ingrediente_foreign" FOREIGN KEY("fk_id_ingrediente") REFERENCES "ingredientes"("id_ingrediente");