package revisao;

import java.util.Scanner;

public class Exercicio3 {

	public static void main(String[] args) {
		
		/**
		 * DESENVOLVA UM PROGRAMA QUE LEIA 10 N�MEROS ENTRE 1 A 9 E CALCULE A M�DIA 
		 * DOS N�MEROS. CASO O N�MERO DIGITADO ESTEJA FORA DA FAIXA ESTABELECIDA (1 A 9),
		 * MOSTRAR A MENSAGEM DE "N�MERO FORA DA  FAIXA". OS  N�MEROS  FORA  DA  FAIXA  
		 * N�O  CONTABILIZAM NOS 10 N�MEROS A  SEREM  LIDOS, OU  SEJA,DEPENDENDO DOS N�MEROS 
		 * O SISTEMA DEVER� LER MAIS DO QUE 10 N�MEROS.
		 */
		
		Scanner teclado = new Scanner(System.in);
		int[] numero = new int[10];
		double total = 0;
		
		for(int i = 0; i < 10; i++) {
			System.out.println("Digite o "+(i+1)+"� n�mero de 1 a 9: ");
			numero[i] = teclado.nextInt();
			if((numero[i] < 1) || (numero[i] > 9)) {
				System.out.println("ATEN��O: N�MERO FORA DA FAIXA!");
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
		System.out.println("M�DIA: "+media);

	}

}
