drop database hot_rolls_club
use master

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'hot_rolls_club')
    DROP DATABASE hot_rolls_club
go
CREATE DATABASE hot_rolls_club
go
USE hot_rolls_club
go
-- Criação da tabela Cliente
CREATE TABLE Cliente (
  cpf VARCHAR(11) NOT NULL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL,
  data_nascimento DATE,
  sexo CHAR(1)
);
go
-- Criação da tabela Funcionario
CREATE TABLE Funcionario (
  id_funcionario INT IDENTITY NOT NULL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  cargo VARCHAR(50) NOT NULL,
  turno VARCHAR(30) NOT NULL,
  salario DECIMAL(10, 2) NOT NULL,
  endereco VARCHAR(100) NOT NULL,
  CEP VARCHAR(10) NOT NULL,
  cpf VARCHAR(11) NOT NULL UNIQUE,
  data_nascimento DATE NOT NULL,
  sexo CHAR(1) NOT NULL,
  senha VARCHAR(8) NOT NULL,
  data_contratacao DATE NOT NULL
);
go
-- Criação da tabela Mesa
CREATE TABLE Mesa (
numero_mesa INT PRIMARY KEY,
status_mesa VARCHAR(15) not null default 'Disponível',
capacidade_mesa INT NOT NULL
);
go
-- Criação da tabela Pedido
CREATE TABLE Pedido (
  id_pedido INT IDENTITY NOT NULL PRIMARY KEY,
  cpf VARCHAR(11) NOT NULL,
  data_pedido DATETIME NOT NULL,
  valor_total DECIMAL(10, 2) NOT NULL,
  formapagamento VARCHAR(100) NOT NULL,
  numero_mesa INT NOT NULL,
  FOREIGN KEY (cpf) REFERENCES Cliente (cpf),
  FOREIGN KEY (numero_mesa) REFERENCES Mesa (numero_mesa)
);
go
-- Criação da tabela StatusPedido
CREATE TABLE StatusPedido (
id_status INT IDENTITY PRIMARY KEY,
id_pedido INT NOT NULL FOREIGN KEY REFERENCES Pedido(id_pedido),
id_funcionario INT NOT NULL FOREIGN KEY REFERENCES Funcionario(id_funcionario),
status_pedido VARCHAR(50) NOT NULL default 'Em Preparo'
);
go
-- Criação da tabela CategoriaProduto
CREATE TABLE CategoriaProduto (
  id_categoriaprod INT IDENTITY NOT NULL PRIMARY KEY,
  nome_categoria VARCHAR(50) NOT NULL,
  descricao VARCHAR(200) NOT NULL
);
go
-- Criação da tabela Produtos
CREATE TABLE Produtos (
  id_produto INT IDENTITY NOT NULL PRIMARY KEY,
  nome_produto VARCHAR(50) NOT NULL,
  descricao VARCHAR(200) NOT NULL,
  id_categoriaprod INT NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  unidade_medida VARCHAR(10) NOT NULL
  FOREIGN KEY (id_categoriaprod) REFERENCES CategoriaProduto (id_categoriaprod)
);
go
-- Criação da tabela Fornecedor
CREATE TABLE Fornecedor (
  id_fornecedor INT IDENTITY NOT NULL PRIMARY KEY,
  nome_fornecedor VARCHAR(100) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL,
  endereco VARCHAR(100) NOT NULL
);
go
-- Criação da tabela Insumos
CREATE TABLE Insumos (
  id_insumo INT IDENTITY NOT NULL PRIMARY KEY,
  nome_insumo VARCHAR(50) NOT NULL,
  descricao VARCHAR(200) NOT NULL,
  id_fornecedor INT NOT NULL,
  quantidade_insumo NUMERIC(10,2) NOT NULL,
  unidade_medida VARCHAR(20),
  data_entrada DATETIME NOT NULL,
  data_validade DATETIME NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);
