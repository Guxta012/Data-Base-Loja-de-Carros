-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS loja_de_carros;
USE loja_de_carros;

-- 1. Tabela CLIENTES
CREATE TABLE Clientes (
    ID_Cliente INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Sobrenome VARCHAR(100),
    CPF CHAR(14) UNIQUE NOT NULL, 
    Endereco VARCHAR(300),
    Telefone CHAR(13),
    PRIMARY KEY (ID_Cliente)
);

-- 2. Tabela VENDEDORES
CREATE TABLE Vendedores (
    ID_Vendedor INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Sobrenome VARCHAR(100),
    CPF CHAR(14) UNIQUE NOT NULL,
    Telefone CHAR(13),
    PRIMARY KEY (ID_Vendedor)
);

-- 3. Tabela CARROS
CREATE TABLE Carros (
    ID_Carros INT NOT NULL AUTO_INCREMENT,
    Modelo VARCHAR(100) NOT NULL,
    Marca VARCHAR(100) NOT NULL,
    Ano INT,
    Motor VARCHAR(10),
    Combustivel VARCHAR(30),
    Cor VARCHAR(50),
    Cambio VARCHAR(50),
    Valor DECIMAL(10,2) NOT NULL,
    Disp ENUM('Disponível', 'Vendido') DEFAULT 'Disponível',
    PRIMARY KEY (ID_Carros)
);

-- 4. Tabela VENDAS (Tabela de Relacionamento)
CREATE TABLE Vendas (
    ID_Vendas INT NOT NULL AUTO_INCREMENT,
    ID_Cli INT NOT NULL,
    ID_Vend INT NOT NULL,
    ID_Car INT UNIQUE NOT NULL, 
    Data_Venda DATE NOT NULL,
    Forma_de_Pagamento VARCHAR(50),
    Valor_Total DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (ID_Vendas),
    -- FKs com restrição RESTRICT para garantir integridade
    FOREIGN KEY (ID_Cli) REFERENCES Clientes(ID_Cliente) ON DELETE RESTRICT,
    FOREIGN KEY (ID_Vend) REFERENCES Vendedores(ID_Vendedor) ON DELETE RESTRICT,
    FOREIGN KEY (ID_Car) REFERENCES Carros(ID_Carros) ON DELETE RESTRICT
);