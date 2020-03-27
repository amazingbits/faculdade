package revisao;

import java.util.Scanner;

public class Exercicio4 {

	public static void main(String[] args) {
		
		/**
		 * CRIE  UM  PROGRAMA  QUE LEIA  O  NOME E A IDADE  DE 10 PESSOAS. DEPOIS  
		 * O  SISTEMA  DEVE IMPRIMIR  O NOME E A IDADE DA PESSOA QUE TIVER A MENOR E 
		 * A MAIOR IDADE. ALÉM DISSO O SISTEMA DEVE INFORMAR A MÉDIA DAS IDADES.
		 */
		
		int[] idade = new int[10];
		String[] nome = new String[10];
		Scanner teclado = new Scanner(System.in);
		
		int menor_idade = 99999;
		int maior_idade = 0;
		double total_idade = 0;
		
		for(int i = 0; i < idade.length; i++) {
			System.out.println("======FORMULÁRIO NÚMERO "+(i+1)+" =======");
			System.out.println();
			System.out.println("Digite o nome: ");
			nome[i] = teclado.next();
			System.out.println("Digite a idade: ");
			idade[i] = teclado.nextInt();
			System.out.println();
			System.out.println("================================");
			
			if(idade[i] < menor_idade) {
				menor_idade = idade[i];
			}
			
			if(idade[i] > maior_idade) {
				maior_idade = idade[i];
			}
			
			total_idade += idade[i];
		}
		
		double media = total_idade / (double)idade.length;
		
		for(int i = 0; i < idade.length; i++) {
			System.out.println("========REGISTRO N° "+(i+1)+"=========");
			System.out.println("Nome: "+nome[i]);
			System.out.println("Idade: "+idade[i]);
			System.out.println("==============================");
		}
		
		System.out.println();
		System.out.println("Maior idade: "+maior_idade+" ano(s)");
		System.out.println("Menor idade: "+menor_idade+" ano(s)");
		System.out.println("Média das idades: "+media);

	}

}