go
-- Criação da tabela InsumosProduto
CREATE TABLE InsumosProduto (
  id_produto INT NOT NULL,
  id_insumo INT NOT NULL,
  quantidade_insumo NUMERIC(10,2) NOT NULL,
  unidade_medida VARCHAR(20),
  PRIMARY KEY (id_produto, id_insumo),
  FOREIGN KEY (id_produto) REFERENCES Produtos (id_produto),
  FOREIGN KEY (id_insumo) REFERENCES Insumos (id_insumo)
);
go
-- Criação da tabela Reserva
CREATE TABLE Reserva (
   id_reserva INT IDENTITY PRIMARY KEY,
   cpf VARCHAR(11) NOT NULL,
   numero_mesa INT NOT NULL,  
   data_reserva DATETIME NOT NULL,
   FOREIGN KEY (cpf) REFERENCES Cliente(cpf),
   FOREIGN KEY (numero_mesa) REFERENCES Mesa(numero_mesa)
);
go
-- Criação da tabela Avaliação
CREATE TABLE Avaliacao (
   id_avaliacao INT IDENTITY PRIMARY KEY,
   cpf VARCHAR(11) NOT NULL,
   id_produto INT NOT NULL,
   estrelas INT NOT NULL,
   comentario_avaliacao VARCHAR(255),
   data_avaliacao DATETIME NOT NULL,
   FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
   FOREIGN KEY (cpf) REFERENCES Cliente(cpf)
);
go
-- Criação da tabela DetalhesPedido
CREATE TABLE DetalhesPedido (
   id_detalhes_pedido INT IDENTITY PRIMARY KEY,
   id_pedido INT NOT NULL,
   id_produto INT NOT NULL,
   quantidade_produto INT NOT NULL,
   valor_unitario DECIMAL(10, 2) NOT NULL,
   observacoes VARCHAR(100),
   FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
   FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);
go
-------CLIENTES--------------------------
INSERT INTO Cliente (cpf, nome, telefone, email, data_nascimento, sexo)
VALUES ('12345678900', 'Maria da Silva', '(11) 99999-9999', 'maria.silva@gmail.com', '1990-01-01', 'F');
go
--------FUNCIONARIOS---------------------
INSERT INTO Funcionario (nome, telefone, email, cargo, turno, salario, endereco, CEP, cpf, data_nascimento, sexo, senha, data_contratacao)
VALUES ('João Souza', '(11) 98888-8888', 'joao.souza@gmail.com', 'Atendente', 'Noturno', 2000.00, 'Rua A, 123', '01000-000', '11122233344', '1995-05-10', 'M', '12345678', '2022-01-01');
go
---------MESAS-----------------------------
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (1, 4);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (2, 6);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (3, 2);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (4, 8);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (5, 4);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (6, 2);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (7, 6);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (8, 4);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (9, 2);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (10, 6);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (11, 4);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (12, 2);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (13, 8);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (14, 4);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (15, 2);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (16, 6);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (17, 4);
go
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES (18, 2);
go
-----------------FORNECEDORES------------------------
INSERT INTO Fornecedor (nome_fornecedor, telefone, email, endereco)
VALUES ('Fornecedor A', '(11) 1111-1111', 'fornecedora@teste.com', 'Rua A, 123');
go
INSERT INTO Fornecedor (nome_fornecedor, telefone, email, endereco)
VALUES ('Fornecedor B', '(22) 2222-2222', 'fornecedorb@teste.com', 'Rua B, 456');
-------------------------------------------------------


CREATE PROCEDURE usp_login 
    @email varchar(100),
    @senha varchar(8)
AS
BEGIN
    IF CHARINDEX('@', @email) > 1 AND CHARINDEX('.', @email) > 1 AND
       @email LIKE '%_@__%.__%'
    BEGIN
        IF (SELECT COUNT(*) FROM Funcionario WHERE email = @email AND senha = @senha) = 1
            SELECT 'Login aceito' AS result
        ELSE
            SELECT 'Login recusado' AS result
    END
    ELSE
    BEGIN
        SELECT 'Email inválido' AS result
    END
END

exec usp_login "joao", 12345678
exec usp_login "joao.souza@gmail.com", 12345678

