create database PoliciaMilitar;

use PoliciaMilitar;

create table soldado(
IDSoldado int not null primary key auto_increment,
nome varchar(255),
registroMilitar varchar(20),
dataNascimento date
);

create table limpeza(
IDLimpeza int not null primary key auto_increment,
IDSoldado int,
IDArma int,
dataLimpeza date,
foreign key (IDSoldado) references soldado(IDSoldado),
foreign key (IDArma) references soldado(IDArma)
);

create table arma(
IDArma int not null primary key auto_increment,
IDSoldado int,
numeroSerie int,
tipo varchar(255),
calibre varchar(255),
foreign key (IDSoldado) references soldado(IDSoldado)
);

create table armaMunicao(
IDArmaMunicao int not null primary key auto_increment,
IDArma int,
IDProduto int,
foreign key (IDArma) references arma(IDArma),
foreign key (IDMunicao) references municao(IDMunicao)
);

create table municao(
IDMunicao int not null primary key auto_increment,
nome varchar(255),
calibre varchar(255),
tipo varchar(255)
);