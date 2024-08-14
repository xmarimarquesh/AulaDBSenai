CREATE DATABASE db_loja_eletronicos;

USE db_loja_eletronicos;

-- Tabela `produtos`
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL
);

-- Tabela `clientes`
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20) DEFAULT NULL,
    valor_total_compras DECIMAL(10, 2) DEFAULT 0.00
);

-- Tabela `vendas`
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    id_cliente INT NOT NULL,
    data_venda DATE NOT NULL,
    quantidade INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela `promocoes`
CREATE TABLE promocoes (
    id_promocao INT PRIMARY KEY AUTO_INCREMENT,
    nome_promocao VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    desconto DECIMAL(5, 2) NOT NULL
);

-- Tabela `notificacoes`
CREATE TABLE notificacoes (
    id_notificacao INT PRIMARY KEY AUTO_INCREMENT,
    mensagem TEXT NOT NULL,
    data_notificacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO produtos (nome_produto, categoria, preco, quantidade_estoque) VALUES
('Laptop Gamer', 'Eletrônicos', 2999.99, 10),
('Smartphone XYZ', 'Eletrônicos', 1499.49, 25),
('Cadeira Ergonômica', 'Móveis', 799.99, 15),
('Teclado Mecânico', 'Acessórios', 299.99, 30),
('Mouse Óptico', 'Acessórios', 89.99, 50),
('Monitor 24"', 'Eletrônicos', 599.99, 20),
('Fone de Ouvido Bluetooth', 'Acessórios', 199.99, 40),
('Cadeira de Escritório', 'Móveis', 499.99, 12),
('Impressora Multifuncional', 'Eletrônicos', 399.99, 8),
('Webcam HD', 'Acessórios', 129.99, 35);

INSERT INTO clientes (nome, email, telefone, valor_total_compras) VALUES
('Ana Souza', 'ana.souza@example.com', '123456789', 1500.00),
('Carlos Oliveira', 'carlos.oliveira@example.com', '987654321', 2750.00),
('Maria Santos', 'maria.santos@example.com', '456789123', 500.00),
('Pedro Lima', 'pedro.lima@example.com', '321654987', 2000.00),
('Júlia Pereira', 'julia.pereira@example.com', '654321987', 3200.00),
('Roberto Almeida', 'roberto.almeida@example.com', '789123456', 1200.00),
('Luana Costa', 'luana.costa@example.com', '321789654', 1750.00),
('Fernando Silva', 'fernando.silva@example.com', '654987321', 600.00),
('Camila Rocha', 'camila.rocha@example.com', '987321456', 800.00),
('Felipe Martins', 'felipe.martins@example.com', '456123789', 2900.00);

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES
(1, 2, '2024-08-10', 1, 2999.99),
(2, 1, '2024-08-11', 2, 2998.98),
(3, 5, '2024-08-12', 1, 799.99),
(4, 4, '2024-08-13', 3, 899.97),
(5, 6, '2024-08-14', 1, 89.99),
(6, 3, '2024-08-15', 1, 599.99),
(7, 8, '2024-08-16', 2, 399.98),
(8, 7, '2024-08-17', 1, 499.99),
(9, 9, '2024-08-18', 1, 399.99),
(10, 10, '2024-08-19', 2, 259.98);

INSERT INTO promocoes (nome_promocao, data_inicio, data_fim, desconto) VALUES
('Promoção de Verão', '2024-07-01', '2024-08-31', 15.00),
('Desconto de Natal', '2024-12-01', '2024-12-31', 20.00),
('Liquidação de Ano Novo', '2024-12-26', '2025-01-05', 25.00),
('Semana da Tecnologia', '2024-09-01', '2024-09-07', 10.00),
('Oferta de Inverno', '2024-06-01', '2024-06-30', 18.00),
('Black Friday', '2024-11-29', '2024-11-30', 30.00),
('Promoção do Mês', '2024-08-01', '2024-08-31', 12.00),
('Super Ofertas', '2024-10-01', '2024-10-15', 22.00),
('Desconto de Aniversário', '2024-11-01', '2024-11-10', 17.00),
('Festa de Lançamento', '2024-09-15', '2024-09-22', 13.00);

INSERT INTO notificacoes (mensagem, data_notificacao) VALUES
('Novo produto disponível: Laptop Gamer', '2024-08-10 08:30:00'),
('Grande liquidação começando amanhã!', '2024-08-10 09:00:00'),
('Oferta especial em acessórios', '2024-08-11 10:15:00'),
('Novo estoque de cadeiras ergonômicas', '2024-08-12 11:00:00'),
('Lembre-se da promoção de verão', '2024-08-13 12:00:00'),
('Desconto adicional para compras online', '2024-08-14 13:30:00'),
('Produto em falta será reabastecido amanhã', '2024-08-14 14:00:00'),
('Atualização de estoque no site', '2024-08-15 15:00:00'),
('Nova linha de fones de ouvido chegou', '2024-08-16 16:00:00'),
('Agradecimento por sua compra!', '2024-08-17 17:00:00');

select * from vendas;
select * from notificacoes;
select * from promocoes;
select * from clientes;
select * from produtos;


-- 1.Registrar uma nova venda e atualizar o valor total de compras por cliente.
DELIMITER //
CREATE TRIGGER trg_AtualizarValorTotal
AFTER INSERT
ON vendas
FOR EACH ROW
BEGIN
    UPDATE clientes c
    SET c.valor_total_compras = c.valor_total_compras + NEW.valor_total
    WHERE c.id_cliente = NEW.id_cliente;
END;
//
DELIMITER ;

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES (1, 1, '2024-08-10', 1, 4502);

-- 2. Trigger para aplicar desconto de promoção em vendas
DROP TRIGGER IF EXISTS trg_AplicarDesconto;

DELIMITER //
CREATE TRIGGER trg_AplicarDesconto
BEFORE INSERT
ON vendas
FOR EACH ROW
BEGIN
	DECLARE desconto DECIMAL(5,2);
    SET desconto = 0;

    SELECT p.desconto INTO desconto FROM promocoes p
    WHERE NEW.data_venda >= p.data_inicio AND NEW.data_venda <= p.data_fim LIMIT 1;

    SET NEW.valor_total = NEW.valor_total - (NEW.valor_total * (desconto / 100))/ 100;
END;
//
DELIMITER ;

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES (1, 1, '2024-08-10', 1, 5000);

-- 3.Atualizar o preço médio de um produto após uma nova venda.

-- 4.Rastrear alterações no estoque de produtos e registrar uma notificação dentro de um log.

-- 5.Registrar novos clientes e gerar uma mensagem de usuário cadastrado dentro de um log.

-- 6.Monitorar vendas de produtos em promoção e registrar uma notificação.

-- 7.Registrar produtos em falta no estoque e gerar uma notificação.

-- 8.Atualizar o valor total de vendas de um produto após uma nova venda.

-- 9.Rastrear alterações no valor de produtos e registrar uma notificação.

