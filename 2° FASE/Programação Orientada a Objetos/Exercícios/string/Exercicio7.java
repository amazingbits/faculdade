package strings;

import java.util.Scanner;

public class Exercicio7 {

	public static void main(String[] args) {
		
		/**
		 * CRIEUM  PROGRAMA  QUE  DADO  UM  VALOR  NUM�RICO DIGITADO  PELO  USU�RIO,
		 * IMPRIMA  CADA  UM  DOSSEUS D�GITOS POR EXTENSO.
		 * 
		 * EXEMPLO: 
		 * 		O N�MERO:4571
		 * 
		 * 		�RESULTADO: QUATRO, CINCO, SETE, UM.
		 */
		
		Scanner teclado = new Scanner(System.in);
		String[] extenso = {"Zero","Um","Dois","Tr�s","Quatro","Cinco","Seis","Sete","Oito","Nove"};
		
		System.out.println("Digite um n�mero:");
		String numero = teclado.next();
		
		String[] digito = numero.split("");
		
		System.out.println();
		System.out.print("Resultado: ");
		for(int i = 0; i < digito.length; i++) {
			if(i == (digito.length - 1)) {
				System.out.print(extenso[Integer.parseInt(digito[i])]+".");
			}else {
				System.out.print(extenso[Integer.parseInt(digito[i])]+", ");
			}
		}

	}

}
