/*Primeiramente, executem o script do exercício no teams...*/
/* EX 04 - JOIN PASSO-A-PASSO */
use dbcantina;

/* 1- Com base no DER acima (ver slide do exercício) qual é a sintaxe do comando SQL para 
fazer um join entre a tabela cliente e pedido */
select *
from pedido
inner join cliente on
(pedido.idcliente = cliente.idcliente);

/* 2- Com base no DER acima (ver slide do exercício) qual é a sintaxe do comando SQL 
para fazer um join entre a tabela produto e item_pedido​ */
select * 
from item_pedido
inner join produto on 
(item_pedido.idproduto = produto.idproduto);

/* 3- Com base no DER acima qual é a sintaxe do comando SQL para fazer um join 
entre a tabela pedido e item_pedido​ */
select *
from item_pedido
inner join pedido on
(item_pedido.idpedido = pedido.idpedido);

/* 4- Com base no DER acima qual é a sintaxe do comando SQL para fazer um 
join entre a tabela pedido, item_pedido e produto​ */
select *
from item_pedido
inner join pedido on
(item_pedido.idpedido = pedido.idpedido)
inner join produto on
(item_pedido.idproduto = produto.idproduto);

/* 5- Com base no DER acima qual é a sintaxe do comando SQL para fazer um 
join entre a tabela cliente, pedido e item_pedido */
select *
from item_pedido
inner join pedido on
(item_pedido.idpedido = pedido.idpedido)
inner join cliente on
(pedido.idcliente = cliente.idcliente);

/* 6- Com base no DER acima qual é a sintaxe do comando SQL para fazer 
um join entre a tabela cliente, pedido, item_pedido e produto​ */
select *
from item_pedido
inner join produto on
(item_pedido.idproduto = produto.idproduto) 
inner join pedido on
(item_pedido.idpedido = pedido.idpedido) 
inner join cliente on
(pedido.idcliente = cliente.idcliente);

/* 7- Crie uma consulta SQL para listar o sexo e a quantidade de cliente com cada sexo */
select sexo,
	   count(idcliente) as qtde
from cliente
group by sexo;

/* 8- Crie uma consulta SQL para listar o nome do produto e o preco do produto, 
ordene o resultado categoria do produto em seguida pelo nome do produto */
select nome, preco, categoria
from produto
group by nome
order by categoria;

/* 9- Crie uma consulta SQL para listar a categoria do produto, a quantidade de 
produto e a media dos valores dos produtos de cada categoria, ordenado 
pelo nome da categoria​ */
select categoria,
	   count(idproduto) as qtde_produto,
	   avg(preco) as media
from produto
group by categoria
order by categoria;

/* 10- A tabela item_pedido armazena a quantidade que 
cada produto foi vendida nos pedidos, sendo assim, crie uma consulta SQL 
para listar o código identificador do produto, a quantidade de 
itens vendido, o valor de cada produto​ */
select produto.idproduto as codigo,
       produto.nome as nome,
	   sum(item_pedido.qtde) as qtde_produtos_vendidos,
       produto.preco as preco_unitario,
       sum((item_pedido.preco_unitario * item_pedido.qtde)) as soma_total
from item_pedido
inner join produto on
(item_pedido.idproduto = produto.idproduto)
group by produto.idproduto
order by produto.nome;

/* 11- Para saber o valor total de um item em um pedido você deve multiplicar 
o preco_unitario pela quantidade na tabela de item_pedido, sendo assim, crie uma 
consulta SQL para listar o codido do pedido, o código do produto, o preço unitário, 
a quantidade vendida e o valor total do item. Ordene o resultado pelo código do 
pedido e pelo código do produto ​ */
select item_pedido.idpedido as codigo_pedido,
	   produto.idproduto as codigo_produto,
       produto.preco as preco_unitario,
       sum(item_pedido.qtde) as quantidade_vendida,
       sum(item_pedido.preco_unitario * item_pedido.qtde) as valor_total
from item_pedido
inner join produto on
(item_pedido.idproduto = produto.idproduto)
group by produto.idproduto
order by item_pedido.idpedido, produto.idproduto;

/* 12- Crie uma consulta SQL para listar a quantidade de pedido (para pegar 
a quantidade correta de pedido use count(distinct idpedido), a media de item vendido, 
e o valor total médio​ */
/* utilizei a propriedade "Format" como exemplo neste pra mostrar que os números podem
vir formatados... formatei as médias com duas casas decimais, por exemplo: FORMAT(10,2)
retornará 10.00*/
select idproduto,
	   count(distinct idpedido) as qtde_pedido,
       format(avg(qtde),2) as media_item_vendido,
       format(avg(preco_unitario * qtde),2) as valor_total_medio
