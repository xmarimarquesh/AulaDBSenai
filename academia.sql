create database academia;

use academia;

create table aluno(
IDAluno int not null primary key auto_increment,
nome varchar(255) not null,
dataNascimento date,
sexo varchar(10),
instituicao varchar(255),
telefone varchar(15)
);

create table professor(
IDProfessor int not null primary key auto_increment,
nome varchar(255) not null,
sobrenome varchar(255) not null,
telefone varchar(15)
);

create table aula(
IDAula int not null primary key auto_increment,
IDProfessor int,
numeroModalidade int not null,
nivelDificuldade varchar(100),
Sala varchar(100),
foreign key (IDProfessor) references professor(IDProfessor)
);

create table aulaAluno(
IDAulaAluno int not null primary key auto_increment,
IDAula int,
IDAluno int,
foreign key (IDAula) references aula(IDAula),
foreign key (IDAluno) references aluno(IDAluno)
);

