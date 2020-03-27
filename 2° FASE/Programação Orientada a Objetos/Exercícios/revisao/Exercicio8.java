package revisao;

import java.util.Scanner;

public class Exercicio8 {

	public static void main(String[] args) {
		
		/**
		 * FAÇA  UM  PROGRAMA  QUE RECEBA  UMA  PALAVRA  DO  USUÁRIO  E  A 
		 *  DEMONSTRE  CONFORME  O  EXEMPLO ABAIXO:
		 *  
		 *  J
		 *  JA
		 *  JAV
		 *  JAVA
		 *  JAV
		 *  JA
		 *  J
		 */
		
		Scanner teclado = new Scanner(System.in);
		
		System.out.println("Digite uma palavra:");
		String palavra = teclado.next();
		
		for(int i = 1; i <= palavra.length(); i++) {
			System.out.println(palavra.substring(0,i));
		}
		
		for(int i = (palavra.length() - 1); i >= 1; i--) {
			System.out.println(palavra.substring(0,i));
		}
		
	}

}
