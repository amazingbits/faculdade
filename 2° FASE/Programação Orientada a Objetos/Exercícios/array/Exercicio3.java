package array;

import java.util.Random;

public class Exercicio3 {

	public static void main(String[] args) {
		/**
		 * CRIE UM ARRAY DE INTEIROS DETAMANHO 10.IMPLEMENTE UM PROGRAMA 
		 * QUE DEFINA E ESCREVA O ARRAY,BEM COMO A MÉDIA ARITMÉTICA DOSELEMENTOS 
		 * ARMAZENADOS NESTE ARRAY QUE SÃO ÍMPARES
		 */
		
		int[] lista = new int[10];
		Random numero = new Random();
		int total = 0;
		int impares = 0;
		double media = 0;
		
		System.out.print("O array: [");
		for(int i = 0; i < lista.length; i++) {
			lista[i] = numero.nextInt(50) + 1;
			if(i == (lista.length - 1)) {
				System.out.print(lista[i]);
			}else {
				System.out.print(lista[i]+",");
			}
			
			if(lista[i] % 2 != 0) {
				total += lista[i];
				impares++;
			}
		}
		System.out.print("]");
		
		media = (double)total / (double)impares;
		
		System.out.println();
		System.out.println();
		
		System.out.println("Quantidade de números ímpares: "+impares);
		System.out.println("A média dos números ímpares do array: "+String.format("%.2f", media));

	}

}
