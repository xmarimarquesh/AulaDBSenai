create database db_loja;

use db_loja;
-- Estrutura da tabela `marcas`
CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dados da tabela `marcas`
INSERT INTO `marcas` (`id`, `nome`) VALUES
(1, 'Toyota'),
(2, 'Honda'),
(3, 'Volkswagen'),
(4, 'Ford'),
(5, 'Chevrolet'),
(6, 'Mercedes-Benz'),
(7, 'BMW');

-- Estrutura da tabela `veiculos`
CREATE TABLE IF NOT EXISTS `veiculos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_marca` int(11) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  `cor` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_marca` (`id_marca`),
  CONSTRAINT `veiculos_ibfk_1` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dados da tabela `veiculos`
INSERT INTO `veiculos` (`id`, `id_marca`, `modelo`, `ano`, `preco`, `cor`) VALUES
(1, 1, 'Corolla', 2020, '85000.00', 'Prata'),
(2, 2, 'Civic', 2019, '78000.00', 'Preto'),
(3, 3, 'Golf', 2018, '72000.00', 'Branco'),
(4, 4, 'Fusion', 2019, '79000.00', 'Azul'),
(5, 5, 'Cruze', 2021, '82000.00', 'Vermelho'),
(6, 6, 'Classe A', 2020, '90000.00', 'Branco'),
(7, 7, 'Série 3', 2019, '85000.00', 'Preto'),
(8, 1, 'Etios', 2017, '60000.00', 'Azul'),
(9, 4, 'Focus', 2018, '67000.00', NULL),
(10, 3, 'Gol', 2017, '55000.00', 'Vermelho'),
(11, 5, 'Onix', 2018, '63000.00', 'Preto'),
(12, 6, 'C180', 2019, '98000.00', 'Prata'),
(13, 7, 'X1', 2020, '93000.00', 'Branco'),
(14, 4, 'Ranger', 2019, '90000.00', NULL),
(15, 2, 'Civic', 2017, '70000.00', 'Prata');

-- Estrutura da tabela `clientes`
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dados da tabela `clientes`
INSERT INTO `clientes` (`id`, `nome`, `email`, `telefone`) VALUES
(1, 'João', 'joao@example.com', '(11) 9999-8888'),
(2, 'Maria', 'maria@example.com', '(11) 7777-6666'),
(3, 'Pedro', 'pedro@example.com', '(11) 5555-4444'),
(4, 'Ana', 'ana@example.com', '(11) 3333-2222'),
(5, 'Paula', NULL, '(11) 1111-0000'),
(6, 'Carlos', 'carlos@example.com', NULL);

-- Estrutura da tabela `vendas`
CREATE TABLE IF NOT EXISTS `vendas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_veiculo` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `data_venda` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_veiculo` (`id_veiculo`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `vendas_ibfk_1` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculos` (`id`),
  CONSTRAINT `vendas_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dados da tabela `vendas`
INSERT INTO `vendas` (`id`, `id_veiculo`, `id_cliente`, `data_venda`) VALUES
(1, 1, 1, '2023-05-10'),
(2, 2, 3, '2023-06-15'),
(3, 3, 2, '2023-07-20'),
(4, 4, 4, '2023-08-25'),
(5, 5, 5, '2023-09-30'),
(6, 6, 6, '2023-10-05'),
(7, 7, 4, '2023-11-10'),
(8, 8, 2, '2023-12-15'),
(9, 9, 1, '2024-01-20'),
(10, 10, 3, '2024-02-25'),
(11, 11, 5, '2024-03-30'),
(12, 12, 6, '2024-04-05'),
(13, 13, 4, '2024-05-10'),
(14, 14, 2, '2024-06-15'),
(15, 15, 1, '2024-07-20');

-- Atualize o preço do veículo com id = 1 para R$ 88.000,00. Se o preço atual for menor que R$ 85.000,00, execute um ROLLBACK. Caso contrário, execute um COMMIT.

DELIMITER //
CREATE PROCEDURE pcd_AtualizarPreco()
BEGIN
START TRANSACTION;

SET @price = (select preco from veiculos where id = 1);

UPDATE veiculos set preco = 88000 where id = 1;

IF (@price < 85000) THEN
	ROLLBACK;
ELSE 
	COMMIT;
END IF;

END;
// DELIMITER ;

CALL pcd_AtualizarPreco();

select * from veiculos;

-- Adicione um novo cliente com nome = 'Laura', email = 'laura@example.com', e telefone = '(11) 2222-3333'. Se o e-mail já existir na tabela de clientes, execute um ROLLBACK. Caso contrário, execute um COMMIT.

DELIMITER //
CREATE PROCEDURE pcd_InserirCliente(p_nome varchar(255), p_email varchar(255), p_telefone varchar(255))
BEGIN
START TRANSACTION;

IF(p_email in (select email from clientes)) THEN
	SET @emails = true;
END IF;

INSERT INTO clientes (nome, email, telefone) VALUES (p_nome, p_email, p_telefone);

IF(@emails = true) THEN
	ROLLBACK;
ELSE
	COMMIT;
END IF;

END;

// DELIMITER ;

DROP PROCEDURE pcd_InserirCliente;

CALL pcd_InserirCliente('Laura', 'lauraaa@example.com', '(11) 2222-3333');

select * from clientes;

-- Atualize a cor do veículo com id = 4 para 'Cinza'. Se a cor atual já for 'Cinza', execute um ROLLBACK. Caso contrário, execute um COMMIT.
DELIMITER //
CREATE PROCEDURE pcd_AtualizarCorVeiculo()
BEGIN
START TRANSACTION;

SET @cor = (select cor from veiculos where id = 1);

UPDATE veiculos set cor = 'Cinza' where id = 1;

IF (@cor = 'Cinza') THEN
	ROLLBACK;
ELSE 
	COMMIT;
    
END IF;

END;
// DELIMITER ;

-- Exclua a venda com id = 5. Se a venda estiver associada a um cliente cujo nome é 'Paula', execute um ROLLBACK. Caso contrário, execute um COMMIT.
DELIMITER //
CREATE PROCEDURE pcd_ExcluirVenda()
BEGIN
START TRANSACTION;

SET @cliente = (select c.nome from clientes c inner join vendas v on v.id_cliente = c.id where v.id = 5);

DELETE FROM vendas WHERE id = 5;

IF(@cliente = 'Paula') THEN
	ROLLBACK;
ELSE
	COMMIT;
END IF;

END;
// DELIMITER ;

CALL pcd_AtualizarCorVeiculo;

select * from vendas;

SELECT * FROM CLIENTES;

-- Atualize o ano do veículo com id = 7 para 2021. Se o ano atual já for 2021, execute um ROLLBACK. Caso contrário, execute um COMMIT.
DELIMITER //
CREATE PROCEDURE pcd_AtualizarAnoVeiculo()
BEGIN
START TRANSACTION;

SET @ano = (select ano from veiculos where id = 7);

UPDATE veiculos set ano = 2021 where id = 7;

IF (@ano = 2021) THEN
	ROLLBACK;
ELSE 
	COMMIT;
    
END IF;

END;
// DELIMITER ;

-- Adicione um novo veículo com modelo = 'Passat', ano = 2021, preço = 95.000,00, cor = 'Azul', e id_marca = 3. Se o modelo já existir, execute um ROLLBACK. Caso contrário, execute um COMMIT.


-- Atualize o telefone do cliente com id = 6 para '(11) 4444-5555'. Se o telefone atual for diferente de '(11) 4444-5555', execute um ROLLBACK. Caso contrário, execute um COMMIT.


-- Exclua o cliente com id = 3. Se o cliente estiver associado a alguma venda, execute um ROLLBACK. Caso contrário, execute um COMMIT.


-- Atualize o modelo do veículo com id = 10 para 'Gol G6'. Se o modelo atual for 'Gol G6', execute um ROLLBACK. Caso contrário, execute um COMMIT.


-- Adicione uma nova venda com id_veiculo = 2, id_cliente = 4, e data_venda = '2024-08-01'. Se o cliente já tiver uma venda com o mesmo veículo, execute um ROLLBACK. Caso contrário, execute um COMMIT.



