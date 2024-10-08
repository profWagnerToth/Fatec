create database bd_fatec;
use bd_fATEC;

create table alunos
(
idAluno int auto_increment primary key,
nome varchar(100),
cpf varchar(14)
);

insert into alunos (nome,cpf)values
("Pedro","123.456.789-01"),
("Lucas","111.222.333-44"),
("Barbara","222.333.444-55");

# Seleção de todos os registros da tabela
select * from alunos;

/* Seleção de todos os registro mostrando apenas
alguns campos criado na tabela. */
select idAluno,nome from alunos;
select idAluno,cpf from alunos;
select nome,cpf from alunos;
select cpf,nome from alunos;
select cpf,nome,idAluno from alunos;

#Seleção de Registro especifico
select * from alunos where idAluno=2;
select * from alunos;

#Atualizando Dados em tabela
update alunos set cpf="111.222.333-04" where idAluno=2;
update alunos set cpf="567.897.321-01";

#Adicionar campos na tabela
alter table alunos add column rg varchar(13);
select * from alunos;

alter table alunos add column tel varchar(14);
select * from alunos;

#Troca nome da coluna na tabela
alter table alunos change tel celular varchar(14);
select * from alunos;

#excluir coluna da tabela
alter table alunos drop column rg;
select * from alunos;

#Apelidos de Campos
select * from alunos;
select idAluno as ID, nome as "Nome do Aluno",
 cpf as CPF, celular as Telefone from alunos;
 
#Apelido de Tabela

select a.nome, a.cpf from alunos a;

create table disciplinas
(
idDisc int auto_increment primary Key,
nomeDisc varchar(100)
);

insert into disciplinas (nomeDisc) values
("Banco de Dados Relacional"),
("Desenvolvimento Web II"),
("Design Digital");

create table matricula
(
idMatricula int auto_increment primary key,
aluno int,
disciplina int,
#Criar Chave Estrangeira
constraint fk_aluno_disciplina foreign key (aluno) references alunos(idAluno),
foreign key(disciplina) references disciplinas(idDisc)
);

insert into matricula (aluno,disciplina) values
(1,1),
(1,2),
(1,3),
(2,1),
(2,3),
(3,1);

select * from matricula;

select aluno, disciplina from matricula where aluno=1;

insert into matricula (aluno,disciplina) values
(4,5),
(4,1);

#Relacionamento entre tabelas usando INNER JOIN
Select a.nome as "Nome do Aluno", d.nomeDisc as "Disciplina" from matricula
inner join alunos a on matricula.aluno = a.idAluno
inner join disciplinas d on matricula.disciplina = d.idDisc where matricula.Aluno=2;