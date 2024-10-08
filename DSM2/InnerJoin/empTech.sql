-- Criação do banco de dados EmpTech
CREATE DATABASE IF NOT EXISTS EmpTech;
USE EmpTech;

-- Criação da tabela Funcionarios
CREATE TABLE Funcionarios (
    codFunc INT AUTO_INCREMENT PRIMARY KEY,
    nome_Func VARCHAR(255) NOT NULL
);

-- Criação da tabela Veiculos
CREATE TABLE Veiculos (
    codVeic INT AUTO_INCREMENT PRIMARY KEY,
    Modelo VARCHAR(255) NOT NULL,
    Placas VARCHAR(20) NOT NULL,
    cod_Func INT
);

Inserindo Dados
-- Inserção de dados na tabela Funcionarios
INSERT INTO Funcionarios (nome_Func) VALUES
('João Silva'),
('Maria Oliveira'),
('Pedro Santos'),
('Ana Costa'),
('Lucas Almeida'),
('Fernanda Lima');

-- Inserção de dados na tabela Veiculos com placas no padrão MERCOSUL
INSERT INTO Veiculos (Modelo, Placas, cod_Func) VALUES
('Fiat Uno', 'ABC1D23', 1), -- Veículo para João Silva
('Honda Civic', 'XYZ2E34', 1), -- Veículo para João Silva
('Toyota Corolla', 'LMN3F45', 2), -- Veículo para Maria Oliveira
('Chevrolet Onix', 'OPQ4G56', 3), -- Veículo para Pedro Santos
('Ford Focus', 'RST5H67', 4), -- Veículo para Ana Costa
('Volkswagen Gol', 'UVW6I78', 5), -- Veículo para Lucas Almeida
('Peugeot 208', 'YZA7J89', NULL); -- Veículo sem atribuição

1. **INNER JOIN**
O `INNER JOIN` retorna apenas as linhas que têm correspondência em ambas as tabelas.

 
Explicação:  Este query retorna todos os funcionários que têm um veículo. Só aparecem os registros onde o `codFunc` na tabela `Funcionarios` corresponde ao `cod_Func` na tabela `Veiculos`.



 2. **LEFT JOIN (ou LEFT OUTER JOIN)**

O `LEFT JOIN` retorna todas as linhas da tabela à esquerda e as linhas correspondentes da tabela à direita. Se não houver correspondência, os resultados da tabela à direita são `NULL`.
 

Explicação:  Este query retorna todos os funcionários, incluindo aqueles que não possuem veículos. Para funcionários sem veículos, os campos da tabela `Veiculos` serão `NULL`.

3. **RIGHT JOIN (ou RIGHT OUTER JOIN)**

O `RIGHT JOIN` retorna todas as linhas da tabela à direita e as linhas correspondentes da tabela à esquerda. Se não houver correspondência, os resultados da tabela à esquerda são `NULL`.
 
Explicação: Este query retorna todos os veículos, incluindo aqueles que não têm um funcionário atribuído. Para veículos sem um funcionário atribuído, os campos da tabela `Funcionarios` serão `NULL`.


 4. **FULL JOIN (ou FULL OUTER JOIN)**

O `FULL JOIN` retorna todas as linhas quando há uma correspondência em uma das tabelas. No MySQL, o `FULL JOIN` não é suportado diretamente, mas pode ser simulado usando `UNION`.

 
Explicação: Este query retorna todos os registros de ambas as tabelas. Se uma linha não tiver correspondência na outra tabela, os campos da tabela sem correspondência serão `NULL`.

### 5. **CROSS JOIN**

Criação da Tabela `AtuacaoVendas

 


Inserção de Dados na Tabela `AtuacaoVendas

Vamos adicionar alguns registros para a tabela `AtuacaoVendas`.
 
Exemplo de `CROSS JOIN` com a Tabela `AtuacaoVendas

 
Explicação: Este query retornará todas as combinações possíveis entre funcionários, veículos e atuações de vendas. Se houver 6 funcionários, 7 veículos e 6 atuações de vendas, o resultado terá 252 linhas (6 x 7 x 6).









Criação da Tabela `Indicacoes`

A tabela `Indicacoes` vai ter dois campos principais: `codIndicador` e `codIndicado`, que representam o código do funcionário que fez a indicação e o código do funcionário que foi indicado.

 
Inserção de Dados na Tabela `Indicacoes`
 
Neste exemplo:
Exemplo de `SELF JOIN` na Tabela `Indicacoes`**
 
Explicação: Este query retorna todas as indicações feitas, mostrando o código e o nome do funcionário que fez a indicação e o código e o nome do funcionário que foi indicado.
