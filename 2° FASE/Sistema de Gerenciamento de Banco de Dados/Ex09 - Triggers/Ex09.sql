SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS DBCLASSIFICACAO;
CREATE DATABASE DBCLASSIFICACAO;
USE DBCLASSIFICACAO;

CREATE TABLE ALUNO (
	IDALUNO INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, NOME VARCHAR(45)
	, IDADE INT
);

CREATE TABLE CLASSIFICACAO (	
	CRIANCAS INT
	, JOVENS INT
	, ADULTOS INT
);

INSERT INTO CLASSIFICACAO VALUES (0,0,0);

/*
Regra:
abaixo 10 - Criancas
10 a 18 - Jovens
Acima de 18 - Adulto
*/

delimiter $$

create trigger aluno_add after insert on aluno for each row
begin

	if (NEW.idade < 10) then
		update classificacao set criancas = criancas + 1;
	elseif (NEW.idade >= 10 and NEW.idade <= 18) then
		update classificacao set jovens = jovens + 1;
	else
		update classificacao set adultos = adultos + 1;
	end if;

end $$

create trigger aluno_del after delete on aluno for each row
begin

	if (OLD.idade < 10) then
		update classificacao set criancas = criancas - 1;
	elseif (OLD.idade >=10 and OLD.idade <= 18) then
		update classificacao set jovens = jovens - 1;
	else
		update classificacao set adultos = adultos - 1;
	end if;

end $$

create trigger aluno_update after update on aluno for each row
begin

	if (NEW.idade < 10) then
		update classificacao set criancas = criancas + 1;
	elseif (NEW.idade >= 10 and NEW.idade <= 18) then
		update classificacao set jovens = jovens + 1;
	else
		update classificacao set adultos = adultos + 1;
	end if;
    
    if (OLD.idade < 10) then
		update classificacao set criancas = criancas - 1;
	elseif (OLD.idade >=10 and OLD.idade <= 18) then
		update classificacao set jovens = jovens - 1;
	else
		update classificacao set adultos = adultos - 1;
	end if;

end $$
delimiter ;

insert into aluno values 	(null, "Joao", 15),
							(null, "Marcos", 12),
                            (null, "Julia", 25),
                            (null, "Alberto", 29),
                            (null, "Thiago", 17),
                            (null, "Guilherme", 8),
                            (null, "Otavio", 9);
select * from aluno;
select * from classificacao;