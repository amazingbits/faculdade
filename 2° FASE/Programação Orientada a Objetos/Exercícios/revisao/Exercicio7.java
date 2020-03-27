package revisao;

import java.util.Scanner;

public class Exercicio7 {

	public static void main(String[] args) {
		
		/**
		 * DESENVOLVA UM  PROGRAMA  PARA  RECEBER  UM  TEXTO  DIGITADO  PELO  USUÁRIO  
		 * E  EXIBA  O  TEXTO  COM CADA PALAVRA EM UMA LINHA.
		 */
		
		Scanner teclado = new Scanner(System.in);
		
		System.out.println("Digite um texto qualquer:");
		String texto = teclado.nextLine();
		
		String[] palavra = texto.split(" ");
		
		for(int i = 0; i < palavra.length; i++) {
			System.out.println(palavra[i]);
		}

	}

}
