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
     IF EXISTS (SELECT 1 FROM Mesa WHERE numero_mesa = @numero_mesa AND status_mesa = 'Disponível')
    BEGIN
        INSERT INTO Reserva (cpf, numero_mesa, data_reserva)
        VALUES (@cpf, @numero_mesa, @data_reserva);

        UPDATE Mesa
        SET status_mesa = 'Reservado'
        WHERE numero_mesa = @numero_mesa;

        PRINT 'Reserva realizada com sucesso!';

    END
    ELSE
    BEGIN
        PRINT 'A mesa selecionada não está disponível.';
    END
END
