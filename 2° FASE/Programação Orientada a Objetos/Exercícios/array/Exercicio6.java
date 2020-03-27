package array;

import java.util.Scanner;

public class Exercicio6 {

	public static void main(String[] args) {
		
		/**
		 * CRIE UM ARRAY DE INTEIROS DE TAMANHO 3,ONDE O USUÁRIO IRÁ 
		 * INFORMAR OS VALORES QUE DEVERÃO SER DE 1 A 9.OPROGRAMA DEVERÁ 
		 * IMPRIMIR NA TELA A TABUADA DOS NÚMEROS ARMAZENADOS NO ARRAY.
		 */
		
		int[] numero = new int[3];
		Scanner teclado = new Scanner(System.in);
		
		for(int i = 0; i < numero.length; i++) {
			System.out.println("Digite um número de 1 a 9: ");
			numero[i] = teclado.nextInt();
			if(numero[i] < 1 || numero[i] > 9) {
				System.out.println("Insira um número válido!");
				System.out.println();
				i--;
			}
			
		}
		
		for(int i = 0; i < numero.length; i++) {
			for(int j=1; j<=10; j++) {
				System.out.println(numero[i]+" X "+j+" = "+(numero[i] * j));
			}
			System.out.println();
			System.out.println();
		}

	}

}
