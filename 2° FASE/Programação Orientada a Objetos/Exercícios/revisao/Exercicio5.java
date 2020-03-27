package revisao;

import java.util.Random;

public class Exercicio5 {

	public static void main(String[] args) {
		
		/**
		 * CRIE  UM  PROGRAMA QUE  TENHA DUAS MATRIZES(A E B) DE  INTEIROS  COM  DIMENSÕES 4
		 * LINHAS  POR 4 COLUNAS. OS  NÚMEROS  DEVEM  SER FORNECIDOS  DE  FORMA ALEATÓRIA. O 
		 * PROGRAMA  DEVERÁ  CRIAR  UMA TERCEIRA MATRIZ (SUBTRACAO) QUE  DEVE  CONTER  A 
		 * SUBTRAÇÃO DA  POSIÇÃO DOS  ELEMENTOS  DAS MATRIZES “A” E “B”. APRESENTE OS VALORES 
		 * DASMATRIZES “A”, “B” E “SUBTRACAO”.
		 */
		
		int[][] a = new int[4][4];
		int[][] b = new int[4][4];
		int[][] subtracao = new int[4][4];
		Random numero = new Random();
		
		//MONTAGEM E APRESENTAÇÃO DA MATRIZ A
		System.out.println("MATRIZ A");
		System.out.println("=======");
		for(int i = 0; i < a.length; i++) {
			for(int j = 0; j < a[i].length; j++) {
				a[i][j] = numero.nextInt(9) + 1;
				System.out.print(""+a[i][j]+" ");
			}
			System.out.println();
		}
		System.out.println("=======");
		System.out.println();
		System.out.println();
		
		//MONTAGEM E APRESENTAÇÃO DA MATRIZ B
		System.out.println("MATRIZ B");
		System.out.println("=======");
		for(int i = 0; i < b.length; i++) {
			for(int j = 0; j < b[i].length; j++) {
				b[i][j] = numero.nextInt(9) + 1;
				System.out.print(""+b[i][j]+" ");
			}
			System.out.println();
		}
		System.out.println("=======");
		System.out.println();
		System.out.println();
		
		//MONTAGEM E APRESENTAÇÃO DA MATRIZ SUBTRAÇÃO
		System.out.println("MATRIZ SUBTRAÇÃO");
		System.out.println("=======");
		for(int i = 0; i < a.length; i++) {
			for(int j = 0; j < a[i].length; j++) {
				subtracao[i][j] = a[i][j] - b[i][j];
				System.out.print(""+subtracao[i][j]+" ");
			}
			System.out.println();
		}
		System.out.println("=======");

	}

}
