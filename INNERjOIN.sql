CREATE DATABASE IF NOT EXISTS bookstore;

USE bookstore;

-- Tabela 'autores'
CREATE TABLE autores (
autor_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100)
);

-- Tabela 'livros'
CREATE TABLE livros (
livro_id INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(200),
autor_id INT,
preco DECIMAL(10, 2),
FOREIGN KEY (autor_id) REFERENCES autores(autor_id)
);

-- Tabela 'clientes'
CREATE TABLE clientes (
cliente_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
email VARCHAR(100)
);

-- Tabela 'pedidos'
CREATE TABLE pedidos (
pedido_id INT AUTO_INCREMENT PRIMARY KEY,
cliente_id INT,
livro_id INT,
quantidade INT,
data_pedido DATE,
FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
FOREIGN KEY (livro_id) REFERENCES livros(livro_id)
);

INSERT INTO autores (nome) VALUES
('Stephen King'),
('J.K. Rowling'),
('George Orwell'),
('Harper Lee'),
('Agatha Christie'),
('Gabriel García Márquez'),
('Jane Austen'),
('F. Scott Fitzgerald'),
('Leo Tolstoy'),
('J.R.R. Tolkien'),
('Ernest Hemingway'),
('Mark Twain'),
('Charles Dickens'),
('Herman Melville'),
('Emily Brontë'),
('Arthur Conan Doyle'),
('Victor Hugo'),
('Franz Kafka'),
('Mary Shelley'),
('Toni Morrison');

-- Inserções para a tabela 'livros'
INSERT INTO livros (titulo, autor_id, preco) VALUES
('It', 1, 25.99),
('Harry Potter and the Philosopher''s Stone', 2, 22.50),
('1984', 3, 18.75),
('To Kill a Mockingbird', 4, 20.80),
('Murder on the Orient Express', 5, 16.99),
('One Hundred Years of Solitude', 6, 21.25),
('Pride and Prejudice', 7, 15.50),
('The Great Gatsby', 8, 14.99),
('War and Peace', 9, 29.99),
('The Hobbit', 10, 17.95),
('The Old Man and the Sea', 11, 12.75),
('The Adventures of Huckleberry Finn', 12, 13.50),
('Great Expectations', 13, 16.25),
('Moby-Dick', 14, 19.99),
('Wuthering Heights', 15, 14.50),
('The Adventures of Sherlock Holmes', 16, 11.99),
('Les Misérables', 17, 28.50),
('The Metamorphosis', 18, 10.75),
('Frankenstein', 19, 13.99),
('Beloved', 20, 15.25);

INSERT INTO clientes (nome, email) VALUES
('Mariana Marques', 'mariana@example.com');
-- Inserções para a tabela 'clientes'
INSERT INTO clientes (nome, email) VALUES
('João Silva', 'joao.silva@example.com'),
('Maria Santos', 'maria.santos@example.com'),
('Pedro Oliveira', 'pedro.oliveira@example.com'),
('Ana Pereira', 'ana.pereira@example.com'),
('Carlos Souza', 'carlos.souza@example.com'),
('Juliana Costa', 'juliana.costa@example.com'),
('Lucas Martins', 'lucas.martins@example.com'),
('Mariana Almeida', 'mariana.almeida@example.com'),
('Gustavo Lima', 'gustavo.lima@example.com'),
('Camila Rocha', 'camila.rocha@example.com'),
('Fernando Gomes', 'fernando.gomes@example.com'),
('Amanda Santos', 'amanda.santos@example.com'),
('Rafael Pereira', 'rafael.pereira@example.com'),
('Larissa Oliveira', 'larissa.oliveira@example.com'),
('Diego Costa', 'diego.costa@example.com'),
('Patrícia Souza', 'patricia.souza@example.com'),
('Bruno Lima', 'bruno.lima@example.com'),
('Carolina Alves', 'carolina.alves@example.com'),
('Vinícius Fernandes', 'vinicius.fernandes@example.com'),
('Marina Ribeiro', 'marina.ribeiro@example.com');

