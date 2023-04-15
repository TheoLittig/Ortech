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
  endereco VARCHAR(100)
);
-- Criação da tabela CartaoCredito
CREATE TABLE CartaoCredito (
  numero_cartao INT PRIMARY KEY,
  cpf VARCHAR(11) NOT NULL,
  nome_titular VARCHAR(100) NOT NULL,
  data_vencimento_cartao VARCHAR(5) NOT NULL,
  cvv_cartao VARCHAR(3) NOT NULL,
  bandeira_cartao VARCHAR(50) NOT NULL,
  FOREIGN KEY (cpf) REFERENCES Cliente(cpf)
);
go
-- Criação da tabela Funcionario
CREATE TABLE Funcionario (
  id_funcionario INT IDENTITY NOT NULL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL,
  cargo VARCHAR(50) NOT NULL,
  turno VARCHAR(30) NOT NULL,
  salario DECIMAL(10, 2) NOT NULL,
  endereco VARCHAR(100) NOT NULL,
  CEP VARCHAR(10) NOT NULL,
  cpf VARCHAR(11) NOT NULL UNIQUE,
  data_nascimento DATE NOT NULL,
  sexo CHAR(1) NOT NULL,
  senha NUMERIC(8) NOT NULL,
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
  id_funcionario INT NOT NULL,
  data_pedido DATETIME NOT NULL,
  valor_total DECIMAL(10, 2) NOT NULL,
  formapagamento INT NOT NULL,
  numero_mesa INT NOT NULL,
  FOREIGN KEY (cpf) REFERENCES Cliente (cpf),
  FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id_funcionario),
  FOREIGN KEY (numero_mesa) REFERENCES Mesa (numero_mesa)
);
go
-- Criação da tabela StatusPedido
CREATE TABLE StatusPedido (
id_status INT IDENTITY PRIMARY KEY,
id_pedido INT NOT NULL FOREIGN KEY REFERENCES Pedido(id_pedido),
id_funcionario INT NOT NULL FOREIGN KEY REFERENCES(id_funcionario),
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
  nome_fornecedor VARCHAR(50) NOT NULL,
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
   comentario_avaliacao TEXT NOT NULL,
   data_avaliacao DATETIME NOT NULL,
   FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
   FOREIGN KEY (cpf) REFERENCES Cliente(cpf)
);
go
-- Criação da tabela DetalhesPedido
CREATE TABLE DetalhesPedido (
   id_detalhes_pedido INT PRIMARY KEY,
   id_pedido INT NOT NULL,
   id_produto INT NOT NULL,
   quantidade_produto INT NOT NULL,
   valor_unitario DECIMAL(10, 2) NOT NULL,
   observacoes VARCHAR(100),
   FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
   FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

