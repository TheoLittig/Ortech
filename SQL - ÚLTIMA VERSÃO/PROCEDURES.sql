CREATE PROCEDURE usp_login 
    @email VARCHAR(100),
    @senha CHAR(8)
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

---------------------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE usp_cadastrarCliente
    @cpf VARCHAR(11),
    @nome VARCHAR(50),
    @telefone VARCHAR(20),
    @email VARCHAR(50)
AS
BEGIN
    IF CHARINDEX('@', @email) > 1 AND CHARINDEX('.', @email) > 1 AND
       @email LIKE '%_@__%.__%'
	BEGIN
       IF NOT EXISTS (SELECT * FROM Cliente WHERE cpf = @cpf OR email = @email)
      
          INSERT INTO Cliente (cpf, nome, telefone, email)
        VALUES (@cpf, @nome, @telefone, @email)
	 ELSE
	   SELECT 'O CPF ou EMAIL já cadastrado, não é possivel realizar o cadastro'
	  END
	ELSE
	 BEGIN
	  SELECT 'Informe um Email válido'
     END
END
