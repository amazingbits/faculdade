SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBCORREIOS;
CREATE DATABASE DBCORREIOS;
USE DBCORREIOS;

CREATE TABLE IF NOT EXISTS USUARIO(
IDUSUARIO INT NOT NULL AUTO_INCREMENT,
NOME TEXT,
SENHA TEXT,
USUARIO_DB TEXT,
PRIMARY KEY(IDUSUARIO));

CREATE TABLE IF NOT EXISTS MENSAGEM(
IDMENSAGEM INT NOT NULL AUTO_INCREMENT,
TITULO TEXT,
MENSAGEM TEXT,
IDUSUARIO_REMETENTE INT NOT NULL,
IDUSUARIO_DESTINATARIO INT NOT NULL,
CONSTRAINT FK_REMETENTE
FOREIGN KEY(IDUSUARIO_REMETENTE) REFERENCES USUARIO(IDUSUARIO),
CONSTRAINT FK_DESTINATARIO
FOREIGN KEY(IDUSUARIO_DESTINATARIO) REFERENCES USUARIO(IDUSUARIO),
PRIMARY KEY(IDMENSAGEM));

DELIMITER $$

SET @@SESSION.max_sp_recursion_depth=25; $$

-- PROCEDURES
CREATE PROCEDURE PC_ADD_USER(IN vNOME TEXT, IN vSENHA TEXT)
BEGIN
	-- CRIANDO USUÁRIO NO BANCO
    INSERT INTO USUARIO VALUES (NULL, vNOME, vSENHA, vNOME);
    
	-- CRIANDO USUÁRIO NO SISTEMA
    SET @COMMAND = CONCAT(  "	CREATE USER ", 
								CONCAT('\'', vNOME, '\''),
                                "@'%' IDENTIFIED BY ",
                                CONCAT('\'', vSENHA, '\''));
    PREPARE EXEC FROM @COMMAND;
    EXECUTE EXEC;
    DEALLOCATE PREPARE EXEC;
    
    -- DEFININDO ACESSOS AO USUÁRIO
    SET @ACCESS = CONCAT(" 	GRANT SELECT, INSERT, UPDATE, DELETE ON DBCORREIOS.* TO ",
							CONCAT('\'', vNOME, '\''), 
                            "@'%'");
    PREPARE EXEC FROM @ACCESS;
    EXECUTE EXEC;
    DEALLOCATE PREPARE EXEC;
    FLUSH PRIVILEGES;
    
END $$

CREATE PROCEDURE PC_DELETE_USER(IN vNOME TEXT)
BEGIN
	-- DELETANDO USUÁRIO
    DELETE FROM USUARIO WHERE NOME = vNOME;
    
    -- DELETANDO USUÁRIO DO BANCO DE DADOS
    SET @DEL = CONCAT(	"DROP USER ",
                            CONCAT('\'', vNOME, '\''),
                            "@'%'");
	PREPARE EXEC FROM @DEL;
    EXECUTE EXEC;
    DEALLOCATE PREPARE EXEC;
    FLUSH PRIVILEGES;
END $$

-- TRIGGERS
CREATE TRIGGER TG_USUARIO_BI BEFORE INSERT ON USUARIO FOR EACH ROW
BEGIN 
	DECLARE vUSER INT;
    
    SET vUSER = 0;
    SELECT IDUSUARIO INTO vUSER FROM USUARIO WHERE NOME = NEW.NOME OR USUARIO_DB = NEW.USUARIO_DB LIMIT 1;
    
    IF(vUSER <> 0) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "NÃO PODEM EXISTIR USUÁRIOS COM NOMES REPETIDOS";
    END IF;
END $$

CREATE TRIGGER TG_USUARIO_BD BEFORE DELETE ON USUARIO FOR EACH ROW
BEGIN
	DELETE FROM MENSAGEM WHERE IDUSUARIO_REMETENTE = OLD.IDUSUARIO OR IDUSUARIO_DESTINATARIO = OLD.IDUSUARIO;
    CALL PC_DELETE_USER(OLD.NOME);
END $$

DELIMITER ;

-- VIEWS
CREATE VIEW VW_USER AS
SELECT *
FROM USUARIO
WHERE USUARIO_DB = (SELECT SUBSTRING_INDEX(USER(),"@",1));

CREATE VIEW VW_MSG AS
SELECT 	(SELECT NOME FROM USUARIO WHERE IDUSUARIO = MENSAGEM.IDUSUARIO_REMETENTE) AS REMETENTE,
		(SELECT NOME FROM USUARIO WHERE IDUSUARIO = MENSAGEM.IDUSUARIO_DESTINATARIO) AS DESTINATARIO,
		MENSAGEM.TITULO AS MSG,
        MENSAGEM.MENSAGEM AS TEXTO
FROM MENSAGEM
INNER JOIN USUARIO ON
(MENSAGEM.IDUSUARIO_DESTINATARIO = USUARIO.IDUSUARIO
OR MENSAGEM.IDUSUARIO_REMETENTE = USUARIO.IDUSUARIO)
WHERE USUARIO.USUARIO_DB = (SELECT SUBSTRING_INDEX(USER(),"@",1))
OR USUARIO.USUARIO_DB = (SELECT SUBSTRING_INDEX(USER(),"@",1));

CALL PC_ADD_USER("TESTE", "123");
CALL PC_ADD_USER("TESTE1", "123");
CALL PC_ADD_USER("TESTE2", "123");
CALL PC_ADD_USER("ROOT", "123");

CALL PC_DELETE_USER("TESTE2");

INSERT INTO MENSAGEM VALUES (NULL, "TITULO 1", "OLÁ, TESTE 1!", 4, 2);
INSERT INTO MENSAGEM VALUES (NULL, "TITULO 2", "OLÁ, ROOT", 2, 4);
INSERT INTO MENSAGEM VALUES (NULL, "TITULO 3", "MENSAGEMMMM ALATÓRIA", 1, 2);

SELECT * FROM VW_USER;
SELECT * FROM VW_MSG;