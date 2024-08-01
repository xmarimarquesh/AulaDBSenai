use oficina;

show tables;

insert into cliente values (1, "João Silva", "123456789", "Rua A, 123, Cidade X"), 
(2, "Maria Oliveira", "987654321", "Av. B, 456, Cidade Y"), 
(3, "Carlos Santos", "456123789", "Rua C, 789, Cidade Z");

insert into veiculo values (1, 1, "Ford", "Fiesta", 2018, "ABC-1234"),
(2, 1, "Chevrolet", "Onix", 2020, "DEF-5678"),
(3, 2, "Volkswagen", "Gol", 2019, "GHI-9101"),
(4, 3, "Toyota", "Corolla", 2021, "JKL-1122");

insert into servico values (1, "Troca de óleo", 150.00),
(2, "Troca de pneus", 300.00),
(3, "Revisão periódica", 200.00),
(4, "Reparo elétrico", 180.00);

insert into ordem values (1, 1, 1, "2024-07-15", "2024-07-16", "Concluída", "Troca de óleo e filtro"),
(2, 2, 3, "2024-07-20", "2024-07-22", "Em andamento", "Troca de pneus"),
(3, 1, 2, "2024-07-25", "2024-07-27", "Em andamento", "Revisão periódica e alinhamento"),
(4, 3, 3, "2024-07-28", "2024-07-30", "Concluída", "Reparo elétrico no painel");

insert into itemservico values (1, 1, 1, "5 litros"),
(2, 3, 2, "4 pneus"),
(3, 2, 3, "1 revisão"),
(4, 4, 4, "2 horas" );

alter table itemservico modify Quantidade varchar(254);

select * from cliente;
select * from veiculo;
select * from ordem;
select * from itemservico;