-- Exemplo de CRUD para a tabela "mesa"

-- C: CREATE
-- Inserir uma nova mesa

INSERT INTO "mesa" (
    "id_mesa",
    "capacidade",
    "status",
    "localizacao"
)
VALUES (
    1,
    4,
    TRUE,
    'Salão principal'
);

-- R: READ
-- Consultar todas as mesas

SELECT *
FROM "mesa";

-- U: UPDATE
-- Atualizar dados de uma mesa

UPDATE "mesa"
SET
    "capacidade" = 6,
    "status" = FALSE,
    "localizacao" = 'Área externa'
WHERE "id_mesa" = 1;

-- D: DELETE
-- Excluir uma mesa

DELETE FROM "mesa"
WHERE "id_mesa" = 1;