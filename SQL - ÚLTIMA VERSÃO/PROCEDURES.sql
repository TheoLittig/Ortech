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
CREATE PROCEDURE usp_InserirPedido
    @cpf VARCHAR(11),
    @data_pedido DATE,
    @valor_total DECIMAL(10, 2),
    @formapagamento VARCHAR(100),
    @numero_mesa INT,
    @produtos AS dbo.ProdutosType READONLY
AS
BEGIN
     
	 Declare @id_pedido int;

    -- Inserir o pedido na tabela Pedido
    INSERT INTO Pedido (cpf, data_pedido, valor_total, formapagamento, numero_mesa)
    VALUES (@cpf, CONVERT(DATE,@data_pedido, 120), @valor_total, @formapagamento, @numero_mesa);

	-- Obter o ID do pedido recém-inserido
    SET @id_pedido = SCOPE_IDENTITY();

    -- Inserir os detalhes do pedido na tabela DetalhesPedido
    INSERT INTO DetalhesPedido (id_pedido, id_produto, quantidade_produto, valor_unitario, observacoes)
    SELECT @id_pedido, p.id_produto, dp.quantidade_produto, dp.valor_unitario, dp.observacoes
    FROM @produtos dp
    JOIN Produtos p ON dp.id_produto = p.id_produto;
	    --SOMA TOTAL DOS VALORES
		UPDATE Pedido
    SET valor_total = (
        SELECT SUM(d.quantidade_produto * d.valor_unitario)
        FROM DetalhesPedido d
        WHERE d.id_pedido = @id_pedido
    )
    WHERE id_pedido = @id_pedido;
	--OCUPAR A MESA
	UPDATE Mesa
     SET status_mesa = 'Ocupada'
     WHERE numero_mesa = @numero_mesa;
    -- Inserir o status do pedido na tabela StatusPedido
INSERT INTO StatusPedido (id_pedido)
VALUES (@id_pedido);
END;
-----------------------------------------------------------------------

--executar a procedure acima
DECLARE @produtos dbo.ProdutosType;

INSERT INTO @produtos (id_produto, quantidade_produto, valor_unitario, observacoes)
VALUES
    (1, 2, 10.50, 'Sem cebola'),
    (2, 1, 8.75, 'Com molho extra'),
    (3, 3, 15.00, 'Com queijo');

EXEC usp_InserirPedido
    @cpf = '12345678900',
    @data_pedido = '2023-05-19 12:34:56',
    @valor_total = 50.25,
    @formapagamento = 'Cartão de crédito',
    @numero_mesa = 3,
    @produtos = @produtos

drop procedure usp_InserirPedido