-- Inserções para a tabela 'pedidos'
INSERT INTO pedidos (cliente_id, livro_id, quantidade, data_pedido) VALUES
(1, 1, 2, '2024-03-01'),
(2, 2, 1, '2024-03-02'),
(3, 3, 3, '2024-03-03'),
(4, 4, 1, '2024-03-04'),
(5, 5, 2, '2024-03-05'),
(6, 6, 1, '2024-03-06'),
(7, 7, 2, '2024-03-07'),
(8, 8, 1, '2024-03-08'),
(9, 9, 3, '2024-03-09'),
(10, 10, 1, '2024-03-10'),
(11, 11, 2, '2024-03-11'),
(12, 12, 1, '2024-03-12'),
(13, 13, 2, '2024-03-13'),
(14, 14, 1, '2024-03-14'),
(15, 15, 3, '2024-03-15'),
(16, 16, 1, '2024-03-16'),
(17, 17, 2, '2024-03-17'),
(18, 18, 1, '2024-03-18'),
(19, 19, 2, '2024-03-19'),
(20, 20, 1, '2024-03-20');

select * from autores;
select * from livros;

-- 1. Listar todos os livros com seus respectivos autores.
select l.titulo, a.nome from livros l
inner join autores a on l.autor_id = a.autor_id;

-- 2. Listar todos os livros, mesmo aqueles que não têm um autor associado.
select l.titulo, a.nome from livros l
left join autores a on l.autor_id = a.autor_id;

-- 3. Listar todos os autores, mesmo aqueles que não têm livros associados.
select l.titulo, a.nome from livros l
right join autores a on l.autor_id = a.autor_id;

-- 4. Listar todos os clientes que fizeram pedidos, incluindo os detalhes do pedido (livro e quantidade).
select c.nome, l.titulo, p.quantidade from clientes c
inner join pedidos p on p.cliente_id = c.cliente_id
inner join livros l on l.livro_id = p.livro_id;

-- 5. Listar todos os pedidos feitos em uma determinada data, incluindo os nomes dos clientes que fizeram esses pedidos.
select c.nome, p.data_pedido from clientes c
inner join pedidos p on p.cliente_id = c.cliente_id
where data_pedido = "2024-03-01";

-- 6. Listar todos os livros vendidos, incluindo os detalhes do pedido (cliente e quantidade), mesmo que não tenham sido pedidos.
select c.nome, l.titulo, p.quantidade from clientes c
inner join pedidos p on p.cliente_id = c.cliente_id
left join livros l on l.livro_id = p.livro_id;

-- 7. Listar todos os clientes que não fizeram nenhum pedido.
select nome from clientes
where cliente_id not in 
(select cliente_id from pedidos);

-- 8. Listar todos os autores que têm livros com preço superior a $20.
select a.nome from autores a 
inner join livros l on l.autor_id = a.autor_id 
where preco > 20;

-- 9. Listar todos os livros e seus autores, incluindo os livros que não têm preço definido.
select l.titulo, a.nome from livros l 
inner join autores a on l.autor_id = a.autor_id;

-- 10. Listar todos os pedidos, incluindo os livros que não foram pedidos, e o cliente associado, se houver.


-- 11. Listar todos os autores que têm livros com preços definidos e quantidades vendidas maiores que 1.
select * from pedidos;
select * from clientes;
select * from livros;
select * from autores;

select a.nome from autores a 
inner join livros l on l.autor_id = a.autor_id 
inner join pedidos p on p.livro_id = l.livro_id 
where p.quantidade > 1 and l.preco > 0;

-- 12. Listar todos os clientes, incluindo os que não fizeram pedidos, e os livros associados a cada pedido, se houver.

-- 13. Listar todos os autores que têm livros associados a pedidos feitos em uma determinada data.

-- 14. Listar todos os pedidos feitos por clientes com nomes que começam com a letra "A", incluindo os detalhes do livro.

-- 15. Listar todos os livros que não foram pedidos até o momento.

-- 16. Listar todos os pedidos feitos por clientes, incluindo os detalhes do livro, ordenados por data de pedido.

-- 17. Listar todos os autores que têm livros com preços definidos, e os livros que não têm preço definido.

-- 18. Listar todos os pedidos com seus respectivos clientes e livros, incluindo os pedidos sem cliente associado.

-- 19. Listar todos os clientes e os livros que eles pediram, incluindo os clientes que não fizeram nenhum pedido.

-- 20. Listar todos os autores que têm livros associados a pedidos feitos por clientes com nomes que terminam com a letra "a".



