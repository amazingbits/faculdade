package revisao;

import java.util.Arrays;
import java.util.Random;

public class Exercicio11 {

	public static void main(String[] args) {
		
		/**
		 * CRIE  UM  PROGRAMA  QUE LEIAUM  CONJUNTO  DE 10NÚMEROS  INTEIROS  
		 * DEFORMA  ALEATÓRIA  E APRESENTE-O DE FORMA ORDENADA (ORDENAÇÃO CRESCENTE).
		 */
		
		Random numeros = new Random();
		int[] n = new int[10];
		
		for(int i = 0; i < n.length; i++) {
			n[i] = numeros.nextInt(50) + 1;
		}
		
		Arrays.sort(n);
		
		System.out.print("[");
		for(int i = 0; i < n.length; i++) {
			System.out.print(n[i]+" ");
		}
		System.out.print("]");

	}

}
