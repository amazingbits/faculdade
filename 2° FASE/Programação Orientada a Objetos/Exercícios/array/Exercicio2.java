package array;

import java.util.Random;

public class Exercicio2 {

	public static void main(String[] args) {
		/**
		 * CRIE UM ARRAY DE INTEIROS DETAMANHO 10.IMPLEMENTE UM PROGRAMA 
		 * QUE DEFINA E ESCREVA O ARRAY,BEM COMO A SOMA DOSELEMENTOS 
		 * ARMAZENADOS NESTEARRAY
		 */
		
		int[] lista = new int[10];
		Random numero = new Random();
		int soma = 0;
		
		System.out.print("O array: [");
		for(int i = 0; i < lista.length; i++) {
			lista[i] = numero.nextInt(100) + 1;
			if(i == (lista.length - 1)) {
				System.out.print(lista[i]);
			}else {
				System.out.print(lista[i]+",");
			}
			soma += lista[i];
		}
		System.out.print("]");
		
		System.out.println();
		System.out.println();
		
		System.out.println("A soma dos elementos é: "+soma);

	}

}
