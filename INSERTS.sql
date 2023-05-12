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
