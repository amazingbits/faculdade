use dbquiz;

/* 1.Escreva os comandos SQL para listar os dados da tabela QUIZ; */
select * from quiz;

/* 2. Escreva os comandos SQL para listar somente ENUNCIADO da tabela PERGUNTA; */
select enunciado from pergunta;

/* 3. Escreva os comandos SQL para listar o NOME e o EMAIL de todos os participantes cadastrados; */
select nome, email from participante;

/* 4. Escreva os comandos SQL para listar todas as perguntas que estão ativas hoje; */
select *
from pergunta
where dtinicial <= now() and dtfinal >= now();

/* 5. Usando o comando IN escreva os comandos SQL que liste todas as OPCAO que foram usadas 
em alguma resposta por algum participante; */
select *
from opcao
where idopcao in (select idopcao from resposta);

/* 6. Escreva os comandos SQL para listar a maior data final de uma pergunta; */
select max(dtfinal) as maior_dtfinal from pergunta;

/* 7. Escreva os comandos SQL que listem a quantidades de OPCAO por pergunta cadastrada (group by); */
select
	idpergunta as pergunta,
    count(idpergunta) as opcoes
from opcao
group by pergunta;

/* 8. Escreva os comandos SQL para listar as perguntas que tem menos de 4 opções de respostas 
cadastradas (group by e having); */
select 	pergunta.idpergunta as idpergunta,
		pergunta.enunciado as pergunta,
		count(opcao.idopcao) as opcoes
from opcao
inner join pergunta on
(opcao.idpergunta = pergunta.idpergunta)
group by opcao.idpergunta
having opcoes < 4;

/* 9. Escreva os comandos SQL que listem todas as PERGUNTAS que ainda não iniciaram; */
select * from pergunta where dtinicial > now();

/* 10. Escreva os comandos SQL para listar os participantes que não tem e-mail válido (sem “@”); */
select * from participante where not email like "%@%";

/* 11. Escreva os comandos SQL para listar todas as opções da pergunta 1; */
select 	idopcao,
		texto as opcao
from opcao
where idpergunta = 1
order by idopcao;

/* 12. Escreva os comandos SQL para listar a quantidade de resposta por pergunta e por participante; */
select 	idpergunta as pergunta,
		idparticipante as participante,
		count(distinct idpergunta) as qtde_resposta
from resposta
group by idparticipante, idpergunta;

/* 13. Use a consulta anterior e adicione um filtro no resultado para listar os resultados referente à 
pergunta 1; */
select 	idpergunta as pergunta,
		idparticipante as participante,
		count(distinct idpergunta) as qtde_resposta
from resposta
where idpergunta = 1
group by idparticipante, idpergunta;

/* 14. Escreva os comandos SQL para listar todos os QUIZ cadastrados, mas caso a coluna tipo 
tenha valor igual a“P”, mostre no lugar “Quiz para pesquisa de preferência”, caso o valor 
seja “T”, mostre no lugar “Quiz para teste de conhecimento”, caso contrário mostre a 
mensagem “Não identificado”; */
select
		idquiz,
        titulo,
        descricao,
		case tipo
			when "TESTE" then "Quiz para teste de conhecimento"
            when "PESQUISA" then "Quiz para pesquisa de preferência"
            else "Não identificado"
		end as tipo        
from quiz;

/* 15. Escreva os comandos SQL para listar o nome de todos os participantes em letras maiúsculas, 
mas liste somente os participantes que não participaram de nenhum Quiz;  */
select upper(nome) as participante
from participante
where idparticipante not in (select idparticipante from resposta);

/* 16. Escreva os comandos SQL para listar o QUIZ com IDQUIZ = 2, as perguntas que pertencem esse QUIZ 
e as opções de resposta. */
select 	pergunta.idquiz as idquiz,
		pergunta.enunciado as perguntas,
		group_concat(opcao.texto) as opcoes
from pergunta
inner join opcao on
(pergunta.idpergunta = opcao.idpergunta)
where pergunta.idquiz = 2
group by pergunta.enunciado;

/* 17. Escreva os comandos SQL para listar todas as participações, coloque o nome e o 
e-mail do participante, a resposta escolhida, o enunciado da pergunta e o titulo e 
a descrição do QUIZ */
select 	quiz.titulo as quiz_titulo,
		quiz.descricao as quiz_descricao,
		participante.nome as participante,
		participante.email as email,
        pergunta.enunciado as pergunta,
        opcao.texto as resposta_escolhida
from pergunta
inner join opcao on
(pergunta.idpergunta = opcao.idpergunta)
inner join resposta on
(pergunta.idpergunta = resposta.idpergunta)
inner join participante on
(resposta.idparticipante = participante.idparticipante)
inner join quiz on
(pergunta.idquiz = quiz.idquiz)
group by pergunta.idquiz, pergunta.idpergunta, participante.idparticipante;

/* 18. Escreva os comandos SQL para listar somente as respostas certas, desde que o QUIZ seja 
do tipo “T”.Liste o código da pergunta, o enunciado, e todos os dados da opção. */
select 	pergunta.idpergunta as codigo_pergunta,
		pergunta.enunciado as enunciado,
        opcao.texto as opcao,
        opcao.certa as certa
from resposta
inner join opcao on
(resposta.idopcao = opcao.idopcao)
inner join pergunta on 
(resposta.idpergunta = pergunta.idpergunta)
inner join quiz on
(pergunta.idquiz = quiz.idquiz)
where opcao.certa = "SIM" and quiz.tipo = "TESTE";

/* 19. Escreva os comandos SQL para listar somente as respostas erradas, desde que o QUIZ 
seja do tipo “T”.Liste o código da pergunta, o enunciado, e todos os dados da opção, ordem 
pelo comando “rand()”, para que o resultado seja aleatório. */
select 	pergunta.idpergunta as codigo_pergunta,
		pergunta.enunciado as enunciado,
        opcao.texto as opcao,
        opcao.certa as certa
from resposta
inner join opcao on
(resposta.idopcao = opcao.idopcao)
inner join pergunta on 
(resposta.idpergunta = pergunta.idpergunta)
inner join quiz on
(pergunta.idquiz = quiz.idquiz)
where opcao.certa = "NÃO" and quiz.tipo = "TESTE"
order by rand();