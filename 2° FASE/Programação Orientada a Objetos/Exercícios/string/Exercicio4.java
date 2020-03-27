package strings;

import java.util.Scanner;

public class Exercicio4 {

	public static void main(String[] args) {
		
		/**
		 * CRIE   UM   PROGRAMA ONDE   O   USUÁRIO   IRÁ   DIGITAR   UMA PALAVRA E  
		 * APRESENTE  AS   SEGUINTES INFORMAÇÕES:
		 * 
		 * 		A) O NÚMERO DE CARACTERES DA PALAVRA.
		 * 		B) A PALAVRA COM TODAS SUAS LETRAS EM MAIÚSCULO.
		 * 		C) O NÚMERO DE VOGAIS DA PALAVRA.
		 * 		D) SE A PALAVRA DIGITADA COMEÇA COMUM TERMO A SER DIGITADO PELO USUÁRIO
		 * 		E) SE A PALAVRA DIGITADA TERMINA COM UM TERMO A SER DIGITADO PELO USUÁRIO.
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
		
		System.out.println("Digite um termo para comparação: ");
		String letra = teclado.next();
		
		boolean inicio = palavra.startsWith(letra);
		boolean fim = palavra.endsWith(letra);
		
		String comeca = (inicio == true) ? "A palavra começa com "+letra : "A palavra não começa com "+letra;
		String termina = (fim == true) ? "A palavra termina com "+letra : "A palavra não termina com "+letra;
		
		System.out.println("Palavra: "+palavra);
		System.out.println("=====================");
		System.out.println("Número de caracteres da palavra: "+caracteres);
		System.out.println("Palavra em maiúsculo: "+maiusculo);
		System.out.println("Número de vogais: "+nr_vogais);
		System.out.println(comeca);
		System.out.println(termina);
		
	}

}
