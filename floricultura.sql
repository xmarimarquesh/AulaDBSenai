create database floticultura;

use floricultura;

create table cliente(
IDCliente int not null primary key auto_increment,
RG varchar(10) not null,
nome varchar(255) not null,
telefone varchar(15),
endereco varchar(255)
);

create table compra(
IDCompra int not null primary key auto_increment,
IDCliente int,
valorTotal float,
dataVenda datetime,
foreign key (IDCliente) references cliente(IDCliente)
);

create table produtoComprado(
IDProdutoComprado int not null primary key auto_increment,
IDCompra int,
IDProduto int,
foreign key (IDCompra) references compra(IDCompra),
foreign key (IDCliente) references compra(IDCliente)
);

create table produto(
IDProduto int not null primary key auto_increment,
nome varchar(255) not null,
tipo varchar(10),
preco float,
quantidade int
);