from item_pedido
group by idproduto
order by idproduto;

/* 13- Crie uma consulta SQL para listar todos os pedidos do cliente com código 
identificador igual 3​ */
select *
from pedido
inner join cliente on
(pedido.idcliente = cliente.idcliente)
where cliente.idcliente = 3;

/* 14- Crie uma consulta SQL para listar o código identificador do cliente, o 
nome do cliente e a quantidade de pedido de cada cliente */
select cliente.idcliente as codigo_cliente,
	   cliente.nome as nome_cliente,
	   count(pedido.idpedido) as qtde_pedido
from pedido
inner join cliente on
(pedido.idcliente = cliente.idcliente)
group by cliente.idcliente;

/* 15- Crie uma consulta SQL para listar o código identificador do cliente, o nome 
do cliente e a quantidade de pedido de cada cliente. Caso o cliente não tenha pedido 
ele deve listado também​ */
select cliente.idcliente as codigo_cliente,
	   cliente.nome as nome_cliente,
	   count(pedido.idpedido) as qtde_pedido
from pedido
right join cliente on
(pedido.idcliente = cliente.idcliente)
group by cliente.idcliente;

/* 16- Crie uma consulta SQL para listar o código identificador do produto, o nome do 
produto, a quantidade de pedidos únicos (distinct), a quantidade vendida de produtos e a 
media de produtos vendidos por pedido. Ordene o resultado pelo nome quantidade vendida de 
produtos decrescente​ */
select produto.idproduto as codigo_produto,
	   produto.nome as nome_produto,
       count(distinct item_pedido.idpedido) as qtde_pedidos_unicos,
       sum(item_pedido.qtde) as qtde_vendida,
       format(avg(item_pedido.qtde * item_pedido.preco_unitario),2) as media_prod_vendidos
from item_pedido
inner join produto on
(item_pedido.idproduto = produto.idproduto)
group by produto.idproduto
order by produto.nome, qtde_vendida desc;

/* 17- Crie uma consulta SQL para listar o nome do produto e a quantidade vendida. Mesmo que o 
produto não tenha nenhuma venda ele deve ser listado na consulta​ */
select produto.nome as nome,
	   sum(item_pedido.qtde) as qtde_vendida
from item_pedido
right join produto on
(item_pedido.idproduto = produto.idproduto)
group by produto.idproduto;

/* 18- Crie uma consulta SQL para lista o código identificador do cliente, o nome do cliente 
e a quantidade de pedido do cliente, liste apenas os clientes que tem mais de 5 pedidos, ordene 
pela quantidade de pedido de forma decrescente​ */
select cliente.idcliente as cod_cliente,
	   cliente.nome as nome_cliente,
       count(item_pedido.idpedido) as qtde_pedido
from item_pedido
inner join pedido on
(item_pedido.idpedido = pedido.idpedido)
inner join cliente on
(pedido.idcliente = cliente.idcliente)
group by cod_cliente
having qtde_pedido > 5;

/* 19- Crie uma consulta SQL para listar o código identificador do pedido, data do pedido, o 
código identificador do cliente, nome do cliente, o código identificador do produto, nome do produto, 
preço unitário do produto, quantidade vendida e o valor total do produto, listando apenas o pedido 
com código identificador igual a 10​ */
select pedido.idpedido as cod_pedido,
	   pedido.dtpedido as data_pedido,
       cliente.idcliente as cod_cliente,
       cliente.nome as nome_cliente,
       produto.idproduto as cod_produto,
       produto.nome as nome_produto,
       produto.preco as preco_unitario,
       sum(item_pedido.qtde) as qtde_vendida,
       sum(item_pedido.qtde * item_pedido.preco_unitario) as valor_total
from item_pedido
inner join produto on
(item_pedido.idproduto = produto.idproduto)
inner join pedido on
(item_pedido.idpedido = pedido.idpedido)
inner join cliente on
(pedido.idcliente = cliente.idcliente)
where pedido.idpedido = 10
group by item_pedido.idproduto;

/* 20- Crie uma consulta SQL que liste o sexo do cliente, a categoria do produto e a quantidade de 
produto vendidos​ */
select cliente.sexo as sexo_cliente,
	   produto.categoria as cat_produto,
       sum(item_pedido.qtde) as qtde_vendidos
from item_pedido
inner join produto on
(item_pedido.idproduto = produto.idproduto)
inner join pedido on
(item_pedido.idpedido = pedido.idpedido)
inner join cliente on
(pedido.idcliente = cliente.idcliente)
group by cliente.idcliente;