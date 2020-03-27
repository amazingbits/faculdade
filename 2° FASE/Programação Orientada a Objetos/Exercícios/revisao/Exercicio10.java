package revisao;

import java.util.Scanner;

public class Exercicio10 {

	public static void main(String[] args) {
		
		/**
		 * FAÇA UM  PROGRAMA  QUE  RECEBA  ONOME  DE  UMA PESSOA E  O APRESENTE CONFORME 
		 * A  FORMATAÇÃO DE AUTORES EM REFERÊNCIAS BIBLIOGRÁFICAS. 
		 * 
		 * EXEMPLO: 
		 * 
		 * NOME: CARLOS ROBERTO ANDRADE 
		 * 
		 * APRESENTAR DA SEGUINTE MANEIRA:
		 * 
		 * ANDRADE, CARLOS ROBERTO.
		 */
		
		Scanner teclado = new Scanner(System.in);
		
		System.out.println("Digite um nome:");
		String nome = teclado.nextLine();
		
		String[] palavra = nome.split(" ");
		
		System.out.print(palavra[(palavra.length - 1)].toUpperCase()+", ");
		for(int i = 0; i < (palavra.length - 1); i++) {
			System.out.print(palavra[i]+" ");
		}

	}

}
