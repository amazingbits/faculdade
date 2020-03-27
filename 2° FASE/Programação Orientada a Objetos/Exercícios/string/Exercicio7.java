package strings;

import java.util.Scanner;

public class Exercicio7 {

	public static void main(String[] args) {
		
		/**
		 * CRIEUM  PROGRAMA  QUE  DADO  UM  VALOR  NUMÉRICO DIGITADO  PELO  USUÁRIO,
		 * IMPRIMA  CADA  UM  DOSSEUS DÍGITOS POR EXTENSO.
		 * 
		 * EXEMPLO: 
		 * 		O NÚMERO:4571
		 * 
		 * 		•RESULTADO: QUATRO, CINCO, SETE, UM.
		 */
		
		Scanner teclado = new Scanner(System.in);
		String[] extenso = {"Zero","Um","Dois","Três","Quatro","Cinco","Seis","Sete","Oito","Nove"};
		
		System.out.println("Digite um número:");
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
