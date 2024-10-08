#Criação de banco de dados caso não exista
create database if not exists emptech;
#apontar o banco para o uso
use emptech;
#Criação de tabelas
create table if not exists funcionarios
(
codFunc int auto_increment primary key,
nomeFunc varchar(255)not null
);

create table if not exists veiculos
(
codVeic int auto_increment primary key,
modelo varchar(255) not null,
placas varchar(20) not null,
codFunc int
);

#inserindo dados nas tabelas
insert into funcionarios(nomeFunc) values
('João Silva'), ('Maria Oliveira'), ('Pedro Santos'),
('Ana Costa'),('Lucas Almeida'),('Fernana Lima');

insert into veiculos (Modelo, Placas, codFunc) values
('Fiat Uno','ABC1D23',1),('Honda Civic','XYZ2E34',1),
('Toyota Corolla','LMN3F45',2),('Chevrolet Onix','OPQ4g56',3),
('VW Gol','UVW6I78',5),('Peugeot 208','YZA7j89',null);

#Inner Join
select funcionarios.nomeFunc as Nome, veiculos.modelo from veiculos
join funcionarios on veiculos.codFunc = funcionarios.codFunc;

#Equi Join
select f.nomeFunc as Nome, v.modelo from veiculos v 
join funcionarios f using (codFunc);

#Left Join
/*Retorna todos os campos do lado esquerdo do Join que se relaciona
com o lado direito do join, mais os os registros que não relacionam
com o lado direito e que sejam do lado esquerdo. */

select f.nomeFunc as Nome, v.modelo from veiculos v
left join funcionarios f using (codFunc);

#Rigth Join
/*Retorna todos os campos do lado direito do Join que se relaciona
com o lado esquerdo do join, mais os os registros que não relacionam
com o lado esquerdo e que sejam do lado direito. */

select f.nomeFunc as Nome, v.modelo from veiculos v
right join funcionarios f using (codFunc);

#full join
/*O Full Join não funciona para mySQL, porem uma solução para
obeter o resultado de uma tabela contendo, dados que se relacionam
ou não do lado esquerdo com o lado direito do join, mais os dados que 
se relacionam ou não do lado direito com o lado esquerdo do join, é
necessário que seja feito as query Left Join e Rigth Join, porem 
utilizando o UNION para unir as 02 querys para realizar a 
pesquisa.*/

select f.nomeFunc as Nome, v.modelo from veiculos v
left join funcionarios f using (codFunc)
union
select f.nomeFunc as Nome, v.modelo from veiculos v
right join funcionarios f using (codFunc);

/* View - Estrutura de seleção que encapsula querys complexas para 
simplificar o uso ao usuario e facilitar as chamadas em aplicações
externas. */

create view func_Veic as
select f.nomeFunc as Nome, v.modelo from veiculos v
left join funcionarios f using (codFunc)
union
select f.nomeFunc as Nome, v.modelo from veiculos v
right join funcionarios f using (codFunc);

#chamando view
select * from func_veic;

create table atuacaoVendas
(
codAtuacao int auto_increment primary key,
descricao varchar(255) not null
);

insert into atuacaoVendas (descricao) values
('Vendas de Veiculos Novos'), ('Vendas de Veiculos Usados'),
('Manutenção e reparo de veiculos'),('Serviços de Pós-Vendas'),
('Consultoria de Vendas'),('Programações e eventos especiais');

#Cross Join
/*Este join ira criar relatorio onde irá fazer todas as combinações
possíveis entre as tabelas.
Ex.: Se cruzarmos as Tabelas Funcionario, Veiculos e AtuacaoVendas
onde teremos Tabela Funcionarios com 6 Registros, Tabela Veiculos
com 7 registros e Tabela AutuacaoVendas com 6 Registros, iremos um 
resultado de combinação 6 x 7 x 6 que totalizará 252 cobinações.
*/

select f.codFunc, f.nomeFunc, v.Modelo, v.Placas, a.descricao
from funcionarios f
cross join veiculos v
cross join atuacaoVendas a;

create table indicacoes
(
codIndicador int,
codIndicado int,
primary Key (codIndicador,CodIndicado),
foreign key (codIndicador) references Funcionarios(codFunc),
foreign key (codIndicado) references Funcionarios(codFunc)
);

insert into indicacoes (codIndicador,codIndicado) values
(1,2),(1,3),(2,4),(2,5),(4,6);

#Self Join
/*Gera um resultado de relacionamento de dados de uma tabela com ela 
mesma, ou seja, um auto-relacionamento. */

select i1.codIndicador as 'ID Indicador', f1.nomeFunc as 'Nome Indicador',
i1.codIndicado as 'ID Indicado', f2.nomeFunc as 'Nome Indicado' from indicacoes i1
join funcionarios f1 on i1.codIndicador = f1.codFunc
join funcionarios f2 on i1.codIndicado = f2.codFunc;
