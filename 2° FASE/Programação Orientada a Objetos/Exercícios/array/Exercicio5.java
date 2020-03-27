package array;

import java.util.Random;

public class Exercicio5 {

	public static void main(String[] args) {
		
		/**
		 * CRIAR UMARRAY “ORIGEM”COM 10 ELEMENTOS INTEIROS.CONSTRUIR UM 
		 * ARRAY “RESULTADO” DE MESMO TIPO E TAMANHO, OBEDECENDO AS SEGUINTES 
		 * REGRAS: 
		 * 		• “RESULTADO”RECEBE O VALOR 1QUANDO “ORIGEM”FOR PAR;
		 * 		• “RESULTADO”RECEBE O VALOR 0QUANDO “ORIGEM”FOR ÍMPAR;
		 */
		
		int[] origem = new int[10];
		int[] resultado = new int[10];
		Random numero = new Random();
		
		for(int i = 0; i < origem.length; i++) {
			
			origem[i] = numero.nextInt(50) + 1;
			
			if(origem[i] % 2 == 0) {
				resultado[i] = 1;
			}else {
				resultado[i] = 0;
			}
			
		}
		
		for(int i = 0; i < origem.length; i++) {
			System.out.println(origem[i]+" - "+resultado[i]);
		}
		

	}

}
