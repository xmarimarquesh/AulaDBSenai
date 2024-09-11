create database AV2;

use AV2;

CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    data_contratacao DATE NOT NULL
);

CREATE TABLE historico_cargos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_id INT,
    cargo_anterior VARCHAR(50),
    cargo_novo VARCHAR(50),
    salario_anterior DECIMAL(10, 2),
    salario_novo DECIMAL(10, 2),
    data_mudanca TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id)
);

CREATE TABLE aumento_salario_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_id INT,
    salario_antigo DECIMAL(10, 2),
    salario_novo DECIMAL(10, 2),
    data_aumento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id)
);

CREATE TABLE departamentos_estatisticas (
    departamento VARCHAR(50) PRIMARY KEY,
    total_funcionarios INT DEFAULT 0
);

-- 1 - Desenvolva uma trigger que registre todos os aumentos de salário em uma tabela de auditoria chamada 
-- aumento_salario_audit. A trigger deve ser acionada antes da atualização do salário e inserir o ID do funcionário,
-- o valor anterior, o valor novo, e a data do aumento.

DELIMITER // 

create trigger registrarAumento
before update on funcionarios
for each row
begin
	insert into aumento_salario_audit( funcionario_id, salario_antigo, salario_novo, data_aumento) 
    values (new.id, (select salario from funcionarios where id = new.id), new.salario, curdate());
end

// DELIMITER ;
select * from Funcionarios;

insert into funcionarios(nome, cargo, salario, departamento, data_contratacao) values ('Mariana', 'Aprendiz', 5000, 'RH', curdate());

update funcionarios set salario = 11000 where id = 1;

select * from aumento_salario_audit;

-- 2 - Crie uma trigger que, ao alterar o cargo de um funcionário, registre o histórico da mudança na tabela historico_cargos, 
-- gravando o cargo anterior e o novo cargo.

DELIMITER //

create trigger registrarAlteracaoCargo
before update on funcionarios
for each row
begin
	if((select cargo from funcionarios where id = new.id) != new.cargo) THEN
    
		insert into historico_cargos(funcionario_id, cargo_anterior, cargo_novo, salario_anterior, salario_novo, data_mudanca)
		values (new.id, (select cargo from funcionarios where id = new.id), new.cargo, (select salario from funcionarios where id = new.id), new.salario, curdate());
    
    END IF;
end

// DELIMITER ;

select * from Funcionarios;

update funcionarios set cargo = 'Estagiario' where id = 1;

select * from historico_cargos;

-- 3 - Crie uma trigger que, ao inserir ou excluir um funcionário, atualize a tabela departamentos_estatisticas com o 
-- número total de funcionários por departamento. A trigger deve incrementar o contador ao inserir um novo funcionário 
-- e decrementar ao excluir.  

DELIMITER //

create trigger aumentarTotalFunc
before insert on funcionarios
for each row
begin
	update departamentos_estatisticas 
	set total_funcionarios = (total_funcionarios + 1)
    where departamento = new.departamento;
end

// DELIMITER ;

DELIMITER //

create trigger diminuirTotalFunc
before delete on funcionarios
for each row
begin
	update departamentos_estatisticas 
	set total_funcionarios = (total_funcionarios - 1)
    where departamento = old.departamento;
end

// DELIMITER ;

insert into departamentos_estatisticas (departamento, total_funcionarios) values ('RH', 0), ('BDO', 0), ('ICO', 0);

insert into funcionarios(nome, cargo, salario, departamento, data_contratacao) values ('Mariana', 'Aprendiz', 5000, 'RH', curdate());
insert into funcionarios(nome, cargo, salario, departamento, data_contratacao) values ('Juliana', 'Aprendiz', 5000, 'RH', curdate());

delete from funcionarios where id = 2;

select * from funcionarios;

select * from departamentos_estatisticas;

