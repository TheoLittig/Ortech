drop procedure usp_login

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