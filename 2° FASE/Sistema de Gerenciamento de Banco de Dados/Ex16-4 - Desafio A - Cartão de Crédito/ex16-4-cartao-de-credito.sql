/*UTILS*/
SET GLOBAL log_bin_trust_function_creators = 1;

DROP DATABASE IF EXISTS DBCARTAOCREDITO;
CREATE DATABASE DBCARTAOCREDITO;
USE DBCARTAOCREDITO;

CREATE TABLE CLIENTE (
	IDCLIENTE INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(100) NOT NULL,
	CPF CHAR(11) NOT NULL,
	RG VARCHAR(16),
	LOGRADOURO VARCHAR(100),
	NUMERO VARCHAR(10),
	BAIRRO VARCHAR(100),
	CIDADE VARCHAR(100),
	UF CHAR(2),
	COMPLEMENTO VARCHAR(100),
	DT_NASCIMENTO DATE,
	TELEFONE_RESIDENCIAL VARCHAR(15),
	TELEFONE_COMERCIAL VARCHAR(15),
	TELEFONE_RECADO VARCHAR(15)
);

CREATE TABLE CARTAO (
	IDCARTAO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	IDCLIENTE INT NOT NULL,
	NUMERO CHAR(17) /*NOT NULL*/,
	DIA_VENCIMENTO INT NOT NULL,
	LIMITE NUMERIC(8,2),
	CONSTRAINT FK_CARTAO_CLIENTE FOREIGN KEY (IDCLIENTE) REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE DEBITO (
	IDDEBITO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	IDCARTAO INT NOT NULL,
	DESCRICAO VARCHAR(255) NOT NULL,
	PARCELA INT,
	VALOR NUMERIC(8,2) NOT NULL, 
	DT_DEBITO DATETIME,
	CONSTRAINT FK_DEBITO_CARTAO FOREIGN KEY (IDCARTAO) REFERENCES CARTAO(IDCARTAO)
);

CREATE TABLE BOLETO (
	IDBOLETO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	IDCARTAO INT NOT NULL,
	DT_GERACAO DATE NOT NULL,
	DT_VENCIMENTO DATE NOT NULL,
	VALOR_TOTAL NUMERIC(8,2) NOT NULL, 
	DT_PAGAMENTO DATE,
	VALOR_PAGO NUMERIC(8,2), 
	CONSTRAINT FK_BOLETO_CLIENTE FOREIGN KEY (IDCARTAO) REFERENCES CARTAO(IDCARTAO)
);


CREATE TABLE ITEM_BOLETO (
	IDITEM_BOLETO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	IDBOLETO INT NOT NULL,
	IDDEBITO INT NOT NULL,
	CONSTRAINT FK_ITEM_BOLETO_BOLETO FOREIGN KEY (IDBOLETO) REFERENCES BOLETO(IDBOLETO),
	CONSTRAINT FK_ITEM_BOLETO_DEBITO FOREIGN KEY (IDDEBITO) REFERENCES DEBITO(IDDEBITO)
);

DELIMITER $$

-- FUNÇÃO PARA VALIDAR CPF DO CLIENTE
CREATE FUNCTION FN_VALIDAR_CPF (CPF CHAR(11)) RETURNS DOUBLE
BEGIN
	
    -- DECLARACAO DE VARIAVEIS
    DECLARE DIGITO1 INT;
    DECLARE DIGITO2 INT;
    DECLARE INDICE INT;
    DECLARE CONTADOR INT;
    DECLARE SOMA DOUBLE;
    DECLARE RESULTADO BOOLEAN;
    
    -- PRIMEIRA VALIDAÇÃO BÁSICA - CPF PRECISA TER 11 DÍGITOS
    IF (LENGTH(CPF) <> 11) THEN
		SET RESULTADO = FALSE;
        RETURN RESULTADO;
    END IF;
    
    -- SEGUNDA VALIDAÇÃO BÁSICA - CPFS INVÁLIDOS CONHECIDOS
    IF (CPF = '11111111111' OR
		CPF = '22222222222' OR
        CPF = '33333333333' OR
        CPF = '44444444444' OR
        CPF = '55555555555' OR
        CPF = '66666666666' OR
        CPF = '77777777777' OR
        CPF = '88888888888' OR
        CPF = '99999999999') THEN
        
        SET RESULTADO = FALSE;
        RETURN RESULTADO;
        
	END IF;
    
    -- DEFININDO OS DOIS ÚLTIMOS DÍGITOS DO CPF
    SET DIGITO1 = SUBSTR(CPF,LENGTH(CPF)-1,1);
    SET DIGITO2 = SUBSTR(CPF,LENGTH(CPF),1);
    
    -- VALIDAÇÃO DO PRIMEIRO DÍGITO
    SET INDICE = 10;
    SET CONTADOR = 1;
    SET SOMA = 0;
    WHILE INDICE >= 2 DO
        SET SOMA = SOMA + SUBSTR(CPF,CONTADOR,1) * INDICE;
        SET INDICE = INDICE - 1;
        SET CONTADOR = CONTADOR + 1;
    END WHILE;

    IF( (SOMA * 10) % 11 <> DIGITO1 AND (SOMA * 10) % 11 <> 10) THEN
		SET RESULTADO = FALSE;
        RETURN RESULTADO;
    END IF;
    
    -- VALIDAÇÃO DO SEGUNDO DÍGITO
    SET INDICE = 11;
    SET CONTADOR = 1;
    SET SOMA = 0;
    WHILE INDICE >= 2 DO
		SET SOMA = SOMA + SUBSTR(CPF,CONTADOR,1) * INDICE;
        SET INDICE = INDICE - 1;
        SET CONTADOR = CONTADOR + 1;
    END WHILE;
    
    IF((SOMA * 10) % 11 <> DIGITO2) THEN
		SET RESULTADO = FALSE;
        RETURN RESULTADO;
    END IF;
    
    SET RESULTADO = TRUE;
    RETURN RESULTADO;
    
END $$

-- FUNÇÃO PARA RETORNAR NÚMERO POR EXTENSO (0 A 5999)
CREATE FUNCTION FN_EXTENSO(N NUMERIC(8,2)) RETURNS TEXT
BEGIN
    DECLARE EXTENSO TEXT;
    SET EXTENSO = "";
    
    IF(N < 0 OR N > 6000) THEN
		RETURN "NÚMERO INVÁLIDO!";
    END IF;
    
    IF(N <= 5000 AND N >= 5999) THEN
		SET EXTENSO = CONCAT(EXTENSO, "CINCO MIL");
        SET N = N - 5000;
    END IF;
    IF(N <= 4000 AND N >= 4999) THEN
		SET EXTENSO = CONCAT(EXTENSO, "QUATRO MIL");
        SET N = N - 4000;
    END IF;
    IF(N <= 3000 AND N >= 3999) THEN
		SET EXTENSO = CONCAT(EXTENSO, "TRÊS MIL");
        SET N = N - 3000;
    END IF;
    IF(N <= 2000 AND N >= 2999) THEN
		SET EXTENSO = CONCAT(EXTENSO, "DOIS MIL");
        SET N = N - 2000;
    END IF;
    IF(N <= 1000 AND N >= 1999) THEN
		SET EXTENSO = CONCAT(EXTENSO, "MIL");
        SET N = N - 1000;
    END IF;
    
    IF(N <= 999 AND N >= 900) THEN
		SET EXTENSO = CONCAT(EXTENSO, "NOVECENTOS");
        SET N = N - 900;
    END IF;
    IF(N >= 800 AND N < 900) THEN
		SET EXTENSO = CONCAT(EXTENSO, "OITOCENTOS");
        SET N = N - 800;
    END IF;
    IF(N >= 700 AND N < 800) THEN
		SET EXTENSO = CONCAT(EXTENSO, "SETECENTOS");
        SET N = N - 700;
    END IF;
    IF(N >= 600 AND N < 700) THEN
		SET EXTENSO = CONCAT(EXTENSO, "SEISCENTOS");
        SET N = N - 600;
    END IF;
    IF(N >= 500 AND N < 600) THEN
		SET EXTENSO = CONCAT(EXTENSO, "QUINHENTOS");
        SET N = N - 500;
    END IF;
    IF(N >= 400 AND N < 500) THEN
		SET EXTENSO = CONCAT(EXTENSO, "QUATROCENTOS");
        SET N = N - 400;
    END IF;
    IF(N >= 300 AND N < 400) THEN
		SET EXTENSO = CONCAT(EXTENSO, "TREZENTOS");
        SET N = N - 300;
    END IF;
    IF(N >= 200 AND N < 300) THEN
		SET EXTENSO = CONCAT(EXTENSO, "DUZENTOS");
        SET N = N - 200;
    END IF;
    IF(N > 100 AND N < 200) THEN
		SET EXTENSO = CONCAT(EXTENSO, "CENTO");
        SET N = N - 100;
    END IF;
    IF(N = 100) THEN
		SET EXTENSO = CONCAT(EXTENSO, "CEM");
        SET N = N - 100;
    END IF;
    
    IF(N >= 90 AND N <= 99.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "NOVENTA");
        SET N = N - 90;
    END IF;
    IF(N >= 80 AND N <= 89.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "OITENTA");
        SET N = N - 80;
    END IF;
    IF(N >= 70 AND N <= 79.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "SETENTA");
        SET N = N - 70;
    END IF;
    IF(N >= 60 AND N <= 69.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "SESSENTA");
        SET N = N - 60;
    END IF;
    IF(N >= 50 AND N <= 59.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "CINQUENTA");
        SET N = N - 50;
    END IF;
    IF(N >= 40 AND N <= 49.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "QUARENTA");
        SET N = N - 40;
    END IF;
    IF(N >= 30 AND N <= 39.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "TRINTA");
        SET N = N - 30;
    END IF;
    IF(N >= 20 AND N <= 29.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "VINTE");
        SET N = N - 20;
    END IF;
    
    IF(N >= 19 AND N <= 19.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "DEZENOVE");
        SET N = N - 19;
    END IF;
    IF(N >= 18 AND N <= 18.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "DEZOITO");
        SET N = N - 18;
    END IF;
    IF(N >= 17 AND N <= 17.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "DEZESSETE");
        SET N = N - 17;
    END IF;
    IF(N >= 16 AND N <= 16.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "DEZESSEIS");
        SET N = N - 16;
    END IF;
    IF(N >= 15 AND N <= 15.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "QUINZE");
        SET N = N - 15;
    END IF;
    IF(N >= 14 AND N <= 14.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "QUATORZE");
        SET N = N - 14;
    END IF;
    IF(N >= 13 AND N <= 13.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "TREZE");
        SET N = N - 13;
    END IF;
    IF(N >= 12 AND N <= 12.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "DOZE");
        SET N = N - 12;
    END IF;
    IF(N >= 11 AND N <= 11.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "ONZE");
        SET N = N - 11;
    END IF;
    IF(N >= 10 AND N <= 10.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "DEZ");
        SET N = N - 10;
    END IF;
    IF(N >= 9 AND N <= 9.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "NOVE");
        SET N = N - 9;
    END IF;
    IF(N >= 8 AND N <= 8.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "OITO");
        SET N = N - 8;
    END IF;
    IF(N >= 7 AND N <= 7.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "SETE");
        SET N = N - 7;
    END IF;
    IF(N >= 6 AND N <= 6.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "SEIS");
        SET N = N - 6;
    END IF;
    IF(N >= 5 AND N <= 5.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "CINCO");
        SET N = N - 5;
    END IF;
    IF(N >= 4 AND N <= 4.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "QUATRO");
        SET N = N - 4;
    END IF;
    IF(N >= 3 AND N <= 3.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "TRÊS");
        SET N = N - 3;
    END IF;
    IF(N >= 2 AND N <= 2.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "DOIS");
        SET N = N - 2;
    END IF;
    IF(N >= 1 AND N <= 1.99) THEN
		IF(EXTENSO <> "") THEN
			SET EXTENSO = CONCAT(EXTENSO, " E ");
        END IF;
		SET EXTENSO = CONCAT(EXTENSO, "UM");
        SET N = N - 1;
    END IF;
    
    -- NÚMEROS QUEBRADOS
    IF(N < 1 AND N > 0) THEN
		
        IF(N >= 0.9 AND N <= 0.99 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA NOVENTA");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E NOVENTA");
            END IF;
            SET N = N - 0.9;
        END IF;
         IF(N >= 0.8 AND N <= 0.89 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA OITENTA");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E OITENTA");
            END IF;
            SET N = N - 0.8;
        END IF;
         IF(N >= 0.7 AND N <= 0.79 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA SETENTA");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E SETENTA");
            END IF;
            SET N = N - 0.7;
        END IF;
         IF(N >= 0.6 AND N <= 0.69 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA SESSENTA");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E SESSENTA");
            END IF;
            SET N = N - 0.6;
        END IF;
         IF(N >= 0.5 AND N <= 0.59 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA CINQUENTA");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E CINQUENTA");
            END IF;
            SET N = N - 0.5;
        END IF;
         IF(N >= 0.4 AND N <= 0.49 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA QUARENTA");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E QUARENTA");
            END IF;
            SET N = N - 0.4;
        END IF;
         IF(N >= 0.3 AND N <= 0.39 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA TRINTA");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E TRINTA");
            END IF;
            SET N = N - 0.3;
        END IF;
         IF(N >= 0.2 AND N <= 0.29 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA VINTE");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E VINTE");
            END IF;
            SET N = N - 0.2;
        END IF;
		IF(N = 0.19 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA DEZENOVE");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E DEZENOVE");
            END IF;
            SET N = N - 0.19;
        END IF;
        IF(N = 0.18 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA DEZOITO");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E DEZOITO");
            END IF;
            SET N = N - 0.18;
        END IF;
        IF(N = 0.17 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA DEZESSETE");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E DEZESSETE");
            END IF;
            SET N = N - 0.17;
        END IF;
        IF(N = 0.16 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA DEZESSEIS");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E DEZESSEIS");
            END IF;
            SET N = N - 0.16;
        END IF;
        IF(N = 0.15 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA QUINZE");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E QUINZE");
            END IF;
            SET N = N - 0.15;
        END IF;
        IF(N = 0.14 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA QUATORZE");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E QUATORZE");
            END IF;
            SET N = N - 0.14;
        END IF;
        IF(N = 0.13 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA TREZE");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E TREZE");
            END IF;
            SET N = N - 0.13;
        END IF;
        IF(N = 0.12 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA DOZE");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E DOZE");
            END IF;
            SET N = N - 0.12;
        END IF;
        IF(N = 0.11 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA ONZE");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E ONZE");
            END IF;
            SET N = N - 0.11;
        END IF;
        IF(N = 0.10 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA DEZ");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " E DEZ");
            END IF;
            SET N = N - 0.1;
        END IF;
        IF(N = 0.09 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA ZERO NOVE");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " VÍRGULA ZERO NOVE");
            END IF;
            SET N = N - 0.09;
        END IF;
        IF(N = 0.08 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA ZERO OITO");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " VÍRGULA ZERO OITO");
            END IF;
            SET N = N - 0.08;
        END IF;
        IF(N = 0.07 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA ZERO SETE");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " VÍRGULA ZERO SETE");
            END IF;
            SET N = N - 0.07;
        END IF;
         IF(N = 0.06 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA ZERO SEIS");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " VÍRGULA ZERO SEIS");
            END IF;
            SET N = N - 0.06;
        END IF;
         IF(N = 0.05 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA ZERO CINCO");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " VÍRGULA ZERO CINCO");
            END IF;
            SET N = N - 0.05;
        END IF;
         IF(N = 0.04 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA ZERO QUATRO");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " VÍRGULA ZERO QUATRO");
            END IF;
            SET N = N - 0.04;
        END IF;
         IF(N = 0.03 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA ZERO TRÊS");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " VÍRGULA ZERO TRÊS");
            END IF;
            SET N = N - 0.03;
        END IF;
         IF(N = 0.02 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA ZERO DOIS");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " VÍRGULA ZERO DOIS");
            END IF;
            SET N = N - 0.02;
        END IF;
         IF(N = 0.01 ) THEN
			IF(EXTENSO = "") THEN
				SET EXTENSO = CONCAT(EXTENSO, "ZERO VÍRGULA ZERO UM");
            ELSE
				SET EXTENSO = CONCAT(EXTENSO, " VÍRGULA ZERO UM");
            END IF;
            SET N = N - 0.07;
        END IF;
        
    END IF;
    
    IF(N = 0) THEN
		IF(EXTENSO = "") THEN
			SET EXTENSO = CONCAT(EXTENSO, "ZERO");
        END IF;
    END IF;
    
    RETURN EXTENSO;
END $$

-- PROCEDURE PARA CADASTRAR UM CLIENTE
CREATE PROCEDURE PC_NOVO_CLIENTE(IN NOME VARCHAR(100), 
								IN vCPF CHAR(11), 
                                IN RG VARCHAR(16), 
                                IN LOGRADOURO VARCHAR(100),
                                IN NUMERO VARCHAR(10),
                                IN BAIRRO VARCHAR(100),
                                IN CIDADE VARCHAR(100),
                                IN UF CHAR(2),
                                IN COMPLEMENTO VARCHAR(100),
                                IN DT_NASCIMENTO DATE,
                                IN TELEFONE_RESIDENCIAL VARCHAR(15),
                                IN TELEFONE_COMERCIAL VARCHAR(15),
                                IN TELEFONE_RECADO VARCHAR(15))
BEGIN
	
    -- DECLARAÇÃO DE VARIÁVEIS
	DECLARE CONTADOR INT;
    DECLARE CLIENTE INT;
    DECLARE ULTIMO_CARTAO CHAR(17);
    DECLARE NOVO_NUMERO_CARTAO CHAR(17);
    DECLARE DIGITO_CARTAO CHAR(6);
    
    -- VALIDAÇÃO DE CPF REPETIDO
    SELECT IDCLIENTE INTO CONTADOR FROM CLIENTE WHERE CPF = vCPF;
    IF (CONTADOR IS NOT NULL) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "ESTE CPF JÁ EXISTE NO BANCO DE DADOS!";
    END IF;
    
    -- VALIDAÇÃO DO CPF EM SI
    IF(FN_VALIDAR_CPF(vCPF) = 0) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "CPF INVÁLIDO!";
    END IF;
    
    -- CADASTRANDO O CLIENTE
    INSERT INTO CLIENTE VALUES (NULL, NOME, vCPF, RG, LOGRADOURO, NUMERO, BAIRRO, CIDADE, UF, COMPLEMENTO, DT_NASCIMENTO, TELEFONE_RESIDENCIAL, TELEFONE_COMERCIAL, TELEFONE_RECADO);

END $$

-- PROCEDURE PARA CADASTRAR UM NOVO CARTÃO
CREATE PROCEDURE PC_NOVO_CARTAO(IN CLIENTE INT, IN DIA_VENCIMENTO INT, IN LIMITE NUMERIC(8,2))
BEGIN
	
    -- DECLARAÇÃO DE VARIÁVEIS
    DECLARE vCPF CHAR(11);
    DECLARE vNUMERO CHAR(17);
    DECLARE NOVO_NUMERO CHAR(17);
    DECLARE NOVO_IDENTIFICADOR CHAR(6);
    DECLARE IDENTIFICADOR INT;
    DECLARE CONTADOR INT;
    
    -- VERIFICANDO SE O DIA É VÁLIDO
    IF(DIA_VENCIMENTO < 1 OR DIA_VENCIMENTO > 31) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "DIA DE VENCIMENTO INVÁLIDO!";
    END IF;
    
    -- CPF DO CLIENTE
    SELECT CPF INTO vCPF FROM CLIENTE WHERE IDCLIENTE = CLIENTE;
    
    -- VERIFICANDO SE HÁ UM NÚMERO DE CARTÃO CADASTRADO
    SELECT NUMERO INTO vNUMERO FROM CARTAO ORDER BY IDCARTAO DESC LIMIT 1;
    
    IF(vNUMERO IS NULL) THEN		
        SET IDENTIFICADOR = 1;        
    ELSE
		SET IDENTIFICADOR = CAST( SUBSTR(vNUMERO,12,6) AS UNSIGNED ) + 1;
	END IF;
    
	SET CONTADOR = LENGTH(IDENTIFICADOR);
        
	SET NOVO_IDENTIFICADOR = "";
	WHILE(CONTADOR < 6) DO
		SET NOVO_IDENTIFICADOR = CONCAT(NOVO_IDENTIFICADOR, "0");
		SET CONTADOR = CONTADOR + 1;
	END WHILE;
    SET NOVO_IDENTIFICADOR = CONCAT(NOVO_IDENTIFICADOR, IDENTIFICADOR);
	SET NOVO_NUMERO = CONCAT(vCPF, NOVO_IDENTIFICADOR);
    
     -- CADASTRANDO CARTÃO
	INSERT INTO CARTAO VALUES (NULL, CLIENTE, NOVO_NUMERO, DIA_VENCIMENTO, LIMITE);
   
END $$

-- PROCEDURE PARA INCLUIR UM NOVO DÉBITO
CREATE PROCEDURE PC_NOVO_DEBITO(IN vVALOR NUMERIC(8,2), IN vPARCELAS INT, IN vCARTAO INT, IN vDESCRICAO TEXT)
BEGIN

	-- DECLARAÇÃO DE VARIÁVEIS
    DECLARE vLIMITE NUMERIC(8,2);
    DECLARE vVALOR_PARCELA NUMERIC(8,2);
    DECLARE CONTADOR INT;
    DECLARE DATA_DEBITO DATE;
    DECLARE vDIA_VENCIMENTO INT;
    
    -- SELECIONAR LIMITE ATUAL DO CARTÃO
    SELECT LIMITE INTO vLIMITE FROM CARTAO WHERE IDCARTAO = vCARTAO;
    
    -- SELECIONANDO O DIA DO VENCIMENTO ESCOLHIDO PELO CLIENTE
    SELECT DIA_VENCIMENTO INTO vDIA_VENCIMENTO FROM CARTAO WHERE IDCARTAO = vCARTAO;
    
    -- VERIFICAR SE O VALOR DO DÉBITO SUPORTA O LIMITE DO CARTÃO
    IF(vVALOR > vLIMITE) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "LIMITE INSUFICIENTE!";
    END IF;
    
    -- DEFININDO O VALOR DE CADA PARCELA
    IF(vPARCELAS = 1) THEN
		SET vVALOR_PARCELA = vVALOR;
	ELSE
		SET vVALOR_PARCELA = vVALOR / vPARCELAS;
    END IF;
    
    -- DATA ATUAL
    SET DATA_DEBITO = NOW();
    
    -- INCLUINDO OS DÉBITOS
    SET CONTADOR = 1;
    WHILE (CONTADOR <= vPARCELAS) DO
		INSERT INTO DEBITO VALUES (NULL, vCARTAO, CONCAT(vDESCRICAO, " (", CONTADOR, "/", vPARCELAS, ")"), CONTADOR, vVALOR_PARCELA, DATA_DEBITO);
        SET DATA_DEBITO = DATE_ADD(DATA_DEBITO, INTERVAL 1 MONTH);
		SET CONTADOR = CONTADOR + 1;
    END WHILE;

END $$

-- PROCEDURE PARA GERAR UM BOLETO
CREATE PROCEDURE PC_GERAR_BOLETO(IN vCARTAO INT, IN vDEBITO INT)
BEGIN

	-- DECLARAÇÃO DE VARIÁVEIS
    DECLARE ULTIMO_DEBITO INT;
    DECLARE BOLETO_EXISTENTE INT;
    DECLARE vVALOR_PAGO NUMERIC(8,2);
    DECLARE vDIA_VENCIMENTO INT;
    DECLARE DATA_VENCIMENTO DATE;
    DECLARE VALOR_BOLETO NUMERIC(8,2);
    DECLARE NOVO_BOLETO INT;
    
    -- SELECIONANDO DÉBITO DO CARTÃO 
    SELECT IDDEBITO INTO ULTIMO_DEBITO FROM DEBITO WHERE IDCARTAO = vCARTAO LIMIT 1;
    IF(ULTIMO_DEBITO IS NULL) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "NENHUM DÉBITO ENCONTRADO!";
    END IF;
    
    -- VERIFICANDO SE JÁ EXISTE ESTE BOLETO E SE ELE JÁ FOI PAGO
    SELECT IDBOLETO INTO BOLETO_EXISTENTE FROM ITEM_BOLETO WHERE IDDEBITO = vDEBITO;
    IF(BOLETO_EXISTENTE IS NOT NULL) THEN
		SELECT VALOR_PAGO INTO vVALOR_PAGO FROM BOLETO WHERE IDBOLETO = BOLETO_EXISTENTE;
        IF(vVALOR_PAGO IS NOT NULL) THEN
			SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "ESTE BOLETO JÁ FOI PAGO!";
		ELSE
			-- SE O BOLETO EXISTIR E NÃO TIVER SIDO PAGO, APAGO ESTE ANTES DE GERAR OUTRO
			DELETE FROM ITEM_BOLETO WHERE IDBOLETO = BOLETO_EXISTENTE AND IDDEBITO = vDEBITO;
            DELETE FROM BOLETO WHERE IDBOLETO = BOLETO_EXISTENTE;
        END IF;
    END IF;
    
    -- FORMATANDO A DATA DE VENCIMENTO DO BOLETO
    SELECT DIA_VENCIMENTO INTO vDIA_VENCIMENTO FROM CARTAO WHERE IDCARTAO = vCARTAO;
    SET DATA_VENCIMENTO = CAST( CONCAT( YEAR(NOW()), "-", MONTH(NOW()), "-", vDIA_VENCIMENTO) AS DATE);
    IF(vDIA_VENCIMENTO > 25) THEN
		SET DATA_VENCIMENTO = DATE_ADD(DATA_VENCIMENTO, INTERVAL 1 MONTH);
    END IF;

	-- CONTROLE PARA NÃO GERAR BOLETO COM DATA DE VENCIMENTO INFERIOR À DATA NA QUAL ELE FOI GERADO
    -- ESTE CONTROLE IMPEDE QUE BOLETOS SEJAM PAGOS COM ATRASO, IMPEDINDO ALGUNS CONTROLES DO EXERCÍCIO COMO AS
    -- TAXAS DE ATRASO DE PAGAMENTO DESAPARECEREM... SE QUISEREM ESTE CONTROLE É SÓ DESCOMENTAR O CÓDIGO
    /*
    IF(NOW() > DATA_VENCIMENTO) THEN
		SET DATA_VENCIMENTO = DATE_ADD(DATA_VENCIMENTO, INTERVAL 1 MONTH);
    END IF;
    */

    -- PEGANDO O VALOR DO BOLETO
    SELECT VALOR INTO VALOR_BOLETO FROM DEBITO WHERE IDDEBITO = vDEBITO LIMIT 1;
    
    -- INSERINDO O BOLETO
    INSERT INTO BOLETO VALUES (NULL, vCARTAO, NOW(), DATA_VENCIMENTO, VALOR_BOLETO, NULL, NULL);
    
    -- PEGANDO ID DO BOLETO GERADO
    SELECT IDBOLETO INTO NOVO_BOLETO FROM BOLETO WHERE IDCARTAO = vCARTAO ORDER BY IDBOLETO DESC LIMIT 1;
    
    -- LIGANDO O BOLETO AO DÉBITO
    INSERT INTO ITEM_BOLETO VALUES (NULL, NOVO_BOLETO, vDEBITO);
    
END $$

-- PROCEDURE PARA PAGAR UM BOLETO
CREATE PROCEDURE PC_PAGAR_BOLETO(IN vBOLETO INT, IN vVALOR NUMERIC(8,2))
BEGIN

	-- DECLARAÇÃO DE VARIÁVEIS
    DECLARE HOJE DATE;
    DECLARE vCLIENTE INT;
    DECLARE vDT_VENCIMENTO DATE;
    DECLARE DIAS INT;
    DECLARE vMULTA DOUBLE;
    DECLARE vJURO DOUBLE;
    DECLARE vCARTAO INT;
    DECLARE vDIFERENCA NUMERIC(8,2);
    DECLARE vVALOR_TOTAL NUMERIC(8,2);
    DECLARE vREFINANCIAMENTO NUMERIC(8,2);
    
    -- PRIMEIRAMENTE VAMOS ATRIBUIR O DIA DE HOJE A UMA VARIÁVEL
    SET HOJE = NOW();
    
    -- PEGAMOS O ID DO CLIENTE
    SELECT CLIENTE.IDCLIENTE INTO vCLIENTE 
    FROM BOLETO
    INNER JOIN CARTAO ON
    (BOLETO.IDCARTAO = CARTAO.IDCARTAO)
    INNER JOIN CLIENTE ON
    (CARTAO.IDCLIENTE = CLIENTE.IDCLIENTE)
    WHERE BOLETO.IDBOLETO = vBOLETO;
    
    -- ID DO CARTÃO
    SELECT IDCARTAO INTO vCARTAO FROM BOLETO WHERE IDBOLETO = vBOLETO;
    
    -- PEGAMOS O VALOR TOTAL DO BOLETO
    SELECT VALOR_TOTAL INTO vVALOR_TOTAL FROM BOLETO WHERE IDBOLETO = vBOLETO;
    
    -- AGORA VAMOS PEGAR A DIFERENÇA, EM DIAS, ENTRE A DATA DE HOJE E A DATA LIMITE DO BOLETO
    SELECT DT_VENCIMENTO INTO vDT_VENCIMENTO FROM BOLETO WHERE IDBOLETO = vBOLETO;
    SET DIAS = DATEDIFF(HOJE, vDT_VENCIMENTO);
	
    -- SE HOUVER UM OU MAIS DIAS DE ATRASO, FAREMOS ALGUMAS AÇÕES...
    IF(DIAS > 0) THEN
		
        -- AQUI PRECISAMOS PEGAR 2% DO VALOR DO BOLETO
        SET vMULTA = vVALOR_TOTAL * 0.02;
        
        -- AGORA 0,2% DE JUROS POR DIA DE ATRASO
        SET vJURO = (vVALOR_TOTAL * 0.002) * DIAS;
        
        -- INSERIMOS ESSES DOIS DÉBITOS AO BANCO
        INSERT INTO DEBITO VALUES (NULL, vCARTAO, CONCAT("TAXA ADMINISTRATIVA - MULTA DE 2% DE ATRASO NO PGTO DO BOLETO ", vBOLETO), 1, vMULTA, NOW());
        INSERT INTO DEBITO VALUES (NULL, vCARTAO, CONCAT("TAXA ADMINISTRATIVA - JUROS DE 0,2% AO DIA DE ATRASO NO PGTO DO BOLETO ", vBOLETO), 1, vJURO, NOW());
        
    END IF;
    
    -- VERIFICAMOS SE O VALOR PAGO É MENOR QUE O VALOR DO BOLETO, SE FOR, PEGAMOS A DIFERENÇA E GERAMOS UM DÉBITO COM A COBRANÇA DA DIFERENÇA 
    IF(vVALOR_TOTAL - vVALOR < 0) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "O VALOR PAGO É MAIOR QUE O VALOR DO BOLETO!";
    END IF;
    
    IF(vVALOR_TOTAL - vVALOR > 0) THEN
    
		-- VALOR DA DIFERENÇA GERADO EM DÉBITO
		SET vDIFERENCA = vVALOR_TOTAL - vVALOR;
        INSERT INTO DEBITO VALUES (NULL, vCARTAO, CONCAT("TAXA ADMINISTRATIVA - DIFERENÇA DE VALOR DO BOLETO ", vBOLETO), 1, vDIFERENCA, NOW());
        
        -- VALOR DE REFINANCIAMENTO DE 15%
        SET vREFINANCIAMENTO = vVALOR_TOTAL * 0.15;
        INSERT INTO DEBITO VALUES (NULL, vCARTAO, CONCAT("TAXA ADMINISTRATIVA - REFINANCIAMENTO DE 15% DO VALOR DO BOLETO ", vBOLETO), 1, vREFINANCIAMENTO, NOW());
        
    END IF;
    
    -- PAGANDO O BOLETO
    UPDATE BOLETO SET DT_PAGAMENTO = NOW(), VALOR_PAGO = vVALOR WHERE IDBOLETO = vBOLETO;
    
END $$

DELIMITER ;

-- CRIANDO AS VIEWS

-- FUNCTION DE ID DO CARTÃO PARA AS VIEWS
CREATE FUNCTION CARTAO() RETURNS INT RETURN @CARTAO;

-- VIEW DE SALDO DISPONÍVEL NO CARTÃO PARA COMPRA
CREATE VIEW VW_SALDO_DISPONIVEL AS
SELECT 	(SELECT LIMITE FROM CARTAO WHERE IDCARTAO = CARTAO()) -
		IFNULL(SUM(VALOR),0) +
        (SELECT IFNULL(SUM(VALOR_PAGO),0) FROM BOLETO WHERE IDCARTAO = CARTAO()) AS SALDO
FROM DEBITO
WHERE DEBITO.IDCARTAO = CARTAO();

-- VIEW PARA EXTRATO DE COMPRA DE UM CARTÃO 
CREATE VIEW VW_EXTRATO_COMPRA AS
SELECT 	CLIENTE.IDCLIENTE AS ID_CLIENTE,
		CLIENTE.NOME AS NM_CLIENTE,
        CONCAT(SUBSTR(CARTAO.NUMERO,1,2), "*************" ,SUBSTR(CARTAO.NUMERO, LENGTH(CARTAO.NUMERO)-2,2)) AS NM_CARTAO,
        DEBITO.DT_DEBITO AS DATA_COMPRA,
        DEBITO.DESCRICAO AS DESCRICAO,
        DEBITO.PARCELA AS PARCELA,
        DEBITO.VALOR AS VALOR,
        FN_EXTENSO(DEBITO.VALOR) AS VALOR_EXTENSO,
        CAST( CONCAT(YEAR(DEBITO.DT_DEBITO), "-", MONTH(DEBITO.DT_DEBITO), "-", CARTAO.DIA_VENCIMENTO) AS DATE) AS DATA_VENCIMENTO
FROM DEBITO 
INNER JOIN CARTAO ON 
(DEBITO.IDCARTAO = CARTAO.IDCARTAO)
INNER JOIN CLIENTE ON 
(CARTAO.IDCLIENTE = CLIENTE.IDCLIENTE)
WHERE DEBITO.IDCARTAO = CARTAO()
-- BOLETOS PAGOS NÃO DEVEM APARECER
AND (
		SELECT BOLETO.VALOR_PAGO 
        FROM ITEM_BOLETO 
        INNER JOIN BOLETO ON 
        (ITEM_BOLETO.IDBOLETO = BOLETO.IDBOLETO)
        WHERE ITEM_BOLETO.IDDEBITO = DEBITO.IDDEBITO
	) IS NULL;

-- VIEW QUE LISTA ITENS COBRADOS
CREATE VIEW VW_ITENS_COBRADOS AS
SELECT 	BOLETO.IDBOLETO AS NUMERO_BOLETO,
		ITEM_BOLETO.IDITEM_BOLETO AS ID_ITEM,
        DEBITO.DESCRICAO AS DESCRICAO,
        BOLETO.VALOR_TOTAL AS VALOR_ITEM,
        BOLETO.DT_VENCIMENTO AS DATA_PARCELA
FROM ITEM_BOLETO
INNER JOIN BOLETO ON
(ITEM_BOLETO.IDBOLETO = BOLETO.IDBOLETO)
INNER JOIN DEBITO ON
(ITEM_BOLETO.IDDEBITO = DEBITO.IDDEBITO)
WHERE DEBITO.IDCARTAO = CARTAO()
AND DEBITO.DESCRICAO NOT LIKE "%TAXA ADMINISTRATIVA%";



-- INSERINDO VALORES PARA TESTES
-- CLIENTES
CALL PC_NOVO_CLIENTE("JOÃO SILVEIRA", "10929303024", "225588", "RUA BRANCA DE NEVE", "2020B", "RATONES", "ILHA DA MAGIA", "SC", "BLOCO B", "1975-05-01", "4832225555", "4832256666", "4832226699");
CALL PC_NOVO_CLIENTE("MILTON MARTINS", "93955405087", "225588", "RUA BRANCA DE NEVE", "2020B", "RATONES", "ILHA DA MAGIA", "SC", "BLOCO B", "1991-11-11", "4832225555", "4832256666", "4832226699");
CALL PC_NOVO_CLIENTE("TOMÁS TURBANO", "37124209005", "225588", "RUA BRANCA DE NEVE", "2020B", "RATONES", "ILHA DA MAGIA", "SC", "BLOCO B", "2000-05-07", "4832225555", "4832256666", "4832226699");
CALL PC_NOVO_CLIENTE("VOLIN RABAH", "39243130080", "225588", "RUA BRANCA DE NEVE", "2020B", "RATONES", "ILHA DA MAGIA", "SC", "BLOCO B", "1999-12-01", "4832225555", "4832256666", "4832226699");

-- CARTÕES (IDCLIENTE, DIA_VENCIMENTO, VALOR_LIMITE)
CALL PC_NOVO_CARTAO(2,2,2500);
CALL PC_NOVO_CARTAO(3,3,3400);
CALL PC_NOVO_CARTAO(4,12,2000);

-- DÉBITO (VALOR, PARCELAS, IDCARTAO, DESCRICAO)
CALL PC_NOVO_DEBITO(500, 2, 2,"COMPRA BOOTCAMP ONLINE");

-- BOLETO (IDCARTAO, IDDEBITO)
CALL PC_GERAR_BOLETO(2,1);

-- PAGAR BOLETO (IDBOLETO, VALOR)
CALL PC_PAGAR_BOLETO(1,150);

-- TESTANDO AS VIEWS

-- VIEW PARA MOSTRAR O SALDO DISPONÍVEL PARA COMPRA NO CARTÃO
SET @CARTAO = 2;
SELECT SALDO FROM VW_SALDO_DISPONIVEL;

-- VIEW DE EXTRATO DETALHADO
SET @CARTAO = 2;
SELECT ID_CLIENTE, NM_CLIENTE, NM_CARTAO, DATA_COMPRA, DESCRICAO, PARCELA, VALOR, VALOR_EXTENSO, DATA_VENCIMENTO FROM VW_EXTRATO_COMPRA;

-- VIEW ITENS COBRADOS
SET @CARTAO = 2;
SELECT NUMERO_BOLETO, ID_ITEM, DESCRICAO, VALOR_ITEM, DATA_PARCELA FROM VW_ITENS_COBRADOS;

-- FUNÇÃO PARA VALIDAR CPF 1 VERDADEIRO E 0 FALSE
-- SELECT FN_VALIDAR_CPF('55555555555');