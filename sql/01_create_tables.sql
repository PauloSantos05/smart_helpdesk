-- 01_create_tables.sql — recria tudo do zero

-- Remover tabelas antigas (na ordem certa)
DROP TABLE IF EXISTS chamados;
DROP TABLE IF EXISTS prioridades;
DROP TABLE IF EXISTS status;
DROP TABLE IF EXISTS usuarios;

-- 1) Tabela de usuários
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cargo VARCHAR(50),
    criado_em TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);

-- 2) Tabela de status
CREATE TABLE status (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

-- 3) Tabela de prioridades
CREATE TABLE prioridades (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    nivel INTEGER NOT NULL
);

-- 4) Tabela de chamados
CREATE TABLE chamados (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,
    usuario_id INTEGER NOT NULL REFERENCES usuarios(id),
    status_id INTEGER NOT NULL REFERENCES status(id),
    prioridade_id INTEGER NOT NULL REFERENCES prioridades(id),
    criado_em TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    atualizado_em TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);

-- 5) Dados iniciais
INSERT INTO status (nome) VALUES
  ('Aberto'),
  ('Em Andamento'),
  ('Concluído'),
  ('Fechado');

INSERT INTO prioridades (nome, nivel) VALUES
  ('Baixa', 1),
  ('Média', 2),
  ('Alta', 3);
