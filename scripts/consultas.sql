-- Pedidos com dados do garçom e da mesa
-- Mostra pedidos ativos, com o garçom responsável e a mesa relacionada.

SELECT
    p."id_pedido",
    p."forma_pagamento",
    p."status",
    p."data_hora",
    g."nome" AS garcom,
    m."id_mesa",
    m."localizacao"
FROM "pedido" p
JOIN "garçom" g
    ON p."fk_id_garcom" = g."id_garcom"
JOIN "mesa" m
    ON p."fk_id_mesa" = m."id_mesa"
WHERE p."status" = TRUE
ORDER BY p."data_hora" DESC;



-- Pedidos realizados por um garçom específico
-- Mostra todos os pedidos registrados pelo garçom de ID 1.

SELECT
    p."id_pedido",
    p."data_hora",
    p."forma_pagamento",
    p."observacoes",
    g."nome" AS garcom
FROM "pedido" p
JOIN "garçom" g
    ON p."fk_id_garcom" = g."id_garcom"
WHERE g."id_garcom" = 1
ORDER BY p."data_hora" DESC;



-- Pedidos de uma mesa específica
-- Mostra o histórico de pedidos da mesa 1.

SELECT
    p."id_pedido",
    p."data_hora",
    p."forma_pagamento",
    p."status",
    m."id_mesa",
    m."localizacao"
FROM "pedido" p
JOIN "mesa" m
    ON p."fk_id_mesa" = m."id_mesa"
WHERE m."id_mesa" = 1
ORDER BY p."data_hora" DESC;



-- Itens de um pedido com nome e preço do prato
-- Mostra os pratos pertencentes ao pedido 1.

SELECT
    p."id_pedido",
    pr."nome" AS prato,
    pr."preco",
    ip."quantidade",
    ip."observacao"
FROM "item_pedido" ip
JOIN "pedido" p
    ON ip."fk_id_pedido" = p."id_pedido"
JOIN "prato" pr
    ON ip."fk_id_prato" = pr."id_prato"
WHERE p."id_pedido" = 1
ORDER BY pr."nome" ASC;



-- Valor estimado de cada item do pedido
-- Calcula o subtotal de cada item do pedido.

SELECT
    p."id_pedido",
    pr."nome" AS prato,
    ip."quantidade",
    pr."preco",
    (ip."quantidade" * pr."preco") AS subtotal
FROM "item_pedido" ip
JOIN "pedido" p
    ON ip."fk_id_pedido" = p."id_pedido"
JOIN "prato" pr
    ON ip."fk_id_prato" = pr."id_prato"
WHERE p."id_pedido" = 1
ORDER BY subtotal DESC;




-- Valor total de cada pedido
-- Mostra o valor total dos pedidos ativos.

SELECT
    p."id_pedido",
    p."data_hora",
    g."nome" AS garcom,
    m."id_mesa",
    SUM(ip."quantidade" * pr."preco") AS valor_total
FROM "pedido" p
JOIN "garçom" g
    ON p."fk_id_garcom" = g."id_garcom"
JOIN "mesa" m
    ON p."fk_id_mesa" = m."id_mesa"
JOIN "item_pedido" ip
    ON ip."fk_id_pedido" = p."id_pedido"
JOIN "prato" pr
    ON ip."fk_id_prato" = pr."id_prato"
WHERE p."status" = TRUE
GROUP BY
    p."id_pedido",
    p."data_hora",
    g."nome",
    m."id_mesa"
ORDER BY valor_total DESC;



-- Pratos mais vendidos
-- Mostra os pratos mais vendidos com base nos itens dos pedidos.

SELECT
    pr."id_prato",
    pr."nome" AS prato,
    pr."categoria",
    SUM(ip."quantidade") AS total_vendido
FROM "item_pedido" ip
JOIN "prato" pr
    ON ip."fk_id_prato" = pr."id_prato"
WHERE pr."categoria" IS NOT NULL
GROUP BY
    pr."id_prato",
    pr."nome",
    pr."categoria"
ORDER BY total_vendido DESC;




-- Ingredientes usados em um prato específico
-- Mostra quais ingredientes são usados no prato de ID 1.

SELECT
    pr."nome" AS prato,
    i."nome" AS ingrediente,
    rp."quantidade",
    i."unidade"
FROM "receita_prato" rp
JOIN "prato" pr
    ON rp."fk_id_prato" = pr."id_prato"
JOIN "ingredientes" i
    ON rp."fk_id_ingrediente" = i."id_ingrediente"
WHERE pr."id_prato" = 1
ORDER BY i."nome" ASC;




-- Ingredientes abaixo do estoque mínimo
-- Mostra ingredientes que precisam de reposição.

SELECT
    i."id_ingrediente",
    i."nome",
    i."quantidade_estoque",
    i."estoque_minimo",
    i."unidade",
    i."data_validade"
FROM "ingredientes" i
WHERE i."quantidade_estoque" <= i."estoque_minimo"
ORDER BY i."quantidade_estoque" ASC;




-- Contas de usuário vinculadas aos garçons
-- Mostra as contas ativas dos garçons.

SELECT
    c."id_conta",
    c."login",
    c."nivel_acesso",
    c."status",
    g."nome" AS garcom,
    g."email"
FROM "conta_usuario" c
JOIN "garçom" g
    ON c."fk_id_garcom" = g."id_garcom"
WHERE c."status" = TRUE
ORDER BY g."nome" ASC;
