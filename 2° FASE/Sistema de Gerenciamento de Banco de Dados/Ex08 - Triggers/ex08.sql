SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBESTATISTICA;
CREATE DATABASE DBESTATISTICA;
USE DBESTATISTICA;

CREATE TABLE PESSOA (
	IDPESSOA INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, NOME VARCHAR(45)
	, SEXO CHAR(1)
);

CREATE TABLE ESTATISTICA (	
	HOMEM INT
	, MULHER INT
);

DELIMITER $$
	create trigger pessoa_add after insert on pessoa for each row
    begin
	
		if ( NEW.sexo = "M") then
			update estatistica set homem = homem + 1;
        else
			update estatistica set mulher = mulher + 1;
        end if;
    
	end $$
    
    create trigger pessoa_del after delete on pessoa for each row
    begin
    
		if (OLD.sexo = "M") then
			update estatistica set homem = homem - 1;
        else
			update estatistica set mulher = mulher - 1;
        end if;
    
    end $$
    
    create trigger pessoa_update after update on pessoa for each row
    begin
		
        if (OLD.sexo = "M") then
			update estatistica set homem = homem - 1;
        else
			update estatistica set mulher = mulher - 1;
        end if;
        
        if (OLD.sexo = "M") then
			update estatistica set homem = homem - 1;
        else
			update estatistica set mulher = mulher - 1;
        end if;
        
    end $$
DELIMITER ;

INSERT INTO ESTATISTICA VALUES (0,0);
INSERT INTO PESSOA VALUES (NULL, "GUILHERME", "M"),(NULL, "MARIA", "F"),(NULL, "JOÃO", "M");