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
  sexo CHAR(1),
  senha VARCHAR(MAX) NOT NULL,
  img_cliente VARBINARY(MAX)
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
id_pedido INT NOT NULL,
id_funcionario INT NOT NULL,
status_pedido VARCHAR(50) NOT NULL default 'Em Preparo'
FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario)
);
go
-- Criação da tabela CategoriaProduto
CREATE TABLE CategoriaProduto (
  id_categoriaprod INT IDENTITY NOT NULL PRIMARY KEY,
  nome_categoria VARCHAR(50) NOT NULL,
  descricao VARCHAR(200)
);
go
-- Criação da tabela Produtos
CREATE TABLE Produtos (
  id_produto INT IDENTITY NOT NULL PRIMARY KEY,
  nome_produto VARCHAR(50) NOT NULL,
  descricao VARCHAR(200) NOT NULL,
  id_categoriaprod INT NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  unidade_medida VARCHAR(10) NOT NULL,
  img_prato VARBINARY(MAX),
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
  estoque NUMERIC(10,2) NOT NULL,
  unidade_medida VARCHAR(20),
  data_entrada DATE NOT NULL,
  data_validade DATE NOT NULL,
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
---------------------------CLIENTES---------------------------------------------------------------------------------------------------------------
INSERT INTO Cliente (cpf, nome, telefone, email, data_nascimento, sexo, senha)
VALUES ('12345678900', 'Maria da Silva', '(11) 99999-9999', 'maria.silva@gmail.com', '1990-01-01', 'F', '12345678');
go
---------------------------FUNCIONARIOS-------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Funcionario (nome, telefone, email, cargo, turno, salario, endereco, CEP, cpf, data_nascimento, sexo, senha, data_contratacao)
VALUES ('João Souza', '(11) 98888-8888', 'joao.souza@gmail.com', 'Atendente', 'Noturno', 2000.00, 'Rua A, 123', '01000-000', '11122233344', '1995-05-10', 'M', '12345678', '2022-01-01');
go
-----------------------------MESAS-----------------------------------------------------------------------------------------
INSERT INTO Mesa (numero_mesa, capacidade_mesa) VALUES 
(1, 4),(2, 6),(3, 2),(4, 8),(5, 4),(6, 2),
(7, 6),(8, 4),(9, 2),(10, 6),(11, 4),(12, 2),
(13, 8),(14, 4),(15, 2),(16, 6),(17, 4),(18, 2)
go
--------------------------FORNECEDORES--------------------------------------------------------------------------------------
INSERT INTO Fornecedor (nome_fornecedor, telefone, email, endereco)
VALUES ('Fornecedor A', '(11) 1111-1111', 'fornecedora@teste.com', 'Rua A, 123');
go
INSERT INTO Fornecedor (nome_fornecedor, telefone, email, endereco)
VALUES ('Fornecedor B', '(22) 2222-2222', 'fornecedorb@teste.com', 'Rua B, 456');
go
-----------------------CATEGORIAS PRODUTOS----------------------------------------------------------------------------------
INSERT INTO CategoriaProduto (nome_categoria, descricao)
VALUES
('Sushi', 'Pequenos rolos de arroz com recheios variados, envolvidos em algas marinhas'),
('Sashimi', 'Fatias finas de peixe ou frutos do mar crus, servidos com molhos especiais'),
('Tempurá', 'Pedacinhos de legumes, frutos do mar ou carne empanados e fritos'),
('Yakissoba', 'Macarrão frito com legumes, carne e molho especial'),
('Temaki', 'Cone de alga recheado com arroz, peixe e vegetais.'),
('Nigiri', 'Bolinhas de arroz com um pedaço de peixe, fruto do mar ou ovo em cima.'),
('Robata', 'Espetinhos de carne, frutos do mar ou legumes grelhados em carvão vegetal'),
('Bebidas', 'Acompanhamento')
-------------------------------Produtos---------------------------------------------------------------------------------------
--1
INSERT INTO Produtos (nome_produto, descricao, id_categoriaprod, preco, unidade_medida)
VALUES ('Hot Roll', 'Sushi roll recheado com salmão, cream cheese, pepino', 1, 12.99, '8 unidades');
go
--2
INSERT INTO Produtos (nome_produto, descricao, id_categoriaprod, preco, unidade_medida)
VALUES ('Temaki', 'Enrolado de alga recheado com arroz, peixe, legumes e molho especial', 5, 21.99, 'unidade');
go
--3
INSERT INTO Produtos (nome_produto, descricao, id_categoriaprod, preco, unidade_medida)
VALUES ('Robata', 'Espetinho grelhado com diversos tipos de carnes e legumes', 7, 14.99, 'unidade');
go
--4
INSERT INTO Produtos (nome_produto, descricao, id_categoriaprod, preco, unidade_medida)
VALUES ('Yakisoba Tradicional', 'Macarrão frito com legumes, carne ou frango e molho especial', 2, 24.99, 'unidade');
-------------------------------Insumos----------------------------------------------------------------------------------------
--1
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Arroz', 'Arroz japonês', 1, 10000, 'gramas', '2023-02-01', '2023-06-30');
go
--2
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Alga Nori', 'Alga seca para enrolar o sushi', 2, 500, 'folhas', '2023-02-01', '2023-12-31');
go
--3
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Salmão', 'Salmão fresco para sushi', 2, 5000, 'gramas', '2023-02-01', '2023-06-15');
go
--4
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Pepino', 'Pepino fresco para sushi', 1, 5000, 'unidade', '2023-02-01', '2023-06-20');
go
--5
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Cenoura', 'Cenoura fresca para sushi', 2, 5000, 'unidade', '2023-02-01', '2023-06-25');
go
--6
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Camarão', 'Camarão fresco para sushi', 1, 5000, 'gramas', '2023-02-01', '2023-06-22');
go
--7
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Macarrão', 'Macarrão para yakisoba', 1, 5000, 'gramas', '2023-02-01', '2023-06-30');
go
--8
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Carne de Porco', 'Carne de porco para yakisoba', 2, 3000, 'gramas', GETDATE(), '2023-06-15');
go
--9 
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Repolho', 'Repolho picado para yakisoba', 2, 2000, 'gramas', '2023-02-01', '2023-06-20');
go
--10
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Brócolis', 'Brócolis para yakisoba', 1, 1000, 'unidade', '2023-02-01', '2023-06-22');
go
--11
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Frango', 'Pedacinhos de frango para robata', 2, 3000, 'gramas', GETDATE(), '2023-06-15');
go
--12
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Carne', 'Pedacinhos de carne bovina para robata', 1, 3000, 'gramas', GETDATE(), '2023-06-15');
go
--13
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Palitos de Bambu', 'Palitos de bambu para espetinhos', 2, 5000, 'unidades', GETDATE(), '2023-12-31');
go
--14
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Cebola', 'Cebola', 1, 5000, 'unidade', GETDATE(), '2023-06-25');
go
--15
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Pimentão', 'Pimentão cortado', 1, 1000, 'unidade', GETDATE(), '2023-06-18');
go
--16
INSERT INTO Insumos (nome_insumo, descricao, id_fornecedor, estoque, unidade_medida, data_entrada, data_validade)
VALUES ('Cream Cheese', 'Cream cheese', 2, 5000, 'gramas', GETDATE(), '2023-12-31');

-----------------------------------------Insumos Produtos------------------------------------------------------------------
-------FAZER HOT ROLL---------
INSERT INTO InsumosProduto (id_produto, id_insumo, quantidade_insumo, unidade_medida)
VALUES
    -- Arroz para Sushi
    (1, 1, 50, 'gramas'),
    -- Nori (Alga Marinha)
    (1, 2, 1, 'folha'),
    -- Salmão
    (1, 3, 50, 'gramas'),
    -- Cream Cheese
    (1, 16, 20, 'gramas'),
    -- Pepino
    (1, 4, 1, 'unidade')
go
-------FAZER YAKISOBA------------
INSERT INTO InsumosProduto (id_produto, id_insumo, quantidade_insumo, unidade_medida)
VALUES
    -- Insumo: Macarrão para Yakisoba
    (4, 7, 150, 'gramas'),
    -- Insumo: Carne (ex: Carne Bovina)
    (4, 12, 100, 'gramas'),
    -- Insumo: Cebola
    (4, 14, 1, 'unidade'),
    -- Insumo: Pimentão
    (4, 15, 1, 'unidade'),
    -- Insumo: Repolho
    (4, 9, 100, 'gramas'),
    -- Insumo: Cenoura
    (4, 5, 1, 'unidade')
go
------FAZER ROBATA---------------
INSERT INTO InsumosProduto (id_produto, id_insumo, quantidade_insumo, unidade_medida)
VALUES
    -- Insumo: Frango
    (3, 11, 100, 'gramas'),
    -- Insumo: Carne 
    (3, 12, 100, 'gramas'),
    -- Insumo: Legumes (Cebola, Pimentão)
    (3, 15, 1, 'unidade'),
    (3, 14, 1, 'unidade'),
    -- Insumo: Palitos de Bambu
    (3, 13, 1, 'unidades');
go
----FAZER TEMAKI------------
INSERT INTO InsumosProduto (id_produto, id_insumo, quantidade_insumo, unidade_medida)
VALUES
    -- Insumo: Alga Nori
    (2, 2, 1, 'folha'),
    -- Insumo: Arroz para Sushi
    (2, 1, 80, 'gramas'),
    -- Insumo: Peixe (ex: Salmão)
    (2, 3, 80, 'gramas'),
    -- Insumo: Cream Cheese
    (2, 16, 20, 'gramas'),
    -- Insumo: Pepino
    (2, 4, 2, 'unidade')
---------------------------------------------------------------------------------------------------------------------------
drop procedure usp_loginFunc

CREATE PROCEDURE usp_loginFunc
    @email varchar(100),
    @senha varchar(8)
AS
BEGIN
    IF CHARINDEX('@', @email) > 1 AND CHARINDEX('.', @email) > 1 AND
       @email LIKE '%_@__%.__%' AND (LEN(@senha) = 8)
    BEGIN
        IF (SELECT COUNT(*) FROM Funcionario WHERE email = @email AND senha = @senha) = 1
            SELECT 'Login aceito'
        ELSE
            SELECT 'Login recusado'
    END
    ELSE
    BEGIN
        SELECT 'Email inválido'
    END
END

exec usp_loginFunc "joao", 12345678
exec usp_loginFunc "joao.souza@gmail.com", 12345678
--------------------------------------------------------------------------------------------------
drop procedure usp_loginCliente

CREATE PROCEDURE usp_loginCliente
    @email varchar(100),
    @senha varchar(MAX)
AS
BEGIN
    IF CHARINDEX('@', @email) > 1 AND CHARINDEX('.', @email) > 1 AND
       @email LIKE '%_@__%.__%' AND (LEN(@senha) >= 8)
    BEGIN
        IF (SELECT COUNT(*) FROM Cliente WHERE email = @email AND senha = @senha) = 1
            SELECT 'Login aceito'
        ELSE
            SELECT 'Login recusado'
    END
    ELSE
    BEGIN
        SELECT 'Email ou senha inválidos'
    END
END

exec usp_loginCliente 'Fulano@gmail.com', '23456474'

---------------------------------------------------------------------------------------------------
drop procedure usp_cadastrarCliente

CREATE PROCEDURE usp_cadastrarCliente
    @cpf VARCHAR(11),
    @nome VARCHAR(50),
    @telefone VARCHAR(20),
    @email VARCHAR(50),
	@senha VARCHAR(MAX)
AS
BEGIN
    IF CHARINDEX('@', @email) > 1 AND CHARINDEX('.', @email) > 1 AND
       @email LIKE '%_@__%.__%' AND (LEN(@senha) >= 8)
	BEGIN
       IF NOT EXISTS (SELECT * FROM Cliente WHERE cpf = @cpf OR email = @email)
          INSERT INTO Cliente (cpf, nome, telefone, email, senha)
        VALUES (@cpf, @nome, @telefone, @email, @senha)
	 ELSE
	   SELECT 'O CPF ou EMAIL já cadastrado, não é possivel realizar o cadastro'
	  END
	ELSE
	 BEGIN
	  SELECT 'Informe um Email ou uma senha válida'
     END
END

EXEC usp_cadastrarCliente '12345678901', 'Fulano de Tal', '(11) 1234-5678', 'Fulano@gmail.com', '23456474'
EXEC usp_cadastrarCliente '12345678901', 'Fulano de Tal', '(11) 1234-5678', 'maria.silva@gmail.com', '3456'

---------------------------------------------------------------------------------------------------
drop procedure usp_fazer_reserva

CREATE PROCEDURE usp_fazer_reserva
    @cpf VARCHAR(11),
    @numero_mesa INT,
    @data_reserva DATETIME
AS
BEGIN
     IF EXISTS (SELECT 1 FROM Cliente WHERE cpf = @cpf)
	  BEGIN
       IF EXISTS (SELECT 1 FROM Mesa WHERE numero_mesa = @numero_mesa AND status_mesa = 'Disponível')
        BEGIN
         INSERT INTO Reserva (cpf, numero_mesa, data_reserva)
          VALUES (@cpf, @numero_mesa, @data_reserva)
          UPDATE Mesa
          SET status_mesa = 'Reservado'
          WHERE numero_mesa = @numero_mesa

          SELECT 'Reserva realizada com sucesso!'
       END
    ELSE
        SELECT 'A mesa selecionada não está disponível.'
    END
	  ELSE
	    BEGIN
	      SELECT 'CPF não cadastrado ou incorreto'
    END
 END

exec usp_fazer_reserva '12345678900', 2, '1900-01-01 10:00'
-------------------------------------------------------------------------------------------------------------
drop procedure usp_cancelar_reserva

CREATE PROCEDURE usp_cancelar_reserva
    @cpf VARCHAR(11),
	@numero_mesa INT,
    @data_reserva DATETIME
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Reserva WHERE cpf = @cpf AND numero_mesa = @numero_mesa AND data_reserva = @data_reserva)
    BEGIN
        DELETE FROM Reserva
        WHERE numero_mesa = @numero_mesa AND data_reserva = @data_reserva;

        UPDATE Mesa
        SET status_mesa = 'Disponível'
        WHERE numero_mesa = @numero_mesa;

        PRINT 'Reserva cancelada!';

    END
    ELSE
    BEGIN
        PRINT 'Não foi possível cancelar a reserva. Verifique se os dados informados estão corretos.';
    END
