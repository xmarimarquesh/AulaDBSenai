-- Criação do banco de dados
CREATE DATABASE DetranDB;
USE DetranDB;

-- Tabela para registrar proprietários
CREATE TABLE Proprietarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    pontos_cartreira INT DEFAULT 0
);

-- Tabela para registrar veículos
CREATE TABLE Veiculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(255) NOT NULL,
    modelo VARCHAR(255) NOT NULL,
    placa VARCHAR(7) UNIQUE NOT NULL,
    ano INT,
    proprietario_id INT,
    FOREIGN KEY (proprietario_id) REFERENCES Proprietarios(id)
);

-- Tabela para registrar infrações de trânsito
CREATE TABLE Infracoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    gravidade ENUM('Leve', 'Média', 'Grave', 'Gravíssima'),
    data_ocorrencia DATE NOT NULL,
    veiculo_id INT,
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos(id)
);

-- Tabela para registrar licenciamentos dos veículos
CREATE TABLE Licenciamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_validade DATE NOT NULL,
    veiculo_id INT,
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos(id)
);

-- Tabela para registrar multas aplicadas
CREATE TABLE Multas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10, 2) NOT NULL,
    pontos INT DEFAULT 0,
    data_aplicacao DATE NOT NULL,
    infracao_id INT,
    FOREIGN KEY (infracao_id) REFERENCES Infracoes(id)
);

-- Inserção de dados nas tabelas
-- Proprietarios
INSERT INTO Proprietarios (nome, cpf, endereco, telefone) VALUES
('João Silva', '12345678901', 'Rua A, 123', '(11) 1234-5678'),
('Maria Oliveira', '98765432101', 'Rua B, 456', '(11) 9876-5432'),
('Carlos Souza', '11122233344', 'Rua C, 789', '(11) 1111-2222'),
('Ana Lima', '55566677788', 'Rua D, 1011', '(11) 5555-6666'),
('Pedro Costa', '99988877766', 'Rua E, 1213', '(11) 9999-8888');

-- Veiculos
INSERT INTO Veiculos (marca, modelo, placa, ano, proprietario_id) VALUES
('Fiat', 'Uno', 'ABC1234', 2020, 1),
('Volkswagen', 'Gol', 'DEF5678', 2018, 2),
('Chevrolet', 'Onix', 'GHI9101', 2021, 3),
('Ford', 'Ka', 'JKL1112', 2019, 4),
('Honda', 'Civic', 'MNO1314', 2022, 5),
('Toyota', 'Corolla', 'PQR1516', 2020, 1),
('Hyundai', 'HB20', 'STU1718', 2017, 2),
('Renault', 'Kwid', 'VWX1920', 2018, 3),
('Nissan', 'Versa', 'YZA2122', 2019, 4),
('Jeep', 'Compass', 'BCD2324', 2021, 5);

-- Infracoes
INSERT INTO Infracoes (descricao, gravidade, data_ocorrencia, veiculo_id) VALUES
('Excesso de velocidade', 'Média', '2024-04-20', 1),
('Estacionamento irregular', 'Leve', '2024-04-21', 2),
('Ultrapassagem em local proibido', 'Grave', '2024-04-22', 3),
('Falta de cinto de segurança', 'Leve', '2024-04-23', 4),
('Dirigir sob efeito de álcool', 'Gravíssima', '2024-04-24', 5),
('Uso de celular ao volante', 'Média', '2024-04-25', 6),
('Não respeitar a sinalização', 'Grave', '2024-04-26', 7),
('Estacionamento em vaga de idoso', 'Leve', '2024-04-27', 8),
('Falta de inspeção veicular', 'Grave', '2024-04-28', 9),
('Excesso de lotação', 'Média', '2024-04-29', 10);

-- Licenciamentos
INSERT INTO Licenciamentos (data_validade, veiculo_id) VALUES
('2024-04-30', 1),
('2023-05-01', 2),
('2023-05-02', 3),
('2024-05-03', 4),
('2023-05-04', 5),
('2024-05-05', 6),
('2025-05-06', 7),
('2012-05-07', 8),
('2022-05-08', 9),
('2008-05-09', 10);

