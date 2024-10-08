-- Criando banco de dados no protgres
create database primeiro_postgres;

-- Criando tabela tipoProdutos
create table tipoProdutos
(
codigo serial primary key, --Serial é o mesmo que int auto_incremente
descricao varchar(100) not null
);

-- Criando tabela produtos
create table produtos
(
codigo serial primary key,
descricao varchar(100) not null,
preco money not null,
id_tipo_produto int references tipoProdutos(codigo) -- Criação de Foreign Key
);

/* Inserindo dados na tabela tipoProdutos, lembre-se que todo dado inserido na tabela que for 
texto inserir utilizando aspas simples '' e não aspas duplas "" .*/
INSERT INTO tipoProdutos (descricao) VALUES 
('computadores'),
('impressoras');

-- Lista todos os registros
select * from tipoProdutos;

insert into produtos (descricao, preco, id_tipo_produto) values
('Desktop', 1200.00, 1),('Laptop', 3200.00, 1),
('Impressora Jato de Tinta', 500.00, 2),
('Impressora Laser', 1200.00, 2);

--Lista todos os registros em ordem crescente por produtos
select * from produtos order by descricao;

--Lista todos os registros em ordem decrescente por preco
select * from produtos order by preco desc;

--Lista todos os registros pertencentes a um mesmo tipo de produto
select * from produtos where id_tipo_Produto = 2;

--Lista todos os registros pertencentes ao tipo computadores
select produtos.codigo as "Código",produtos.descricao as "Produto",produtos.preco as "Preço", 
tipoProdutos.descricao as "Tipo" from produtos
join tipoProdutos on produtos.id_tipo_produto = tipoProdutos.codigo 
where tipoProdutos.descricao='computadores';

-- Lista todos os registros da tabela produtos mostrando a descrição do tipo de produto 
select produtos.codigo as "Código",produtos.descricao as "Produto",produtos.preco as "Preço", 
tipoProdutos.descricao as "Tipo" from produtos
join tipoProdutos on produtos.id_tipo_produto = tipoProdutos.codigo;

-- Retorne o valor total de produtos de cada tipo de produto
SELECT tipoProdutos.descricao AS "Tipo", SUM(produtos.preco) AS "Total" FROM produtos
JOIN tipoProdutos ON produtos.id_tipo_produto = tipoProdutos.codigo
GROUP BY tipoProdutos.descricao;





