package revisao;

import java.util.Random;

public class Exercicio1 {

	public static void main(String[] args) {
		
		/**
		 * CRIE  UM PROGRAMAQUE  SIMULE  A  JOGADADE  UM  DADO (DE  SEISLADOS)
		 * DEZ  VEZES (ALEATÓRIO)E MOSTRE O RESULTADO NA TELA
		 */
		
		Random numero = new Random();
		
		for(int i = 0; i < 10; i++) {
			int dado = numero.nextInt(6) + 1;
			System.out.println();
			System.out.println("Resultado número "+(i+1)+": "+dado);
			System.out.println();
		}

	}

}
