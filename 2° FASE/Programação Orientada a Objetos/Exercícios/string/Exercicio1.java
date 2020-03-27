package strings;

import java.util.Scanner;

public class Exercicio1 {

	public static void main(String[] args) {
		
		/**
		 * CRIE UM  PROGRAMA  QUE,A  PARTIR  DE  UM  TEXTO  DIGITADO  PELO  
		 * USU�RIO, CONTE  O  N�MERO DE PALAVRAS E EXIBA O RESULTADO
		 */
		
		Scanner teclado = new Scanner(System.in);
		String texto = new String();
		
		System.out.print("Digite um texto qualquer: ");
		texto = teclado.nextLine();
		
		//um pequeno tratamento na frase aonde eu tiro os n�meros, pontos e v�rgulas
		String texto_atualizado = texto.replaceAll("[0-9,.]", "");
		
		String[] palavras = texto_atualizado.split(" ");
		
		System.out.println("Frase: "+texto_atualizado);
		System.out.println("Esta frase tem "+palavras.length+" palavra(s).");

	}

}