END

exec usp_cancelar_reserva '12345678900', 1, '1900-01-01 10:00:00'
-------------------------------------------------------------------------------------------------------------
drop procedure ReceberPedido
CREATE PROCEDURE ReceberPedido
    @cpf VARCHAR(11),
    @data_pedido VARCHAR(19),
    @valor_total DECIMAL(10, 2),
    @formapagamento VARCHAR(100),
    @numero_mesa INT,
    @id_produto INT,
    @quantidade_produto INT,
    @valor_unitario DECIMAL(10, 2),
    @observacoes VARCHAR(100)
AS
BEGIN
     DECLARE @data_pedido_convertida DATETIME
    SET @data_pedido_convertida = CONVERT(DATETIME, @data_pedido, 120)

    -- Inserir o pedido na tabela Pedido
    INSERT INTO Pedido (cpf, data_pedido, valor_total, formapagamento, numero_mesa)
    VALUES (@cpf, @data_pedido_convertida, @valor_total, @formapagamento, @numero_mesa)

    -- Inserir os detalhes do pedido na tabela DetalhesPedido
    INSERT INTO DetalhesPedido (id_pedido, id_produto, quantidade_produto, valor_unitario, observacoes)
    VALUES (SCOPE_IDENTITY(), @id_produto, @quantidade_produto, @valor_unitario, @observacoes)
END

EXEC ReceberPedido '12345678900', '2023-05-19 12:34:56', 25.97, 'Cartão de crédito', 1, 1, 2, 10.99, 'Sem cebola'
---------------------------------------------------------------------------------------------------------

/*
select * from Pedido
select * from DetalhesPedido
select * from InsumosProduto
select * from Insumos
select * from Cliente
select * from Funcionario
select * from StatusPedido
select * from Mesa
select * from Fornecedor
select * from Avaliacao
select * from Reserva
select * from CategoriaProduto
*/
