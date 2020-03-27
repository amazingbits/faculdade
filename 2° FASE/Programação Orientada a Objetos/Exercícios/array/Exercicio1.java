package array;

import java.util.Random;

public class Exercicio1 {

	public static void main(String[] args) {
		/**
		 * ENUNCIADO: CRIE UM ARRAY DE INTEIROS DE TAMANHO 10.IMPLEMENTE UM 
		 * PROGRAMA QUE DEFINA E ESCREVA O ARRAY,BEM COMO A QUANTIDADE DE 
		 * ELEMENTOS ARMAZENADOS NESTE ARRAY QUE SÃO PARES.
		 */
		
		int[] lista = new int[10];
		Random numero = new Random();
		int par = 0;
		
		System.out.print("O array: [");
		for(int i = 0; i < lista.length; i++) {
			
			lista[i] = numero.nextInt(10) + 1;
			
			if(i == (lista.length - 1)) {
				System.out.print(lista[i]);
			}else {
				System.out.print(lista[i]+",");
			}
			
			if(lista[i] % 2 == 0) {
				par++;
			}
		}
		System.out.print("]");
		
		System.out.println();
		System.out.println();
		
		System.out.println("Quantidade de números par: "+par);

	}

}
