SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBMATRICULA;
CREATE DATABASE DBMATRICULA;
USE DBMATRICULA;

CREATE TABLE ALUNO (
	IDALUNO INT NOT NULL AUTO_INCREMENT
	, NOME VARCHAR(45)
    , PRIMARY KEY (IDALUNO)
);

CREATE TABLE DISCIPLINA(	
	IDDISCIPLINA INT NOT NULL AUTO_INCREMENT
	, NOME VARCHAR(45)
	, DT_INICIO DATE
	, DT_FIM DATE
    , PRIMARY KEY (IDDISCIPLINA)
);

CREATE TABLE MATRICULA (
	IDALUNO INT NOT NULL
	, IDMATRICULA INT NOT NULL
    , IDDISCIPLINA INT NOT NULL
	, DT_MATRICULA DATE
    , PRIMARY KEY (IDALUNO, IDMATRICULA)
    , FOREIGN KEY (IDALUNO) REFERENCES ALUNO (IDALUNO)
    , FOREIGN KEY (IDDISCIPLINA) REFERENCES DISCIPLINA (IDDISCIPLINA)
);

/*
Regra:
O CAMPO DT_MATRICULA DEVE SER PREENCHIDO NO MOMENTO DO INSERT
O campo DT_MATRICULA NÃO PODE SER MENOR(? - LER ANOTAÇÕES) QUE DT_FIM DA DISCIPLINA
O CAMPO DT_FIM DA DISCIPLINA NÃO PODE SER MENOR QUE DT_INICIO DA DISCIPLINA
CASO JA TENHA ALUNO MATRICULA A DT_INICIO E DT_FIM NÃO PODE SER ALTERADO;
*/

DELIMITER $$

/* O CAMPO DT_MATRICULA É PREENCHIDO NO MOMENTO DO INSERT */
/* O campo DT_MATRICULA NÃO PODE SER MENOR(? - LER ANOTAÇÕES) QUE DT_FIM DA DISCIPLINA */
CREATE TRIGGER TK_MATRICULA_BI BEFORE INSERT ON MATRICULA FOR EACH ROW
BEGIN
	
    DECLARE DISCIPLINA_DT_FIM DATE;
    SELECT DT_FIM INTO DISCIPLINA_DT_FIM FROM DISCIPLINA WHERE IDDISCIPLINA = NEW.IDDISCIPLINA;
    
	SET NEW.DT_MATRICULA = NOW();
    
    IF(DISCIPLINA_DT_FIM > NEW.DT_MATRICULA) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "A DATA DA MATRÍCULA NÃO PODE SER MENOR QUE A DATA FIM DA DISCIPLINA";
    END IF;

END $$

/* O CAMPO DT_FIM DA DISCIPLINA NÃO PODE SER MENOR QUE DT_INICIO DA DISCIPLINA
CASO JA TENHA ALUNO MATRICULA A DT_INICIO E DT_FIM NÃO PODE SER ALTERADO; */
CREATE TRIGGER TK_DISCIPLINA_BI BEFORE INSERT ON DISCIPLINA FOR EACH ROW
BEGIN

	IF(NEW.DT_FIM < NEW.DT_INICIO) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "A DATA INÍCIO NÃO PODE SER SUPERIOR À DATA FIM DA DISCIPLINA";
    END IF;

END $$

CREATE TRIGGER TK_ALTERAR_DISCIPLINA_BU BEFORE UPDATE ON DISCIPLINA FOR EACH ROW
BEGIN
	
    DECLARE REGISTRO INT;
    SELECT IDDISCIPLINA INTO REGISTRO FROM MATRICULA WHERE IDDISCIPLINA = OLD.IDDISCIPLINA OR IDDISCIPLINA = NEW.IDDISCIPLINA;
    
	IF(NEW.DT_INICIO > OLD.DT_FIM OR NEW.DT_FIM < OLD.DT_INICIO) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "A DATA INÍCIO NÃO PODE SER SUPERIOR À DATA FIM DA DISCIPLINA";
    END IF;
    
    IF(REGISTRO IS NOT NULL AND (NEW.DT_INICIO <> OLD.DT_INICIO OR NEW.DT_FIM <> OLD.DT_FIM)) THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "JÁ HÁ UMA MATRÍCULA REALIZADA PARA ESTA DISCIPLINA, PORTANTO, NÃO É POSSÍVEL ALTERAR AS DATAS DE INÍCIO E FIM DELA";
    END IF;

END $$

DELIMITER ;

-- INSERINDO ALGUMAS DISCIPLINAS
INSERT INTO DISCIPLINA VALUES (NULL, "GEOGRAFIA", "2020-01-01", "2020-03-31");
INSERT INTO DISCIPLINA VALUES (NULL, "PORTUGUÊS", "2020-01-01", "2020-12-31");
INSERT INTO DISCIPLINA VALUES (NULL, "MATEMÁTICA", "2020-01-01", "2020-12-31");

-- INSERINDO ALGUNS ALUNOS
INSERT INTO ALUNO VALUES (NULL, "JÚLIA");
INSERT INTO ALUNO VALUES (NULL, "CARLOS");
INSERT INTO ALUNO VALUES (NULL, "MAITÊ");
INSERT INTO ALUNO VALUES (NULL, "GUILHERME");

-- INSERINDO UMA MATRÍCULA PRA TESTAR, É POSSÍVEL INSERIR OUTRAS PRA MAIS TESTES CONFORME NECESSIDADE
INSERT INTO MATRICULA (IDALUNO, IDMATRICULA, IDDISCIPLINA) VALUES (1, 2, 1); -- SEM DATA, POIS ELE JÁ INSERE A DATA DE HOJE

/*
 == ANOTAÇÕES SOBRE O EXERCÍCIO ==
 
 ?: NESTE CASO EU ACHO QUE FARIA MAIS SENTIDO O CAMPO DT_MATRICULA NÃO PODER SER MAIOR QUE A DATA FIM DA
 DISCIPLINA, E NÃO MENOR. DIGAMOS QUE A DISCIPLINA TENHA UMA DATA FIM NO DIA 15 DE MARÇO. NÃO FAZ SENTIDO
 EU PODER EFETUAR MINHA MATRÍCULA NO DIA 16 DE MARÇO, PORÉM FIZ O QUE PEDIA NO EXERCÍCIO.

HÁ MAIS CONTROLES POSSÍVEIS DE SEREM FEITOS COMO MAIS TRIGGERS DE INSERT, UPDATE E DELETE DE OUTRAS TABELAS, OUTRA
VEZ, FIZ O QUE O EXERCÍCIO PEDIA.
 
*/