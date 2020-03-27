use dblocadora;

/* 01
Construa uma consulta SQL para listar o código identificador do cliente, 
o nome do cliente e carro locado por esse cliente (Listar a marca, o 
modelo, a placa do carro e a data de locação)​
*/

select cliente.idcliente as codigo,
	   cliente.nome as nome,
	   veiculo.marca as marca,
       veiculo.modelo as modelo,
       locacao.dt_locacao as data_locacao
from locacao
inner join cliente on
(locacao.idcliente = cliente.idcliente)
inner join veiculo on
(locacao.idveiculo = veiculo.idveiculo);

/* 02
Construa uma consulta SQL para listar o código identificador do 
veículo, marca do veículo, modelo do veículo e a quantidade de 
locação de cada veiculo;​
*/

select veiculo.idveiculo as codigo_veiculo,
	   veiculo.marca as marca,
       veiculo.modelo as modelo,
       count(locacao.idlocacao) as qtde
from locacao
inner join veiculo on
(locacao.idveiculo = veiculo.idveiculo)
group by marca,
		 modelo,
		 codigo_veiculo;
         
/* 03
Construa uma consulta SQL que liste o código identificador do cliente, 
o nome do cliente e a quantidade de quilômetros percorridos (para 
encontrar a quilometragem percorrida, você deve subtrair a km da locação 
da km da entrega);​
*/

select cliente.idcliente as codigo_cliente,
	   cliente.nome as nome_cliente,
       (locacao.km_entrega - locacao.km_locacao) as km_percorridos
from locacao
inner join cliente on
(locacao.idcliente = cliente.idcliente);

/* 04
Construa uma consulta SQL para listar todos os veículos que não 
possuem nenhum opcional;​
*/

select veiculo.marca as marca,
	   veiculo.modelo as modelo
from veiculo
left outer join opcional_veiculo on
(veiculo.idveiculo = opcional_veiculo.idveiculo)
where opcional_veiculo.idveiculo is null;

/* 05
Construa uma consulta SQL para listar o código identificador 
de cada veículo,  a marca do veículo, o modelo do veículo, a 
quantidade de locação de cada veiculo e a soma das quilometragens 
usada em cada veículo;
*/

select veiculo.idveiculo as codigo_veiculo,
	   veiculo.marca as marca,
       veiculo.modelo as modelo,
       count(locacao.idlocacao) as qtde_locacao,
       sum(locacao.km_entrega - locacao.km_locacao) as soma_km
from locacao
inner join veiculo on
(locacao.idveiculo = veiculo.idveiculo)
group by codigo_veiculo,
		 marca,
         modelo;

/* 06
Construa uma consulta SQL para listar os seguintes dados: código 
identificador do cliente, nome do cliente, telefone celular do 
cliente, data da locação, marca do veículo locado, modelo do veículo 
locado e nome do funcionário responsável pela locação;​
*/

select cliente.idcliente as codigo_cliente,
	   cliente.nome as nome_cliente,
       cliente.fone_celular as celular_cliente,
       locacao.dt_locacao as data_locacao,
       veiculo.marca as marca,
       veiculo.modelo as modelo,
       funcionario.nome as funcionario
from locacao
inner join cliente on 
(locacao.idcliente = cliente.idcliente)
inner join veiculo on 
(locacao.idveiculo = veiculo.idveiculo)
inner join funcionario on 
(locacao.idfuncionario = funcionario.idfuncionario);

/* 07
Construa uma consulta SQL para listar a quantidade de 
locação por dia da semana (para descobrir o dia da semana 
utilize a função dayofweek passando a data de locação 
como parametro);​
*/

select dayofweek(dt_locacao) as dia_semana,
	   count(idlocacao) as qtde_locacao
from locacao
group by dia_semana;

/* 08
Construa uma consulta SQL para listar a quilometragem média 
(somando todos os veículos) por mês e ano (para descobrir o 
mês de uma data utilize a função month, para descobrir o ano 
utilize a função year)​
*/

select avg(locacao.km_entrega - locacao.km_locacao) as km_media,
	   month(locacao.dt_locacao) as mes,
       year(locacao.dt_locacao) as ano
from locacao
group by mes, ano
order by mes, ano;

/* 09
Construa uma consulta SQL para listar o tempo médio em dias 
de locação (para descobrir o tempo de locação utilize a função 
datediff passando como parâmetro a data de locação e a data de 
entrega);​
*/

select 	veiculo.marca as marca,
		veiculo.modelo as modelo,
		format(avg(datediff(locacao.dt_entrega, locacao.dt_locacao)),2) as tempo_medio
from locacao
inner join veiculo on
(locacao.idveiculo = veiculo.idveiculo)
group by marca, modelo;

/* 10
Construa uma consulta SQL para listar a quilometragem média de locação;​
*/

/*por veículo*/
select 	veiculo.marca as marca,
		veiculo.modelo as modelo,
        format(avg(km_locacao),2) as media
from locacao inner join veiculo on
(locacao.idveiculo = veiculo.idveiculo)
group by marca, modelo;

/* 11
Construa uma consulta SQL a quantidade de locação por opcional de veículo;​
*/

select 	opcional.descricao as opcional,
		count(locacao.idlocacao) as qtde
from locacao
inner join veiculo on
(locacao.idveiculo = veiculo.idveiculo)
inner join opcional_veiculo on
(veiculo.idveiculo = opcional_veiculo.idveiculo)
inner join opcional on
(opcional_veiculo.idopcional = opcional.idopcional)
group by opcional;

/* 12
Construa uma consulta SQL que liste o valor a pagar por 
cada km, a quantidade de km utilizado e o valor total a pagar 
por cada locação;​
*/

select 
		tabela.valor as valor_km,
		format((locacao.km_entrega - locacao.km_locacao),2) as km_utilizado,
		format((tabela.valor * (locacao.km_entrega - locacao.km_locacao)),2) as total
from locacao
inner join tabela_veiculo on
(locacao.idveiculo = tabela_veiculo.idveiculo)
inner join tabela on
(tabela_veiculo.idtabela = tabela.idtabela)
where tabela.tipo = "km";

/* 13
Construa uma consulta SQL que liste o valor a pagar por 
dia, a quantidade de dias utilizado e o valor total a pagar 
por cada locação;​
*/

select 	tabela.valor as valor_km,
		datediff(locacao.dt_entrega, locacao.dt_locacao) as dias,
        (datediff(locacao.dt_entrega, locacao.dt_locacao) * tabela.valor) as total
from locacao
inner join veiculo on
(locacao.idveiculo = veiculo.idveiculo)
inner join tabela_veiculo on 
(veiculo.idveiculo = tabela_veiculo.idveiculo)
inner join tabela on
(tabela_veiculo.idtabela = tabela.idtabela)
where tabela.tipo = "dia";