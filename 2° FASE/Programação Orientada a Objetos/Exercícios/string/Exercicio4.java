package strings;

import java.util.Scanner;

public class Exercicio4 {

	public static void main(String[] args) {
		
		/**
		 * CRIE   UM   PROGRAMA ONDE   O   USU�RIO   IR�   DIGITAR   UMA PALAVRA E  
		 * APRESENTE  AS   SEGUINTES INFORMA��ES:
		 * 
		 * 		A) O N�MERO DE CARACTERES DA PALAVRA.
		 * 		B) A PALAVRA COM TODAS SUAS LETRAS EM MAI�SCULO.
		 * 		C) O N�MERO DE VOGAIS DA PALAVRA.
		 * 		D) SE A PALAVRA DIGITADA COME�A COMUM TERMO A SER DIGITADO PELO USU�RIO
		 * 		E) SE A PALAVRA DIGITADA TERMINA COM UM TERMO A SER DIGITADO PELO USU�RIO.
		 */
		
		Scanner teclado = new Scanner(System.in);
		
		System.out.println("Digite uma palavra: ");
		String palavra = teclado.nextLine();
		
		int caracteres = palavra.length();
		String maiusculo = palavra.toUpperCase();
		
		char[] letras = new char[palavra.length()];
		letras = palavra.toCharArray();
		
		int nr_vogais = 0;
		for(int i = 0; i < letras.length; i++) {
			char cont = maiusculo.charAt(i);
			if(cont == 'A' || cont == 'E' || cont == 'I' || cont == 'O' || cont == 'U') {
				nr_vogais++;
			}
		}
		
		System.out.println("Digite um termo para compara��o: ");
		String letra = teclado.next();
		
		boolean inicio = palavra.startsWith(letra);
		boolean fim = palavra.endsWith(letra);
		
		String comeca = (inicio == true) ? "A palavra come�a com "+letra : "A palavra n�o come�a com "+letra;
		String termina = (fim == true) ? "A palavra termina com "+letra : "A palavra n�o termina com "+letra;
		
		System.out.println("Palavra: "+palavra);
		System.out.println("=====================");
		System.out.println("N�mero de caracteres da palavra: "+caracteres);
		System.out.println("Palavra em mai�sculo: "+maiusculo);
		System.out.println("N�mero de vogais: "+nr_vogais);
		System.out.println(comeca);
		System.out.println(termina);
		
	}

}
