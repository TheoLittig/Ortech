---------------------------CLIENTES---------------------------------------------------------------------------------------------------------------
INSERT INTO Cliente (cpf, nome, telefone, email, data_nascimento, sexo)
VALUES ('12345678900', 'Maria da Silva', '(11) 99999-9999', 'maria.silva@gmail.com', '1990-01-01', 'F');
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
