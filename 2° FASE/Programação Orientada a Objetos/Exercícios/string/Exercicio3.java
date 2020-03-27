package strings;

import java.util.Scanner;

public class Exercicio3 {

	public static void main(String[] args) {
		
		/**
		 * CRIE  UM  PROGRAMA ONDE  O  USU�RIO  IR�  DIGITAR  UMA  FRASEE  O PROGRAMA 
		 * IR�  CONTABILIZAR A QUANTIDADE   DE   CADA   VOGAL DA   FRASE DIGITADA. 
		 * CONSIDERE   QUE A   FRASE   N�O   POSSUA   NENHUMA ACENTUA��O. POR FIM 
		 * APRESENTE A FRASE E A QUANTIDADE DE CADA VOGAL.
		 */
		
		Scanner teclado = new Scanner(System.in);
		int nr_vogal = 0;
		
		System.out.println("Digite uma frase: ");
		String frase = teclado.nextLine();
		
		//remover caracteres acentuados
		String frase_normal = frase.replaceAll("[��������������������������������������������������������������]", "");
		
		char[] letras = new char[frase_normal.length()];
		letras = frase_normal.toCharArray();
		
		for(int i = 0; i < letras.length; i++) {
			
			char cont = frase_normal.toLowerCase().charAt(i);
			if(cont == 'a' || cont == 'e' || cont == 'i' || cont == 'o' || cont == 'u') {
				nr_vogal++;
			}
		}
		
		System.out.println("A frase: "+frase_normal);
		System.out.println("N�mero de vogais: "+nr_vogal);

	}

}
