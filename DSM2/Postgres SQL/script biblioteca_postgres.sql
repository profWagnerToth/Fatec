-- Tabelas já existentes
Create table Autores
(
	autor_id serial primary key, -- Serial é o mesmo que int auto_increment
	nome varchar (100)
);

create table livros
(
	livro_id serial primary key,
	titulo varchar(150),
	autor_id int references autores(autor_id) ON DELETE CASCADE,
	estoque int check(estoque >=0), -- Valida que o estoque não pode ser negativo
	ano_publicacao int,
	isbn varchar(13)unique -- Determina que o registro será único
);

create table Membros
(
	membro_id serial primary key,
	nome varchar(100),
	endereco varchar(100),
	email varchar(100),
	data_cadastro date default current_date
);

create table emprestimos
(
	emprestimo_id serial primary key,
	livro_id int references livros(livro_id),
	membro_id int references membros(membro_id),
	data_emprestimo date default current_date,
	data_devolucao date,
	devolvido boolean default false,
	data_prevista_devolucao date
);

create table reservas
(
	reserva_id serial primary key,
	livro_id int references livros(livro_id),
	membro_id int references membros(membro_id),
	data_reserva date default current_date
);

create table multas
(
	multa serial primary key,
	emprestimo_id int references emprestimos(emprestimo_id),
	valor numeric(5,2),
	pago Boolean default false
);

-- Procedure para calcular a multa e somar ao estoque na devolução
CREATE OR REPLACE FUNCTION gerar_multa_e_incrementar_estoque() 
RETURNS TRIGGER AS $$
BEGIN
	-- Se o livro for devolvido e houve atraso, calcular multa
	IF new.devolvido = TRUE AND new.data_devolucao > new.data_prevista_devolucao THEN
		-- Calcular valor da multa como 1.50 por dia de atraso
		INSERT INTO multas(emprestimo_id, valor) 
		VALUES (new.emprestimo_id, (new.data_devolucao - new.data_prevista_devolucao) * 1.50);
	END IF;
/*====================================================================================================*/	
	-- Após devolução, incrementar o estoque em 1
	UPDATE livros 
	SET estoque = estoque + 1 
	WHERE livro_id = new.livro_id;
/*====================================================================================================*/	
	RETURN NULL; -- Retorna NULL após executar as alterações
END;
$$ LANGUAGE plpgsql;

-- Trigger para chamar a procedure ao devolver o livro
CREATE TRIGGER trigger_gerar_multa_e_incrementar_estoque
AFTER UPDATE OF devolvido ON emprestimos
FOR EACH ROW
WHEN (new.devolvido = TRUE) -- A condição que verifica se o livro foi devolvido
EXECUTE FUNCTION gerar_multa_e_incrementar_estoque();
/*=====================================================================================================*/
-- Procedure para baixar o estoque quando o livro for emprestado
CREATE OR REPLACE FUNCTION baixar_estoque() 
RETURNS TRIGGER AS $$
BEGIN
	-- Quando o livro for emprestado, reduzir o estoque em 1
	UPDATE livros 
	SET estoque = estoque - 1 
	WHERE livro_id = new.livro_id;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para baixar o estoque ao registrar o empréstimo
CREATE TRIGGER trigger_baixar_estoque
AFTER INSERT ON emprestimos
FOR EACH ROW
EXECUTE FUNCTION baixar_estoque();
/*==========================================================================*/
-- View para listar membros com empréstimos em atraso
CREATE VIEW membros_em_atraso AS
SELECT m.membro_id, m.nome, e.data_prevista_devolucao
FROM membros m
JOIN emprestimos e ON m.membro_id = e.membro_id
WHERE e.devolvido = FALSE AND e.data_prevista_devolucao < CURRENT_DATE;

-- Índice para acelerar consultas por título de livro
CREATE INDEX idx_livros_titulo ON livros(titulo);

-- Populando o banco de dados
INSERT INTO autores(nome) VALUES
('J.K. Rowling'), ('George R.R. Martin'), ('J.R.R. Tolkien');

INSERT INTO livros(titulo, autor_id, estoque, ano_publicacao, isbn) VALUES
('Harry Potter e a Pedra Filosofal', 1, 5, 1997, '9780747532699'),
('Game of Thrones', 2, 3, 1996, '9780553103540'),
('O Senhor dos Aneis', 3, 4, 1954, '9780618640157');

INSERT INTO membros(nome, endereco, email) VALUES
('João Silva', 'Rua das Flores, 123', 'joao@email.com'),
('Maria Souza', 'Av. Brasil, 456', 'maria@email.com');

INSERT INTO emprestimos(livro_id, membro_id, data_prevista_devolucao) VALUES
(1, 1, '2024-10-08'), (2, 2, '2024-10-10');

-- Consultas para verificar o estado do banco de dados
SELECT * FROM autores;
SELECT * FROM livros;
SELECT * FROM membros;
SELECT * FROM emprestimos;
SELECT * FROM multas;

-- Atualização para simular a devolução do livro e cálculo de multa
UPDATE emprestimos 
SET data_devolucao = '2024-10-20', devolvido = TRUE 
WHERE emprestimo_id = 1;
