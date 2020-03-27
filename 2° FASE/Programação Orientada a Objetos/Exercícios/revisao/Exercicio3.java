package revisao;

import java.util.Scanner;

public class Exercicio3 {

	public static void main(String[] args) {
		
		/**
		 * DESENVOLVA UM PROGRAMA QUE LEIA 10 NÚMEROS ENTRE 1 A 9 E CALCULE A MÉDIA 
		 * DOS NÚMEROS. CASO O NÚMERO DIGITADO ESTEJA FORA DA FAIXA ESTABELECIDA (1 A 9),
		 * MOSTRAR A MENSAGEM DE "NÚMERO FORA DA  FAIXA". OS  NÚMEROS  FORA  DA  FAIXA  
		 * NÃO  CONTABILIZAM NOS 10 NÚMEROS A  SEREM  LIDOS, OU  SEJA,DEPENDENDO DOS NÚMEROS 
		 * O SISTEMA DEVERÁ LER MAIS DO QUE 10 NÚMEROS.
		 */
		
		Scanner teclado = new Scanner(System.in);
		int[] numero = new int[10];
		double total = 0;
		
		for(int i = 0; i < 10; i++) {
			System.out.println("Digite o "+(i+1)+"° número de 1 a 9: ");
			numero[i] = teclado.nextInt();
			if((numero[i] < 1) || (numero[i] > 9)) {
				System.out.println("ATENÇÃO: NÚMERO FORA DA FAIXA!");
				System.out.println();
				i--;
			}else {
				total += numero[i];
			}
		}
		double media = total / (double)numero.length;
		
		System.out.print("[");
		for(int i = 0; i < numero.length; i++) {
			System.out.print(numero[i]+" ");
		}
		System.out.print("]");
		System.out.println();
		System.out.println("MÉDIA: "+media);

	}

}
