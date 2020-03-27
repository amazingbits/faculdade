package revisao;

import java.util.Scanner;

public class Exercicio9 {

	public static void main(String[] args) {
		
		/**
		 * FAÇA  UM  PROGRAMA  QUE RECEBA UMA  PALAVRA  DO  USUÁRIO  E A APRESENTE  
		 * INVERTIDA (DE  TRÁS  PARA FRENTE).
		 */
		
		Scanner teclado = new Scanner(System.in);
		
		System.out.println("Digite uma palavra: ");
		String palavra = teclado.next();
		
		for(int i = (palavra.length() - 1); i >= 0; i--) {
			System.out.print(palavra.substring(i,(i+1)));
		}
		
	}

}
