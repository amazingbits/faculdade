package revisao;

import java.util.Random;
import java.util.Scanner;

public class Exercicio13 {

	public static void main(String[] args) {
		
		/**
		 * DESENVOLVA UM  PROGRAMA  QUE  SIMULE  UM  JOGO  DE BASQUETE  ENTRE  DUAS  
		 * EQUIPES. CADA EQUIPE TEM  UMA  PROBABILIDADEDE  SUCESSO  E  DE  FALHA  NO SEU 
		 * ATAQUE (70/30). EM  CASO  DE  SUCESSO, CADA EQUIPE   TEM   UMA   PROBABILIDADE   
		 * DE REALIZAR   DOIS   OU   TRÊS   PONTOS (80/20). NÃO DEVERÁ   SER CONSIDERADO  
		 * NO  PROGRAMA  AS  QUESTÕES  DE  FALTAS, TROCAS  DE  JOGADORES  OU  SUSPENÇÕES. 
		 * CADA JOGADA COM SUCESSO  CONSOME UM TEMPO DE 30 SEGUNDOS, ENQUANTO AS JOGADAS 
		 * FALHAS CONSOMEM UM TEMPO DE 15 SEGUNDOS. PARA QUESTÃO ACADÊMICA, CONSIDERAR QUE 
		 * O JOGO POSSUI UM ÚNICO TEMPO DE 10 MINUTOS. O PROGRAMA  AINDA  DEVE  PERGUNTAR  
		 * AO  USUÁRIO O  NOME  DAS  DUAS  EQUIPES QUE REALIZARÃO O JOGO BEM COMO MOSTRAR O 
		 * PLACAR FINAL DA PARTIDA INDICANDO O GANHADOR.
		 */
		
		Scanner teclado = new Scanner(System.in);
		Random numero = new Random();
		
		double prob_ataque = 30; //70% sucesso || 30% da falha
		double prob_pontos = 20; //80% sucesso || 20% de falha
		
		double sucesso_tempo = 30; // 30 segundos
		double falha_tempo = 15; // 15 segundos
		
		double tempo_jogo = 0;
		double duracao_partida = 60 * 10; //10 minutos
		
		int ataque = 0;
		int pontos = 0;
		
		String[] equipes = new String[2];
		int[] placar = new int[2];
		
		for(int i = 0; i < equipes.length; i++) {
			System.out.println("Digite o nome da equipe "+(i+1)+":");
			equipes[i] = teclado.next();
		}
		
		while(tempo_jogo <= duracao_partida) {
			
			//ataque da equipe 1
			ataque = numero.nextInt(100) + 1;
			if(ataque <= prob_ataque) {
				//sucesso no ataque
				pontos = numero.nextInt(100) + 1;
				if(pontos <= prob_pontos) {
					placar[0] += 3;
				}else {
					placar[0] += 2;
				}
				tempo_jogo += 30;
			}else {
				//falha no ataque
				tempo_jogo += 15;
			}
			
			//ataque da equipe 2
			ataque = numero.nextInt(100) + 1;
			if(ataque <= prob_ataque) {
				//sucesso no ataque
				pontos = numero.nextInt(100) + 1;
				if(pontos <= prob_pontos) {
					placar[1] += 3;
				}else {
					placar[1] += 2;
				}
				tempo_jogo += 30;
			}else {
				//falha no ataque
				tempo_jogo += 15;
			}
		}
		
		//apresentando o resultado
		System.out.println("=====O RESULTADO DA PARTIDA====");
		System.out.println(equipes[0]+" "+placar[0]+" -- "+placar[1]+" "+equipes[1]);
		

	}

}
