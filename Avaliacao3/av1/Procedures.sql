create database AV1;

use AV1;

create table Permissao (
	IDPermissao int primary key auto_increment not null,
    Descricao varchar(255),
    Nivel_permissao int
);

create table Produto (
	IDProduto int primary key auto_increment not null,
    Nome varchar(255),
    Disponivel int,
    IDFuncionario int,
    Data_insercao date,
    foreign key (IDFuncionario) references Funcionario(IDFuncionario)
);

create table Funcionario (
	IDFuncionario int primary key auto_increment not null,
    Nome varchar(255),
    CPF varchar(15),
    IDPermissao int,
    foreign key (IDPermissao) references Permissao(IDPermissao)
);

create table Venda (
	IDVenda int primary key auto_increment not null,
    Quantidade_produto_vendido int,
    IDFuncionario int,
    foreign key (IDFuncionario) references Funcionario(IDFuncionario)
);

create table ProdutoVendido (
	IDProdutoVendido int primary key auto_increment not null,
    IDProduto int,
    IDVenda int,
    foreign key (IDProduto) references Produto(IDProduto),
	foreign key (IDVenda) references Venda(IDVenda)
);

-- -------------------------------------------------------- PERMISSOES PARA TESTE:
insert into Permissao (Descricao, Nivel_permissao) values ('Nenhuma', 0), ('Baixa', 1), ('Rasoavel', 2), ('Media', 3), ('Alta', 4), ('Master', 5);
select * from Permissao;
-- --------------------------------------------------------

DELIMITER //

create procedure semCPFduplo(Nome varchar(255), CPF varchar(15), IDPermissao int)
begin
	start transaction;
    
    insert into Funcionario (Nome, CPF, IDPermissao) values (Nome, CPF, IDPermissao);
    
	if CPF in (select CPF from Funcionario) THEN
		ROLLBACK;
    else 
		COMMIT;
	END IF;
end;

// DELIMITER ;

call semCPFduplo('Marianass', '2', 1);
call semCPFduplo('Julianass', '123456789', 3);

select * from Funcionario;

-- --------------------------------------------------------

DELIMITER //

create procedure permitir2(id_func int, IDProduto int, Disponivel int)
begin
	start transaction;
    
	update Produto set Disponivel = Disponivel where IDProduto = IDProduto;
    
	if((select p.Nivel_Permissao from Permissao p inner join Funcionario f on f.IDPermissao = p.IDPermissao where f.IDFuncionario = id_func) >= 2) THEN
		COMMIT;
	else
		ROLLBACK;
    END IF;
end;

// DELIMITER ;

INSERT INTO funcionario (Nome, CPF, IDPermissao) values ('Mari', '123', 5);

insert into Produto (Nome, Disponivel, IDFuncionario) values ('Maça', 1, 24);

select * from Produto;
select * from Funcionario;

call permitir2(24, 3, 0);
call permitir2(37, 3, 0);

set SQL_SAFE_UPDATES = 0;

-- --------------------------------------------------------

create table solicitarAlteracaoVendas(
	IDAlteracao int primary key auto_increment not null,
    IDFuncionario int,
    Descricao varchar(255),
    foreign key (IDFuncionario) references Funcionario(IDFuncionario)
);

DELIMITER //

create procedure solicitarAlteracaoemVendas(id_func int, descricao varchar(255))
begin
	start transaction;
    
	insert into solicitarAlteracaoVendas(IDFuncionario, Descricao) values (id_func, descricao);
    
	if((select p.Nivel_Permissao from Permissao p inner join Funcionario f on f.IDPermissao = p.IDPermissao where f.IDFuncionario = id_func) >= 5) THEN
		COMMIT;
	else
		ROLLBACK;
		signal sqlstate '45000' set message_text = 'Não foi possível solicitar alteração';
    END IF;
end;

// DELIMITER ;

call solicitarAlteracaoemVendas(24, "Informações de venda erradas");
call solicitarAlteracaoemVendas(37, "Informações de venda erradas");

select * from Funcionario;

select * from solicitarAlteracaoVendas;
-- --------------------------------------------------------

DELIMITER //

create procedure VerificarDataInsercao(nome varchar(255), disponivel int, IDFuncionario int, data_insercao date)
begin
	start transaction;
    
	insert into Produto(Nome, Disponivel, IDFuncionario, Data_insercao) values (nome, disponivel, IDFuncionario, data_insercao);
    
	if(data_insercao = CURDATE()) THEN
		COMMIT;
	else
		ROLLBACK;
		signal sqlstate '45000' set message_text = 'Erro: Data diferente da data atual';
    END IF;
end;

// DELIMITER ;

select * FROM Produto;

call VerificarDataInsercao('Maça', 1, 24, '2024-09-10');
call VerificarDataInsercao('Maça', 1, 24, curdate());

-- --------------------------------------------------------

DELIMITER //

create procedure bloquearAcaoFuncionario(Nome varchar(255), CPF varchar(15), IDPermissao int)
begin
	start transaction;
    
	insert into Funcionario (Nome, CPF, IDPermissao) values (Nome, CPF, IDPermissao);
    
	if(Nome != null and CPF != null and IDPermissao != null) THEN
		COMMIT;
	else
		ROLLBACK;
    END IF;
end;

// DELIMITER ;

select * from Funcionario;

call bloquearAcaoFuncionario('Mariana', null, 2);
call bloquearAcaoFuncionario('Mariana', '321', 2);

-- --------------------------------------------------------

DELIMITER //

create procedure bloquearVenda(id_venda int, IDFuncionario int, Quantidade_produto int)
begin
	start transaction;
    
	insert into Venda (IDVenda, IDFuncionario, Quantidade_produto_vendido) values (id_venda, IDFuncionario, Quantidade_produto);
    
	if( 0 not in (select p.Disponivel from Produto p inner join ProdutoVendido pv on pv.IDProduto = pv.IDProduto where pv.IDVenda = id_venda)) THEN
		COMMIT;
	else
		ROLLBACK;
    END IF;
end;

// DELIMITER ;

select * from Produto;

insert into Produto (Nome, Disponivel, IDFuncionario, Data_insercao) values ('Banana', 0, 37, curdate());

insert into ProdutoVendido (IDVenda, IDProduto) values (2, 7);

call bloquearVenda(1, 24, 3);
call bloquearVenda(2, 24, 3);

select * from Venda;




