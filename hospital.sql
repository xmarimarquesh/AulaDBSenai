create database hospital;

use horpital;

create table paciente(
IDPaciente int not null primary key auto_increment,
nome varchar(255) not null,
endereco varchar(255),
idade int,
codigoRegistro varchar(15)
);

create table medico(
IDMedico int not null primary key auto_increment,
nome varchar(255) not null,
CRM varchar(30),
especialidade varchar(30)
);

create table consulta(
IDConsulta int not null primary key auto_increment,
IDMedico int,
IDPaciente int,
dataConsulta date,
foreign key (IDMedico) references medico(IDMedico),
foreign key (IDPaciente) references paciente(IDPaciente)
);

create table receita(
IDReceita int not null primary key auto_increment,
IDConsulta int,
foreign key (IDConsulta) references consulta(IDConsulta)
);

create table medicamento(
IDMedicamento int not null primary key auto_increment,
nome varchar(255) not null,
descricao varchar(255) not null
);

create table exame(
IDExame int not null primary key auto_increment,
nome varchar(255) not null,
descricao varchar(255) not null
);

create table receitaExame(
IDReceitaExame int not null primary key auto_increment,
IDReceita int,
IDExame int,
foreign key (IDReceita) references receita(IDReceita),
foreign key (IDExame) references exame(IDExame)
);

create table receitaMedicamento(
IDReceitaExame int not null primary key auto_increment,
IDReceita int,
IDMedicamento int,
foreign key (IDReceita) references receita(IDReceita),
foreign key (IDMedicamento) references medicamento(IDMedicamento)
);



