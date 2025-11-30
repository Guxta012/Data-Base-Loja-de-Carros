-- #######################################################################
-- # A. Comandos INSERT (Povoamento Inicial)
-- #######################################################################

-- INSERTS: CLIENTES (5 exemplos)
INSERT INTO Clientes (Nome, Sobrenome, CPF, Endereco, Telefone) VALUES
('Ana', 'Souza', '111.111.111-11', 'Rua A, 100', '1199991111'),      -- ID 1
('Bruno', 'Ferreira', '222.222.222-22', 'Av. B, 200', '1199992222'),    -- ID 2
('Carla', 'Oliveira', '333.333.333-33', 'Rua C, 300', '1199993333'),    -- ID 3
('Daniel', 'Santos', '444.444.444-44', 'Av. D, 400', '1199994444'),    -- ID 4
('Eloisa', 'Gomes', '555.555.555-55', 'Rua E, 500', '1199995555');    -- ID 5 (Não usada em Vendas)

-- INSERTS: VENDEDORES (3 exemplos)
INSERT INTO Vendedores (Nome, Sobrenome, CPF, Telefone) VALUES
('Felipe', 'Almeida', '666.666.666-66', '1188886666'),  -- ID 1
('Giovana', 'Rocha', '777.777.777-77', '1188887777'), -- ID 2
('Hugo', 'Lima', '888.888.888-88', '1188888888');    -- ID 3

-- INSERTS: CARROS (7 exemplos)
INSERT INTO Carros (Modelo, Marca, Ano, Valor, Disp) VALUES
('Onix', 'Chevrolet', 2022, 65000.00, 'Vendido'),      -- ID 1
('Corolla', 'Toyota', 2023, 135000.00, 'Vendido'),    -- ID 2
('Tiguan', 'Volkswagen', 2021, 160000.00, 'Vendido'), -- ID 3
('Kwid', 'Renault', 2024, 55000.00, 'Vendido'),       -- ID 4
('HB20', 'Hyundai', 2023, 72000.00, 'Disponível'),    -- ID 5
('Renegade', 'Jeep', 2022, 110000.00, 'Disponível'),   -- ID 6 (Não usada em Vendas)
('BMW X1', 'BMW', 2020, 210000.00, 'Disponível');     -- ID 7 (Não usada em Vendas)

-- INSERTS: VENDAS (4 exemplos - Referenciam IDs 1 a 4 de Clientes e Carros)
INSERT INTO Vendas (ID_Cli, ID_Vend, ID_Car, Data_Venda, Forma_de_Pagamento, Valor_Total) VALUES
(1, 1, 1, '2025-11-01', 'À Vista', 65000.00), 
(2, 2, 2, '2025-11-05', 'Financiamento', 135000.00), 
(3, 1, 3, '2025-11-10', 'À Vista', 160000.00), 
(4, 3, 4, '2025-11-15', 'Financiamento', 55000.00); 

-- #######################################################################
-- # B. Comandos SELECT (Consultas)
-- #######################################################################

-- SELECT 1: Listar todas as vendas, mostrando Cliente, Vendedor e Carro (JOIN)
SELECT
    V.ID_Vendas,
    C.Nome AS Cliente,
    Vend.Nome AS Vendedor,
    Ca.Marca,
    Ca.Modelo,
    V.Valor_Total
FROM Vendas V
JOIN Clientes C ON V.ID_Cli = C.ID_Cliente
JOIN Vendedores Vend ON V.ID_Vend = Vend.ID_Vendedor
JOIN Carros Ca ON V.ID_Car = Ca.ID_Carros
ORDER BY V.Data_Venda DESC;

-- SELECT 2: Buscar carros disponíveis com valor acima de R$ 100.000,00 (WHERE, ORDER BY)
SELECT
    Modelo,
    Marca,
    Ano,
    Valor
FROM Carros
WHERE Disp = 'Disponível' AND Valor > 100000.00
ORDER BY Valor DESC;

-- SELECT 3: Contar o número total de vendas por vendedor (JOIN, GROUP BY, COUNT)
SELECT
    Vendedores.Nome,
    COUNT(Vendas.ID_Vendas) AS Total_Vendas
FROM Vendedores
LEFT JOIN Vendas ON Vendedores.ID_Vendedor = Vendas.ID_Vend
GROUP BY Vendedores.Nome
ORDER BY Total_Vendas DESC;

-- #######################################################################
-- # C. Comandos UPDATE (3 exemplos com condições)
-- #######################################################################

-- UPDATE 1: Atualizar o telefone de um cliente específico (Exemplo: Daniel)
UPDATE Clientes
SET Telefone = '1199994440'
WHERE Nome = 'Daniel' AND CPF = '444.444.444-44';

-- UPDATE 2: Corrigir o valor final de uma venda (Exemplo: Corolla teve desconto)
UPDATE Vendas
SET Valor_Total = 130000.00
WHERE ID_Vendas = 2;

-- UPDATE 3: Mudar o status de um carro que estava à venda, mas foi temporariamente retirado (HB20)
UPDATE Carros
SET Disp = 'Retirado'
WHERE ID_Carros = 5 AND Disp = 'Disponível';


-- #######################################################################
-- # D. Comandos DELETE (3 exemplos com condições - Ajustados para não violar RESTRICT)
-- #######################################################################

-- DELETE 1: Deletar um cliente que NÃO está associado a nenhuma venda (Eloisa - ID 5)
DELETE FROM Clientes
WHERE ID_Cliente = 5;

-- DELETE 2: Deletar um carro que nunca foi vendido e está disponível (Renegade - ID 6)
DELETE FROM Carros
WHERE ID_Carros = 6 AND Disp = 'Disponível';

-- DELETE 3: Deletar outro carro que está disponível (BMW X1 - ID 7)
DELETE FROM Carros
WHERE ID_Carros = 7 AND Disp = 'Disponível';