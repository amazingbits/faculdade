use dbmecanica;

/*
	1 - Crie uma consulta SQL que liste o nome e o telefone de cada proprietário, ordenado pelo nome;
*/

select nome, telefone_residencial, telefone_comercial, telefone_recado
from proprietario
order by nome;

/*
	2 - Crie uma consulta SQL que liste todos os serviços realizados pela oficina, ordenado 
    pelo nome do serviço;
*/

select nome
from servico
order by nome;

/*
	3 - Crie uma consulta SQL que liste todos os produtos vendidos pela oficina, ordenado pelo 
    nome do produto;
*/

select nome
from produto
order by nome;

/*
	4 - Crie uma consulta SQL que liste a quantidade de veículo por marca de veiculo;
*/

select 
	   marca,
       count(marca) as qtde
from veiculo
group by marca;

/*
	5 - Liste os proprietários que fazem aniversario nos próximos 45 dias, listar quando 
    será a data de aniversario, ordenado pela data de aniversario;
*/

select nome, dt_nascimento
from proprietario
where concat(year(now()), "-" ,month(dt_nascimento), "-" ,day(dt_nascimento)) between now() and date_add(now(), interval 45 day);

/*
	6 - Crie uma consulta SQL que liste todos os proprietários de veículos e seus 
    respectivos carros, o proprietário deve ser listado mesmo não tendo carro;
*/

select proprietario.nome as proprietario,
	   veiculo.modelo as veiculo
from veiculo
right join proprietario on
(veiculo.idproprietario = proprietario.idproprietario);

/*
	7 - Crie uma consulta SQL que liste todos os carros e seus respectivos proprietários, 
    ordenados por nome do proprietário;
*/

select veiculo.modelo as veiculo,
	   proprietario.nome as proprietario
from veiculo
inner join proprietario on
(veiculo.idproprietario = proprietario.idproprietario)
order by proprietario;

/*
	8 - Crie uma consulta SQL que liste todos os mecânicos cadastrados na oficina
*/

select nome
from mecanico;

/*
	9 - Crie uma consulta SQL que liste o nome e o valor de todos os produtos já 
    utilizados em um orçamento pela oficina;
*/

select  produto.nome as produto,
		produto.valor as valor
from item_produto
inner join produto on
(item_produto.idproduto = produto.idproduto)
group by produto
order by produto;

/*
	10 - Crie uma consulta SQL que liste todos os orçamentos realizadas 
    no carro com o código(IDVEICULO) igual à 3, você deve lista a 
    quantidade de serviço realizado e a soma total dos valores do serviço;
*/

select		servico.nome as servico,
			sum(item_servico.qtde) as qtde_servico,
			(sum(item_servico.qtde) * servico.valor) as valor
from item_servico
inner join servico on
(item_servico.idservico = servico.idservico)
inner join orcamento on
(item_servico.idorcamento = orcamento.idorcamento)
where orcamento.idveiculo = 3
group by servico;

/*
	11 - Crie uma consulta SQL que liste todos os orçamentos realizadas 
    no carro com o código(IDVEICULO) igual à 3, você deve lista a 
    quantidade de produto utilizado e a soma total de produto utilizado;
*/

select		produto.nome as produto,
			sum(item_produto.qtde) as qtde_servico,
			(sum(item_produto.qtde) * produto.valor) as valor
from item_produto
inner join produto on
(item_produto.idproduto = produto.idproduto)
inner join orcamento on
(item_produto.idorcamento = orcamento.idorcamento)
where orcamento.idveiculo = 2
group by produto;

/*
	12 - Crie uma consulta SQL que liste todas os orçamentos 
    realizadas no carro com o código(idcarro) igual à 2, liste 
    também o nome do mecânico responsável pela manutenção;
*/

select 	orcamento.idorcamento as codigo_orcamento,
		mecanico.nome as mecanico
from orcamento
inner join mecanico on
(orcamento.idmecanico = mecanico.idmecanico)
inner join veiculo on
(orcamento.idveiculo = veiculo.idveiculo)
where veiculo.idveiculo = 2;

/*
	13 - Crie uma consulta SQL que liste a quantidade de orçamentos por carro, 
    desde que o ano de fabricação seja 2014;
*/

select count(orcamento.idorcamento) as qtde,
	   veiculo.modelo as veiculo
from orcamento
inner join veiculo on
(orcamento.idveiculo = veiculo.idveiculo)
where veiculo.ano_fabricacao = 2014
group by veiculo;

/*
	14 - Crie uma consulta SQL que liste a media do valor pago em cada orçamento;
*/

select 	orcamento.idorcamento as codigo_orcamento,
		avg(((servico.valor * item_servico.qtde) + (produto.valor * item_produto.qtde))) as media
from orcamento
inner join item_produto on
(orcamento.idorcamento = item_produto.idorcamento)
inner join item_servico on
(orcamento.idorcamento = item_produto.idorcamento)
inner join servico on
(item_servico.idservico = servico.idservico)
inner join produto on
(item_produto.idproduto = produto.idproduto)
group by codigo_orcamento;

/*
	15 - Crie uma consulta SQL que liste a quantidade de orçamentos realizados 
    por mês e ano, a soma dos valores pagos, e a média paga em cada mês e ano;
*/

select 	month(dt_orcamento) as mes,
		year(dt_orcamento) as ano,
		count(orcamento.idorcamento) as qtde_orcamento,
        ((servico.valor * item_servico.qtde) + (produto.valor * item_produto.qtde)) as soma_valor,
        avg(((servico.valor * item_servico.qtde) + (produto.valor * item_produto.qtde))) as media
from orcamento
inner join item_produto on
(orcamento.idorcamento = item_produto.idorcamento)
inner join item_servico on
(orcamento.idorcamento = item_servico.idorcamento)
inner join produto on
(item_produto.idproduto = produto.idproduto)
inner join servico on
(item_servico.idservico = servico.idservico)
group by mes, ano
order by mes, ano;