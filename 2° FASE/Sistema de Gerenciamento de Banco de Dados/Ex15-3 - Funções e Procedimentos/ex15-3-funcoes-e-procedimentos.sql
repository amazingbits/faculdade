/*UTILS*/
SET GLOBAL log_bin_trust_function_creators = 1;

DROP DATABASE IF EXISTS DBCONTACORRENTE;
CREATE DATABASE DBCONTACORRENTE;
USE DBCONTACORRENTE;
CREATE TABLE CLIENTE(
	IDCLIENTE INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, NOME VARCHAR(100)
	, CPF CHAR(11)
);
CREATE TABLE CONTA (
	IDCONTA INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, IDCLIENTE INT NOT NULL
	, DT_ABERTURA DATE
	, LIMITE_CREDITO NUMERIC(8,2)
	, TIPO ENUM('CONTA-CORRENTE', 'POUPANÇA')
	, FOREIGN KEY (IDCLIENTE) REFERENCES CLIENTE (IDCLIENTE)
);
CREATE TABLE MOVIMENTACAO(
	IDMOVIMENTACAO INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, IDCONTA INT NOT NULL
	, DT_MOVIMENTACAO DATE
	, VALOR NUMERIC(8,2)
	, TIPO ENUM('DEPOSITO', 'SAQUE')
	, OBSERVAÇÃO TEXT
	, FOREIGN KEY (IDCONTA) REFERENCES CONTA (IDCONTA)
);

-- INSERINDO CLIENTES
INSERT INTO CLIENTE VALUES (NULL, "PAULO OLIVEIRA", "8547852125");
INSERT INTO CLIENTE VALUES (NULL, "JULIO MARTINS", "7895896589");
INSERT INTO CLIENTE VALUES (NULL, "VOLIN RABAH", "6582563256");
INSERT INTO CLIENTE VALUES (NULL, "TOMÁS TURBANDO", "0145258958");

-- CRIANDO CONTAS PARA OS CLIENTES
INSERT INTO CONTA VALUES (NULL, 1, "2020-01-01", 200, "CONTA-CORRENTE");
INSERT INTO CONTA VALUES (NULL, 2, "2020-03-01", 0, "POUPANÇA");
INSERT INTO CONTA VALUES (NULL, 3, "2020-03-01", 0, "POUPANÇA");
INSERT INTO CONTA VALUES (NULL, 4, "2020-02-01", 200, "CONTA-CORRENTE");

-- INSERINDO MOVIMENTAÇÕES PARA TESTES
INSERT INTO MOVIMENTACAO VALUES (NULL, 1, "2020-04-01", 1050, "DEPOSITO", "SALÁRIO DO MÊS DE ABRIL");
INSERT INTO MOVIMENTACAO VALUES (NULL, 1, "2020-04-01", 800, "SAQUE", "SAQUE");
INSERT INTO MOVIMENTACAO VALUES (NULL, 2, "2020-03-01", 3000, "DEPOSITO", "DEPÓSITO PARA A VIAGEM");
INSERT INTO MOVIMENTACAO VALUES (NULL, 2, "2020-04-15", 1000, "SAQUE", "SAQUE EMERGENCIAL");
INSERT INTO MOVIMENTACAO VALUES (NULL, 3, "2020-04-01", 2550, "DEPOSITO", "DEPÓSITO BANCÁRIO");
INSERT INTO MOVIMENTACAO VALUES (NULL, 3, "2020-03-01", 1085, "SAQUE", "SAQUE");
INSERT INTO MOVIMENTACAO VALUES (NULL, 4, "2020-04-22", 2500, "DEPOSITO", "PAGAMENTO");
INSERT INTO MOVIMENTACAO VALUES (NULL, 4, "2020-03-18", 1050, "SAQUE", "SAQUE");

-- AQUI EU CRIO UMA FUNÇÃO QUE RETORNA UMA VARIÁVEL PARA QUE EU POSSA INFORMAR O ID DA CONTA QUE
-- EU QUERO O SALDO E O EXTRATO NAS MINHAS VIEWS
CREATE FUNCTION CONTA() RETURNS INT RETURN @CONTA;

-- CRIAÇÃO DA VIEW DO SALDO
CREATE VIEW VW_SALDO AS
SELECT 	CLIENTE.NOME AS CLIENTE,
		(
			SELECT SUM(VALOR) FROM MOVIMENTACAO WHERE TIPO = "DEPOSITO" AND IDCONTA = CONTA()
        )
        -
        (
			SELECT SUM(VALOR) FROM MOVIMENTACAO WHERE TIPO = "SAQUE" AND IDCONTA = CONTA()
        ) AS SALDO
