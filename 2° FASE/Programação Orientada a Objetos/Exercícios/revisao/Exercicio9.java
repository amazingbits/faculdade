package revisao;

import java.util.Scanner;

public class Exercicio9 {

	public static void main(String[] args) {
		
		/**
		 * FA�A  UM  PROGRAMA  QUE RECEBA UMA  PALAVRA  DO  USU�RIO  E A APRESENTE  
		 * INVERTIDA (DE  TR�S  PARA FRENTE).
		 */
		
		Scanner teclado = new Scanner(System.in);
		
		System.out.println("Digite uma palavra: ");
		String palavra = teclado.next();
		
		for(int i = (palavra.length() - 1); i >= 0; i--) {
			System.out.print(palavra.substring(i,(i+1)));
		}
		
	}

}
