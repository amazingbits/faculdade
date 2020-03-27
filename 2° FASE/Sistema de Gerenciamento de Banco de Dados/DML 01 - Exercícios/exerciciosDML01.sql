/*Cria a Base de Dados*/
create database if not exists dbAluno1;

/*Utiliza o banco que acabamos de criar*/
use dbAluno1;

/*Agora vamos criar a tabela que o professor passou nos exercícios*/
create table if not exists aluno(
id int not null auto_increment,
nome varchar(255),
idade int,
sexo char(1),
cidade varchar(255),
primary key(id));

/*Vamos adicionar os valores que estão nos exercícios*/
/*Sugiro comentar este comando pra não ficar adicionando alunos cada
vez que executarem o código*/

insert into aluno values (null, "Anderson", 17, "M", "Palhoça"),
						 (null, "Cesar", 18, "M", "São José"),
                         (null, "Daniel", 21, "M", "Tubarão"),
                         (null, "Diego", 17, "M", "Tubarão"),
                         (null, "Eduardo", 18, "M", "Palhoça"),
                         (null, "Maria", 18, "F", "São José"),
                         (null, "Carlos", 22, "M", "Blumenau"),
                         (null, "José", 18, "M", NULL),
                         (null, "Marisa", 25, "F", "Blumenau"),
                         (null, "Amanda", 17, "F", "São José");

/* 1.Crie uma consulta SQL para listar os alunos do sexo masculino */
select * from aluno where sexo = "m";

/* 2.Crie uma consulta SQL para listar os alunos com 19 anos */
select * from aluno where idade = 19;

/* 3.Crie uma consulta SQL para listar os alunos com a primeira letra do nome igual a 'D' */
select * from aluno where left(nome,1) = 'd';

/* 4.Crie uma consulta SQL para listar os alunos com idade entre 20 e 22 anos */
select * from aluno where idade between 20 and 22;

/* 5.Crie uma consulta SQL para listar os alunos sem cidade cadastrada */
select * from aluno where cidade is null;

/* 6.Crie uma consulta SQL para listar os alunos que moram em Blumenau */
select * from aluno where cidade = "blumenau";

/* 7.Crie uma consulta SQL para listar os alunos que com idade diferente a18 anos */
select * from aluno where idade <> 18;

/* 8.Crie uma consulta SQL para listar os alunos com que tenham"Ri" em qualquer parte do nome */
select * from aluno where nome like '%ri%';

/* 9.Crie uma consulta SQL para listar os alunos de São José do sexo masculino com menos de 20 anos */
select * from aluno where (cidade = "são josé") and (sexo = "m") and (idade < 20);

/* 10.Crie  uma  consulta  SQL  para  listar  os  alunos  maiores  de  
idade (idade  acima  de  20  para mulheres e idade acima de 17 para homens) */
select * from aluno where (sexo = "f" and idade > 17) or (sexo = "m" and idade > 20);

/* 11.Crie uma consulta SQL para listar somente os alunos que tenham "A" e "R" no nome */
select * from aluno where (nome like '%a%') or (nome like '%r%');

/* 12.Crie uma consulta SQL para listar somente o nome e idade dos alunos do sexo feminino */
select nome, idade from aluno where sexo = "f";

/* 13.Crie uma consulta SQL para listar somente o código e o nome dos alunos de Blumenau */
select id, nome from aluno where cidade = "blumenau";

/* 14.Crie uma consulta SQL para listar somente o nome e a cidade dos alunos que são menores de idade */
select nome, cidade from aluno where (sexo = "f" and idade <= 17) or (sexo = "m" and idade <= 20);

/* 15.Crie uma consulta SQL para listar somente o Nome e a cidade  
dos alunos com idade entre 15 e 18 anos que não moram em palhoça */
select nome, cidade from aluno where (idade between 15 and 18) and (cidade <> "palhoça");

/* 16.Crie  uma  consulta  SQL  para  listar  somente  a  cidade  de  todos  os  alunos  que  têm  
cidade cadastrada */
select cidade from aluno where cidade is not null;

/* 17.Crie  uma  consulta  SQL  para  listar  somente  o  nome  dos  alunos com  18  anos que  mora  
em palhoça ou 17 anos que mora em são José */
select nome from aluno where (idade = 18 and cidade = "palhoça") or (idade = 17 and cidade = "são josé");

/* 18.Crie uma consulta SQL para lista somente o nome dos alunos do sexo masculino moradores de tubarão 
com idade entre 18e 25 anos */
select nome from aluno where (cidade = "tubarão") and (sexo = "m") and (idade between 18 and 25);

/* 19.Crie uma consulta SQL para liste somente o nome e a idade dos alunos, ordenado pela idade */
select nome, idade from aluno order by idade asc;

/* 20.Crie  uma  consulta  SQL  para  liste  somente  o  código e  o  nome  dos  alunos,  ordenado  
pelo nome de forma decrescente. */
select id, nome from aluno order by nome desc;

/* 21.Crie uma consulta SQL para liste todos os dados dos alunos, ordenado pela idade de forma 
decrescente e depois pelo nome de forma crescente. */
select * from aluno order by idade desc, nome asc;

/* 22.Crie  uma  consulta  SQL  para  liste  todos  os  dados  dos  alunos,  ordenado  pelo  sexo  
e  depois pelo nome */
select * from aluno order by sexo, nome;

/* 23.Crie uma instrução SQL para alterar a idade do aluno 'Jose' para 20 anos */
update aluno set idade = 20 where nome = "josé";

/* 24.Crie  uma  instrução  SQL  para  alterar  a  idade  dos  alunos  'Tadeu', 'Cesar'  
e  'Marisa'  para  21 anos */
update aluno set idade = 21 where (nome = 'tadeu') or (nome = 'cesar') or (nome = 'marisa');

/* 25.Crie uma instrução SQL para alterar o aluno cuja o código seja 12, mudando seu nome para "Luiz" a 
idade para "22" o sexo para "M" e a cidade para "Tijucas“; */
update aluno set nome = "Luiz", idade = 22, sexo = "M", cidade = "Tijucas" where id = 12;

/* 26.Crie uma instrução SQL apagar a cidade de todos os alunos acima de 24 anos; */
update aluno set cidade = null where idade > 24;

/* 27.Crie uma instrução SQL remover os alunos que estão sem cidade; */
delete from aluno where cidade is null;

/* 28.Crie uma instrução SQL remover os alunos que moram em tubarãoe com mais de 15 anos do sexo 
masculino; */
delete from aluno where (cidade = "tubarão") and (idade > 15) and (sexo = "m");

/* 29.Crie uma instrução SQL remover os alunos "Tadeu", “Alice" "Maria" desde que tenham 19 anos */
delete from aluno where ((nome = "tadeu") or (nome = "alice") or (nome = "maria")) and (idade = 19);

/* 30.Crie uma instrução SQL remover os alunos com menos de 18 anos para o sexo masculino e os alunos 
com menos de 21 do sexo feminino; */
delete from aluno where ((sexo = "m") and (idade < 18)) or ((sexo = "f") and (idade < 21));