FROM MOVIMENTACAO
INNER JOIN CONTA ON 
(MOVIMENTACAO.IDCONTA = CONTA.IDCONTA)
INNER JOIN CLIENTE ON
(CONTA.IDCLIENTE = CLIENTE.IDCLIENTE)
WHERE MOVIMENTACAO.IDCONTA = CONTA()
GROUP BY MOVIMENTACAO.IDCONTA;

-- ANTES DE CHAMAR A VIEW, EU DEVO ATRIBUIR O ID DELA ATRAVÉS DA FUNÇÃO QUE EU CRIEI ACIMA
-- NESTE CASO DE EXEMPLO ESTOU CHAMANDO O SALDO DA CONTA DE ID 1
/*
SET @CONTA = 1;
SELECT CLIENTE,SALDO FROM VW_SALDO;
*/

-- CRIAÇÃO DA VIEW DO EXTRATO NA MESMA LÓGICA DA VIEW DO SALDO
CREATE VIEW VW_EXTRATO AS
SELECT 	MOVIMENTACAO.IDCONTA AS CONTA,
		CLIENTE.NOME AS CLIENTE,
		CONCAT("R$ ", MOVIMENTACAO.VALOR) AS VALOR, 
        MOVIMENTACAO.TIPO, 
        MOVIMENTACAO.OBSERVAÇÃO
FROM MOVIMENTACAO 
INNER JOIN CONTA ON 
(MOVIMENTACAO.IDCONTA = CONTA.IDCONTA)
INNER JOIN CLIENTE ON
(CONTA.IDCLIENTE = CLIENTE.IDCLIENTE)
WHERE MOVIMENTACAO.IDCONTA = CONTA()
ORDER BY DT_MOVIMENTACAO;

-- PARA VER O EXTRATO DA CONTA
/*
SET @CONTA = 1;
SELECT CONTA, CLIENTE, VALOR, TIPO, OBSERVAÇÃO FROM VW_EXTRATO;
*/

DELIMITER $$

CREATE PROCEDURE PC_MOVIMENTACAO(IN vIDCONTA INT, IN vVALOR NUMERIC(8,2), IN vTIPO TEXT)
BEGIN

-- DECLARANDO VARIÁVEIS
DECLARE TIPO_CONTA TEXT;
DECLARE LIMITE NUMERIC(8,2);
DECLARE vSALDO NUMERIC(8,2);

-- PEGAR TIPO DE CONTA
SELECT TIPO INTO TIPO_CONTA FROM CONTA WHERE IDCONTA = vIDCONTA;

-- PEGAR LIMITE DA CONTA
SELECT LIMITE_CREDITO INTO LIMITE FROM CONTA WHERE IDCONTA = vIDCONTA;

-- PEGAR SALDO
SET @CONTA = vIDCONTA;
SELECT SALDO INTO vSALDO FROM VW_SALDO;

IF(vTIPO = "DEPOSITO") THEN
	
    -- DEPÓSITO NA CONTA
	INSERT INTO MOVIMENTACAO VALUES (NULL, vIDCONTA, NOW(), vVALOR, "DEPOSITO", CONCAT("DEPOSITO DE R$ ", vVALOR));

ELSE

	IF(LIMITE = 0) THEN
		
        -- CONTA POUPANÇA
        IF((vSALDO - vVALOR) < 0) THEN
			SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "OPERAÇÃO INVÁLIDA! SALDO INSUFICIENTE.";
		END IF;
        
        INSERT INTO MOVIMENTACAO VALUES (NULL, vIDCONTA, NOW(), vVALOR, "SAQUE", CONCAT("SAQUE DE R$ ", vvALOR));
	ELSE 
    
		-- CONTA CORRENTE
        IF((vSALDO - vVALOR) < (LIMITE - (LIMITE * 2))) THEN
			SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "OPERAÇÃO INVÁLIDA! SALDO INSUFICIENTE.";
        END IF;
        
        INSERT INTO MOVIMENTACAO VALUES (NULL, vIDCONTA, NOW(), vVALOR, "SAQUE", CONCAT("SAQUE DE R$ ", vVALOR));
    
    END IF;

END IF;

END $$

