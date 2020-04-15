CREATE DATABASE IF NOT EXISTS DBFUNCAO;
USE DBFUNCAO;

CREATE TABLE IF NOT EXISTS ALUNO (
	IDALUNO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(20) NOT NULL,
	SEXO ENUM ('M', 'F'),
	DT_NASCIMENTO DATE,
	CIDADE VARCHAR(20)
);
/* sugiro que deixem esses comandos de inserção comentados depois do primeiro uso */
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('ANDERSON'	, '1998-01-17', 'M','PALHOCA');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('CESAR'		, '1996-06-21', 'M', 'SAO JOSE');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('DANIEL'	, '1989-10-19', 'M', 'PALHOCA');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('DIEGO'		, '1991-12-19', 'M', 'BLUMENAU');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('EDUARDO'	, '1991-01-20', 'M', NULL);
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('GABRIEL'	, '1996-06-19', 'M', 'TUBARAO');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('JOAO'		, '1992-01-18', 'M', 'SAO JOSE');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('LEONARDO'	, '1989-07-19', 'M', NULL);
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('LUCAS'		, '1998-01-20', 'M', 'BLUMENAU');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('PRISCILA'	, '2005-04-19', 'F', 'PALHOÇA');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('RENATA'	, '1991-12-21', 'F', 'TUBARAO');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('MARIA'		, '1992-12-22', 'F', 'BLUMENAU');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('TANIA'		, '1996-08-19', 'F', 'SAO JOSE');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('CARLOS'	, '2001-10-22', 'M', 'TUBARAO');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('JOSE'		, '1996-06-19', 'M', 'PALHOCA');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('MARISA'	, '1991-06-19', 'F', NULL);
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('AMANDA'	, '2004-03-20', 'F', NULL);
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('JOANA'		, '1998-01-19', 'F', NULL);
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('ALICE'		, '1991-06-21', 'F', 'SAO JOSE');
INSERT INTO ALUNO (NOME, DT_NASCIMENTO, SEXO, CIDADE)VALUES('TADEU'		, '1995-12-18', 'M', 'TUBARAO');


/*Resolvendo os exercícios*/

/* Crie uma consulta SQL que liste todos os alunos com “R" no nome e informe a posição da letra;​ */
select nome, locate("r",nome) as posicao from aluno;

/* Crie uma consulta SQL que lista o nome de todos os alunos em ordem alfabética e com todos os 
caracteres em letra minúsculas, exceto a primeira letra que deve estar em maiúscula;​ */
select concat(upper(substr(nome,1,1)), lower(substr(nome,2,length(nome)))) as nome from aluno;

/* Crie uma consulta SQL que listar “Sr. ” na frente do nome quando o aluno for masculino e 
“Sra.” quando o aluno for do sexo feminino. O nome deve estar com apenas a primeira letra em 
maiúscula e o texto “Sr.” e “Sra.” deve aparecer junto com o nome separado por espaço; */
select if(sexo = "m", concat("Sr. ", concat(upper(substr(nome,1,1))),lower(substr(nome,2,length(nome)))), concat("Sra. ", concat(upper(substr(nome,1,1))), lower(substr(nome,2,length(nome))))) as nome from aluno;

/* Crie uma consulta SQL para criar a frase juntando o nome do aluno com a cidade o resultado deve 
aparecer da seguinte forma “Maria mora em São José"; */
select concat(nome," mora em ",cidade) as dado from aluno where cidade is not null;

/* Crie uma consulta SQL para listar todos os alunos, listando o nome e a idade de cada aluno; */
select nome, timestampdiff(year, DT_NASCIMENTO, curdate()) as idade from aluno;

/* Crie uma consulta SQL para  listar todos os alunos, listando o nome e a data do próximo aniversário 
de cada aluno */
select nome, if(concat(year(curdate()),"-",month(DT_NASCIMENTO),"-",day(DT_NASCIMENTO)) <= curdate(), concat(day(DT_NASCIMENTO),"/",month(DT_NASCIMENTO),"/",year(curdate())+1), concat(day(DT_NASCIMENTO),"/",month(DT_NASCIMENTO),"/",year(curdate()))) as prox_niver from aluno;
