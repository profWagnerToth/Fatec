create database gatilho;
use gatilho;

create table Produtos
(
codProd int auto_increment primary key,
descricao varchar(50),
estoque int not null default 0
);

insert into produtos (descricao, estoque) values 
("Feijão", 10),
("Arroz", 5),
("Farinha", 15);

select * from produtos;

create table itensVenda
(
iditem int auto_increment primary key,
numVenda int,
produto int,
quantidade int,
constraint fk_quantidade foreign key(produto) references produtos(codProd)
);

select * from itensVenda;

/* Execução após criação das trigger */
insert into itensvenda (numVenda, produto,quantidade) values (1,1,3), (1,2,1), (1,3,5);
delete from itensvenda where numvenda=1 and produto = 1;



/* Criação das Triggers */ 
Delimiter $
Create trigger tgr_ItensVenda_Insert after insert
on itensVenda
for each row
begin
	update produtos set estoque = estoque - new.quantidade
    Where codprod = new.produto;    
end$


Create trigger tgr_ItensVenda_Delete after delete
on itensVenda
for each row
begin	
	update produtos set estoque = estoque + old.quantidade
    Where codprod = old.produto;
end$

delimiter $;