-- TRANSFERENCIA
CREATE PROCEDURE PC_TRANSFERENCIA(IN vORIGEM INT, IN vDESTINO INT, IN vVALOR NUMERIC(8,2))
BEGIN

	-- DECLARAÇÃO DE VARIÁVEIS
    DECLARE vTIPO_ORIGEM TEXT;
    DECLARE vTIPO_DESTINO TEXT;
    DECLARE vLIMITE_ORIGEM NUMERIC(8,2);
    DECLARE vLIMITE_DESTINO NUMERIC(8,2);
    DECLARE vSALDO_ORIGEM NUMERIC(8,2);
    DECLARE vSALDO_DESTINO NUMERIC(8,2);
    
    -- PRIMEIRO TRATAMENTO DE ERROS SE AS CONTAS FOREM IGUAIS
    IF(vORIGEM = vDESTINO) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "AS CONTAS INFORMADAS SÃO IGUAIS. OPERAÇÃO INVÁLIDA!";
    END IF;
    
    -- PEGANDO O TIPO DA CONTA ORIGEM
    SELECT TIPO INTO vTIPO_ORIGEM FROM CONTA WHERE IDCONTA = vORIGEM;
    
    -- PEGANDO O TIPO DA CONTA DESTINO
    SELECT TIPO INTO vTIPO_DESTINO FROM CONTA WHERE IDCONTA = vDESTINO;
    
    -- PEGANDO LIMITE DA CONTA ORIGEM
    SELECT LIMITE_CREDITO INTO vLIMITE_ORIGEM FROM CONTA WHERE IDCONTA = vORIGEM;
    
    -- PEGANDO LIMITE DA CONTA DESTINO
    SELECT LIMITE_CREDITO INTO vLIMITE_DESTINO FROM CONTA WHERE IDCONTA = vDESTINO;
    
    -- PEGANDO SALDO DA CONTA ORIGEM
    SET @CONTA = vORIGEM;
    SELECT SALDO INTO vSALDO_ORIGEM FROM VW_SALDO;
    
    -- PEGANDO SALDO DA CONTA DESTINO
    SET @CONTA = vDESTINO;
    SELECT SALDO INTO vSALDO_DESTINO FROM VW_SALDO;
    
    -- VALIDAÇÕES CONTA ORIGEM
    IF(vTIPO_ORIGEM = "POUPANÇA") THEN
		
        IF((vSALDO_ORIGEM - vVALOR) < 0) THEN
			SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "OPERAÇÃO INVÁLIDA! SALDO DA CONTA ORIGEM INSUFICIENTE.";
		END IF;
        
    ELSE
		
         IF((vSALDO_ORIGEM - vVALOR) < (vLIMITE_ORIGEM - (vLIMITE_ORIGEM * 2))) THEN
			SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "OPERAÇÃO INVÁLIDA! SALDO DA CONTA ORIGEM INSUFICIENTE.";
        END IF;
        
    END IF;
    
    -- APLICANDO A TRANSFERÊNCIA
    INSERT INTO MOVIMENTACAO VALUES (NULL, vORIGEM, NOW(), vVALOR, "SAQUE", CONCAT("TRANSFERÊNCIA DE R$ ", vVALOR, " DESTA CONTA (", vORIGEM,") PARA A CONTA ", vDESTINO));
	INSERT INTO MOVIMENTACAO VALUES (NULL, vDESTINO, NOW(), vVALOR, "DEPOSITO", CONCAT("TRANSFERÊNCIA DE R$ ", vVALOR, " DA CONTA (", vORIGEM,") PARA ESTA CONTA (", vDESTINO, ")"));

END $$

DELIMITER ;

-- ############## TESTES #############

-- FAZENDO DEPÓSITO DE R$ 500,00 PARA A CONTA 1
/*
CALL PC_MOVIMENTACAO(1, 500.00, "DEPOSITO");
*/

-- FAZENDO SAQUE DE R$ 450,55 DA CONTA 1
/*
CALL PC_MOVIMENTACAO(1,450.55, "SAQUE");
*/

-- FAZENDO UMA TRANSFERÊNCIA DE R$ 200,00 DA CONTA 1 PARA A CONTA 2
/*
CALL PC_TRANSFERENCIA(1,2,200);
*/

-- VERIFICANDO SALDO DA CONTA 1
/*
SET @CONTA = 1;
SELECT SALDO FROM VW_SALDO;
*/

-- VERIFICANDO SALDO DA CONTA 2
/*
SET @CONTA = 2;
SELECT SALDO FROM VW_SALDO;
*/

-- EXTRATO DA CONTA 1
/*
SET @CONTA = 1;
SELECT CONTA, CLIENTE, VALOR, TIPO, OBSERVAÇÃO FROM VW_EXTRATO;
*/

-- EXTRATO DA CONTA 2
/*
SET @CONTA = 2;
SELECT CONTA, CLIENTE, VALOR, TIPO, OBSERVAÇÃO FROM VW_EXTRATO;
*/