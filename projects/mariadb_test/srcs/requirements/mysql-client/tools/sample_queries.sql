-- Exemplos de queries SQL para testar a base de dados

-- Ver todas as bases de dados
SHOW DATABASES;

-- Usar a base de dados wordpress_db
USE wordpress_db;

-- Criar uma tabela de exemplo
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir dados de exemplo
INSERT INTO usuarios (nome, email) VALUES
('João Silva', 'joao@example.com'),
('Maria Santos', 'maria@example.com'),
('Pedro Oliveira', 'pedro@example.com');

-- Criar uma tabela de posts
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    conteudo TEXT,
    usuario_id INT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Inserir posts de exemplo
INSERT INTO posts (titulo, conteudo, usuario_id) VALUES
('Primeiro Post', 'Este é o conteúdo do primeiro post', 1),
('Segundo Post', 'Este é o conteúdo do segundo post', 2),
('Terceiro Post', 'Este é o conteúdo do terceiro post', 1);

-- Ver todas as tabelas
SHOW TABLES;

-- Ver dados dos usuários
SELECT * FROM usuarios;

-- Ver dados dos posts
SELECT * FROM posts;

-- Query com JOIN para ver posts com nomes dos usuários
SELECT p.titulo, p.conteudo, u.nome as autor, p.data_criacao
FROM posts p
JOIN usuarios u ON p.usuario_id = u.id
ORDER BY p.data_criacao DESC;

