create database db_senai;

use db_senai;

show databases;

show tables;

drop table professor;

drop table aluno;

create table aluno(
IDAluno int not null primary key auto_increment,
nome varchar(255) not null,
sobrenome varchar(255) not null
)default charset utf8;

create table turma(
IDTurma int not null primary key auto_increment,
IDAluno int,
IDProfessor int,
foreign key (IDAluno) references aluno(IDAluno),
foreign key (IDProfessor) references professor(IDProfessor)
)default charset utf8;

create table professor(
IDProfessor int not null primary key auto_increment,
nome varchar(255) not null,
sobrenome varchar(255) not null
)default charset utf8;

select * from turma;
