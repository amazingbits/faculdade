package strings;

import java.util.Scanner;

public class Exercicio2 {

	public static void main(String[] args) {
		
		/**
		 * CRIE  UM PROGRAMA  ONDEO  USU�RIO  IR�  DIGITAR  UMA  FRASE. DEPOIS  
		 * O PROGRAMA DEVER� SOLICITAR QUE  O USU�RIO  DIGITE  UMA PALAVRA. O 
		 * PROGRAMA  DEVE  APRESENTAR  A  FRASE  DIGITADA, A  PALAVRA DIGITADA, 
		 * BEM COMO A QUANTIDADE DE VEZES QUE A PALAVRA DIGITADA APARECE NA FRASE.
		 */
		
		Scanner teclado = new Scanner(System.in);
		int ocorrencia = 0;
		
		System.out.println("Digite uma frase: ");
		String frase = teclado.nextLine();
		
		System.out.println("Agora digite uma palavra: ");
		String palavra = teclado.nextLine();
		
		String[] palavras = frase.split(" ");
		
		for(int i = 0; i < palavras.length; i++) {
			if(palavras[i].compareTo(palavra) == 0) {
				ocorrencia++;
			}
		}
		
		System.out.println("A frase: "+frase);
		System.out.println("A palavra: "+palavra);
		System.out.println("Ocorr�ncias: "+ocorrencia);

	}

}
