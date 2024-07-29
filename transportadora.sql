create database transportes;

use transportes;

create table armazem(
IDArmazem int not null primary key auto_increment,
nome varchar(255) not null,
endereco varchar(255)
);

create table loja(
IDLoja int not null primary key auto_increment,
nome varchar(255) not null,
endereco varchar(255)
);

create table caminhao(
IDCaminhao int not null primary key auto_increment,
numeroViagem int,
capacidade float
);

create table encomenda(
IDEncomenda int not null primary key auto_increment,
IDArmazem int,
IDCaminhao int,
dataEncomenda date,
peso float,
destino varchar(255),
foreign key (IDArmazem) references armazem(IDArmazem),
foreign key (IDCaminhao) references caminhao(IDCaminhao)
);

create table entrega(
IDEntrega int not null primary key auto_increment,
IDLoja int,
IDCaminhao int,
dataEntrega datetime,
foreign key (IDDLoja) references loja(IDLoja),
foreign key (IDCaminhao) references caminhao(IDCaminhao)
);