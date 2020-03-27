package revisao;

import java.util.Random;

public class Exercicio6 {

	public static void main(String[] args) {
		
		/**
		 * CRIE UM PROGRAMA QUE POPULE ALEATORIAMENTE UMA MATRIZ DE DIMENSÕES 3 POR 3.
		 * APÓS POPULADA O SISTEMA DEVE APRESENTAR A MATRIZ COM OS SEUS VALORES DA DIAGONAL 
		 * PRINCIPAL MULTIPLICADOS POR 4 E OS DEMAIS ELEMENTOS MULTIPLICADOS POR 2.
		 */
		
		int[][] matriz = new int[3][3];
		int[][] matriz_final = new int[3][3];
		Random numero = new Random();
		
		//AQUI EU APENAS POPULO AS MATRIZES
		//E APRESENTO A PRIMEIRA MATRIZ
		for(int i = 0; i < matriz.length; i++) {
			for(int j = 0; j < matriz[i].length; j++) {
				matriz[i][j] = numero.nextInt(5) + 1;
				if(i == j) {
					matriz_final[i][j] = matriz[i][j] * 4;
				}else {
					matriz_final[i][j] = matriz[i][j] * 2;
				}
				
				System.out.print(""+matriz[i][j]+" ");
			}
			System.out.println();
		}
		
		System.out.println();
		System.out.println();
		
		//AGORA EU FAÇO UM OUTRO LOOP SÓ PRA APRESESENTAR A SEGUNDA MATRIZ
		for(int i = 0; i < matriz_final.length; i++) {
			for(int j = 0; j < matriz_final[i].length; j++) {
				System.out.print(""+matriz_final[i][j]+" ");
			}
			System.out.println();
		}

	}

}
