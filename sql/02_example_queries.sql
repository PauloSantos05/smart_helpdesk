-- 02_example_queries.sql

-- 1. Inserir um novo usuário
INSERT INTO usuarios (nome, email, cargo)
VALUES ('Mariana Silva', 'mariana.silva@empresa.com', 'Analista Jr');

-- 2. Criar um chamado vinculado a esse usuário
INSERT INTO chamados (titulo, descricao, usuario_id, status_id, prioridade_id)
VALUES (
  'Erro ao importar dados',
  'Falha no upload do arquivo CSV de clientes.',
  (SELECT id FROM usuarios WHERE email = 'mariana.silva@empresa.com'),
  (SELECT id FROM status WHERE nome = 'Aberto'),
  (SELECT id FROM prioridades WHERE nome = 'Média')
);

-- 3. Consultar todos os chamados em aberto
SELECT c.id,
       c.titulo,
       u.nome AS solicitante,
       s.nome AS status,
       p.nome AS prioridade,
       c.criado_em
FROM chamados c
JOIN usuarios u ON c.usuario_id = u.id
JOIN status s ON c.status_id = s.id
JOIN prioridades p ON c.prioridade_id = p.id
WHERE s.nome = 'Aberto';

-- 4. Atualizar o status de um chamado
UPDATE chamados
SET status_id = (SELECT id FROM status WHERE nome = 'Concluído'),
    atualizado_em = NOW()
WHERE id = 1;

-- 5. Deletar um chamado
DELETE FROM chamados
WHERE id = 5;
