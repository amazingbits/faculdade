package revisao;

import java.util.Random;

public class Exercicio2 {

	public static void main(String[] args) {
		
		/**
		 * CRIE UM PROGRAMA PARALER 5 NÚMEROS INTEIROS DEFORMA ALEATÓRIA E ARMAZENÁ-LOS 
		 * EM UM ARRAY DE  NOME “NUMEROS”.CONSTRUA  UM  SEGUNDO ARRAY  DE  MESMAS  
		 * DIMENSÕES  PREENCHIDOS  COMOS VALORES  DO ARRAY “NUMEROS” MULTIPLICADO  POR 2 
		 * SE  O  NÚMERO  FOR  PAR E  POR 3 SE O  NÚMERO  FOR ÍMPAR. APRESENTAR OS ELEMENTOS 
		 * DOS DOIS ARRAYS.
		 */
		
		int[] numeros = new int[5];
		int[] multiplicados = new int[5];
		Random numero = new Random();
		
		for(int i = 0; i < numeros.length; i++) {
			numeros[i] = numero.nextInt(20) + 1;
			if(numeros[i] % 2 == 0) {
				multiplicados[i] = numeros[i] * 2;
			}else {
				multiplicados[i] = numeros[i] * 3;
			}
		}
		
		System.out.print("Array NÚMEROS: [");
		for(int i = 0; i < numeros.length; i++) {
			if(i == (numeros.length - 1)) {
				System.out.print(numeros[i]);
			}else {
				System.out.print(numeros[i]+", ");
			}
		}
		System.out.print("]");
		
		System.out.println();
		
		System.out.print("Array MULTIPLICADOS: [");
		for(int i = 0; i < multiplicados.length; i++) {
			if(i == (multiplicados.length - 1)) {
				System.out.print(multiplicados[i]);
			}else {
				System.out.print(multiplicados[i]+", ");
			}
		}
		System.out.print("]");

	}

}
