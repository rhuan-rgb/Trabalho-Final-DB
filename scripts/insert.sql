-- =========================
-- 1. MESA
-- =========================
INSERT INTO "mesa" (
    "id_mesa",
    "capacidade",
    "status",
    "localizacao"
)
SELECT
    gs AS id_mesa,
    CASE 
        WHEN gs % 4 = 0 THEN 2
        WHEN gs % 4 = 1 THEN 4
        WHEN gs % 4 = 2 THEN 6
        ELSE 8
    END AS capacidade,
    CASE 
        WHEN gs % 3 = 0 THEN FALSE
        ELSE TRUE
    END AS status,
    'Setor ' || ((gs % 5) + 1) AS localizacao
FROM generate_series(1, 50) AS gs;


-- =========================
-- 2. GARÇOM
-- =========================
INSERT INTO "garçom" (
    "id_garcom",
    "telefones",
    "email",
    "nome",
    "data_contratacao",
    "cpf"
)
SELECT
    gs AS id_garcom,
    '(16) 9' || LPAD(gs::TEXT, 8, '0') AS telefones,
    'garcom' || gs || '@saborordem.com' AS email,
    'Garcom ' || gs AS nome,
    NOW() - (gs || ' months')::INTERVAL AS data_contratacao,
    LPAD(gs::TEXT, 11, '0') AS cpf
FROM generate_series(1, 50) AS gs;


-- =========================
-- 3. PRATO
-- =========================
INSERT INTO "prato" (
    "id_prato",
    "preco",
    "nome",
    "categoria",
    "tempo_preparo",
    "descricao"
)
SELECT
    gs AS id_prato,
    CASE 
        WHEN gs % 5 = 0 THEN 25
        WHEN gs % 5 = 1 THEN 35
        WHEN gs % 5 = 2 THEN 42
        WHEN gs % 5 = 3 THEN 18
        ELSE 55
    END AS preco,
    'Prato ' || gs AS nome,
    CASE
        WHEN gs % 4 = 0 THEN 'Massa'
        WHEN gs % 4 = 1 THEN 'Carne'
        WHEN gs % 4 = 2 THEN 'Bebida'
        ELSE 'Sobremesa'
    END AS categoria,
    MAKE_TIME(0, (10 + (gs % 40))::INT, 0) AS tempo_preparo,
    'Descricao do prato ' || gs AS descricao
FROM generate_series(1, 50) AS gs;


-- =========================
-- 4. INGREDIENTES
-- =========================
INSERT INTO "ingredientes" (
    "id_ingrediente",
    "nome",
    "quantidade_estoque",
    "unidade",
    "data_validade",
    "estoque_minimo"
)
SELECT
    gs AS id_ingrediente,
    'Ingrediente ' || gs AS nome,
    100 + (gs * 3) AS quantidade_estoque,
    CASE
        WHEN gs % 3 = 0 THEN 'kg'
        WHEN gs % 3 = 1 THEN 'unidade'
        ELSE 'litro'
    END AS unidade,
    NOW() + (gs || ' days')::INTERVAL AS data_validade,
    10 + (gs % 20) AS estoque_minimo
FROM generate_series(1, 50) AS gs;


-- =========================
-- 5. PEDIDO
-- Depende de garçom e mesa
-- =========================
INSERT INTO "pedido" (
    "id_pedido",
    "forma_pagamento",
    "status",
    "observacoes",
    "data_hora",
    "fk_id_garcom",
    "fk_id_mesa"
)
SELECT
    gs AS id_pedido,
    CASE
        WHEN gs % 4 = 0 THEN 'Dinheiro'
        WHEN gs % 4 = 1 THEN 'Cartao de credito'
        WHEN gs % 4 = 2 THEN 'Cartao de debito'
        ELSE 'Pix'
    END AS forma_pagamento,
    CASE
        WHEN gs % 5 = 0 THEN FALSE
        ELSE TRUE
    END AS status,
    'Observacao do pedido ' || gs AS observacoes,
    NOW() - (gs || ' hours')::INTERVAL AS data_hora,
    ((gs - 1) % 50) + 1 AS fk_id_garcom,
    ((gs - 1) % 50) + 1 AS fk_id_mesa
FROM generate_series(1, 50) AS gs;


-- =========================
-- 6. CONTA_USUARIO
-- Depende de garçom
-- =========================
INSERT INTO "conta_usuario" (
    "id_conta",
    "nivel_acesso",
    "status",
    "login",
    "senha",
    "fk_id_garcom"
)
SELECT
    gs AS id_conta,
    CASE
        WHEN gs % 10 = 0 THEN 2
        ELSE 1
    END AS nivel_acesso,
    TRUE AS status,
    'usuario' || gs AS login,
    'senha' || gs AS senha,
    gs AS fk_id_garcom
FROM generate_series(1, 50) AS gs;


-- =========================
-- 7. ITEM_PEDIDO
-- Depende de pedido e prato
-- =========================
INSERT INTO "item_pedido" (
    "id_item_pedido",
    "observacao",
    "quantidade",
    "fk_id_pedido",
    "fk_id_prato"
)
SELECT
    gs AS id_item_pedido,
    CASE
        WHEN gs % 3 = 0 THEN 'Sem cebola'
        WHEN gs % 3 = 1 THEN 'Ponto da carne ao ponto'
        ELSE 'Sem observacao'
    END AS observacao,
    ((gs - 1) % 5) + 1 AS quantidade,
    ((gs - 1) % 50) + 1 AS fk_id_pedido,
    ((gs - 1) % 50) + 1 AS fk_id_prato
FROM generate_series(1, 50) AS gs;


-- =========================
-- 8. RECEITA_PRATO
-- Depende de prato e ingredientes
-- =========================
INSERT INTO "receita_prato" (
    "id_receita_prato",
    "prato",
    "quantidade",
    "ingrediente",
    "fk_id_prato",
    "fk_id_ingrediente"
)
SELECT
    gs AS id_receita_prato,
    ((gs - 1) % 50) + 1 AS prato,
    ((gs - 1) % 10) + 1 AS quantidade,
    ((gs - 1) % 50) + 1 AS ingrediente,
    ((gs - 1) % 50) + 1 AS fk_id_prato,
    ((gs - 1) % 50) + 1 AS fk_id_ingrediente
FROM generate_series(1, 50) AS gs;