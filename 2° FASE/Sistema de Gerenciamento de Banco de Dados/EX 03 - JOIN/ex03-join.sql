/*Primeiramente, executem o script do exercício no teams...*/
/*EXERCÍCIO 03 - JOIN*/
use dbempresa;

/* 1 - Relação entre a tabela DEPARTAMENTO e FUNCIONARIO */
select * from funcionario
inner join departamento on
(funcionario.iddepartamento = departamento.iddepartamento);

/* 2 - Relação entre a tabela FUNCIONARIO e FUNCAO*/
select * from funcionario
inner join funcao on 
(funcionario.idfuncao = funcao.idfuncao);

/* 3- Relação entre FUNCIONARIO, FUNCAO e DEPARTAMENTO */
select * from funcionario
inner join funcao on
(funcionario.idfuncao = funcao.idfuncao)
inner join departamento on
(funcionario.iddepartamento = departamento.iddepartamento);

/* 4- Crie uma consulta SQL para listar o nome do funcionário, e o nome do 
departamento, de todos os funcionários que trabalham no departamento "financeiro"; */
select funcionario.nome AS funcionario,
	   departamento.nome AS departamento
from funcionario
inner join departamento on
(funcionario.iddepartamento = departamento.iddepartamento)
where departamento.nome = "financeiro";

/* 5- Crie uma consulta SQL para listar o maior salario, o menor salario, 
agrupado por sexo */
select sexo,
	   max(salario) as maior_salario,
	   min(salario) as menor_salario
from funcionario
group by sexo;

/* 6- Crie uma consulta SQL para listar a soma de todos os salario e a média 
salarial agrupado por departamento, liste também o código e o nome do departamento */
select departamento.iddepartamento as codigo,
       departamento.nome as departamento,
	   sum(funcionario.salario) as soma_salario,
       avg(funcionario.salario) as media_salarial
from funcionario
inner join departamento on 
(funcionario.iddepartamento = departamento.iddepartamento)
group by departamento.nome;

/* 7- Crie uma consulta SQL para listar a quantidade de funcionário 
por departamento, o resultado deve ser ordenado pelo nome do departamento */
select departamento.nome as departamento,
       count(funcionario.iddepartamento) as qtde_funcionarios
from funcionario
inner join departamento on 
(funcionario.iddepartamento = departamento.iddepartamento)
group by departamento.iddepartamento
order by departamento.nome;

/* 8- Crie uma consulta SQL para listar a soma dos salários dos 
funcionários por função, listando também o maior e o menor salario */
select funcao.nome as funcao,
       sum(funcionario.salario) as soma_salario,
	   max(funcionario.salario) as maior_salario,
       min(funcionario.salario) as menor_salario
from funcionario
inner join funcao on
(funcionario.idfuncao = funcao.idfuncao)
group by funcao.idfuncao;

/* 9- Crie uma consulta SQL para listar o código do funcionário, o 
nome do funcionário, o salario, o nome do departamento, e o nome 
da função, de todos os funcionários */
select funcionario.idfuncionario as cod_funcionario,
	   funcionario.nome as nome_funcionario,
       funcionario.salario as salario,
       departamento.nome as departamento,
       funcao.nome as funcao
from funcionario
inner join funcao on
(funcionario.idfuncao = funcao.idfuncao)
inner join departamento on
(funcionario.iddepartamento = departamento.iddepartamento)
order by funcionario.nome;