-- Multas
INSERT INTO Multas (valor, pontos, data_aplicacao, infracao_id) VALUES
(150.00, 5, '2024-04-20', 1),
(100.00, 3, '2024-04-21', 2),
(500.00, 7, '2024-04-22', 3),
(80.00, 2, '2024-04-23', 4),
(2000.00, 10, '2024-04-24', 5),
(130.00, 4, '2024-04-25', 6),
(500.00, 7, '2024-04-26', 7),
(50.00, 2, '2024-04-27', 8),
(250.00, 6, '2024-04-28', 9),
(120.00, 4, '2024-04-29', 10);


-- Inserir um novo veículo e seu proprietário (com trigger)

DELIMITER //
CREATE PROCEDURE setVeiculoProprietario(marca varchar(30), modelo varchar(30), placa char(7), ano int, id_proprietario int)
BEGIN
	INSERT INTO veiculos VALUES (marca, ano, modelo, placa, ano, id_proprietario);
END
// DELIMITER ;

-- Deletar um veículo e suas multas associadas (com trigger)


-- Inserir uma nova infração e atualizar multas associadas (com trigger)

-- Atualizar pontos na carteira de um proprietário específico que levou uma multa(com trigger)

-- Deletar um proprietário e seus veículos associados (com trigger)

-- Selecionar veículos com licenciamento expirado
DELIMITER //
CREATE PROCEDURE LicenciamentoExpirado(ano date)
begin
	select v.* from veiculos v
    inner join licenciamentos l on l.veiculo_id = v.id
    where l.data_validade > ano;
end;
// DELIMITER ;

call LicenciamentoExpirado('2024-04-20');

-- Selecionar veículos que possuem multas graves
DELIMITER //
CREATE PROCEDURE VeiculosMultasGraves(gravidade varchar(30))
begin
	select v.* from veiculos v
    inner join infracoes i on i.veiculo_id = v.id
    where i.gravidade = gravidade;
end;
// DELIMITER ;

call VeiculosMultasGraves("Gravíssima");

-- Selecionar veículos acima de 2021 
DELIMITER //
CREATE PROCEDURE VeiculosAno(ano_parametro int)
BEGIN
	SELECT * from veiculos
    where ano > ano_parametro;
END;
// DELIMITER ;

call VeiculosAno(2021);

-- Selecionar multas de veículos abaixo de 2020
DELIMITER //
CREATE PROCEDURE VeiculosAnoAbaixo(ano_parametro int)
BEGIN
	select m.* from multas m
    inner join infracoes i on i.id = m.infracao_id
    inner join veiculos v on i.veiculo_id = v.id
    where v.ano > ano_parametro;
END;
// DELIMITER ;

call VeiculosAnoAbaixo(2020);

-- Selecionar todos os veículos com multas pendentes
-- --------------------------------------------------

-- Inserir um novo proprietário
DELIMITER //
CREATE PROCEDURE InserirProprietario(nome varchar(50), cpf varchar(11), endereco varchar(255), telefone varchar(15), pontos_carteira int)
BEGIN
	insert into proprietarios(nome, cpf, endereco, telefone, pontos_cartreira) values (nome, cpf, endereco, telefone, pontos_carteira);
END;
// DELIMITER ;

call InserirProprietario("Mariana Marques", "12799877600", "Rua ABC, 24", "(11) 0987-1234", 2);

select * from proprietarios;

-- Atualizar informações de um proprietário
DELIMITER //
CREATE PROCEDURE AtualizarProprietario(id_parametro int, nome varchar(50), cpf varchar(11), endereco varchar(255), telefone varchar(15), pontos_carteira int)
BEGIN
	update proprietarios
    set nome = nome,
    cpf = cpf,
    endereco = endereco,
    telefone = telefone,
    pontos_cartreira = pontos_carteira
    where id = id_parametro;
END;
// DELIMITER ;

drop procedure AtualizarProprietario;

call AtualizarProprietario(1, "Mariana Marques", "12729877600", "Rua ABC, 24", "(11) 0987-1234", 2);

select * from proprietarios;

-- Deletar um proprietário
select * from veiculos;
select * from licenciamentos;
select * from multas;
select * from proprietarios;
select * from infracoes;


-- Selecionar todos os proprietários

-- Inserir uma nova infração

-- Atualizar informações de uma infração

-- Deletar uma infração

-- Selecionar todas as infrações

-- Inserir um novo licenciamento

-- Atualizar informações de um licenciamento
