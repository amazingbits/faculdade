package revisao;

import java.util.Arrays;

public class Exercicio12 {

	public static void main(String[] args) {
		
		/**
		 * CONSTRUA  UMA  CLASSE  QUE  POSSUA  UM ARRAY  QUE  ARMAZENE 10 NOMES  
		 * DE FORMA  ALEAT�RIA. ORDENE O ARRAY E MOSTRE OS NOMES EM ORDEM ALFAB�TICA.
		 */
		
		String[] nomes = {"Pedro", "Ana", "Cl�udio", "Tereza", "Marcos", "Jo�o", "Chico",
						"S�nia", "Igor", "Adalberto"};
		
		Arrays.sort(nomes);
		
		System.out.print("[");
		for(int i = 0; i < nomes.length; i++) {
			if(i == (nomes.length - 1)) {
				System.out.print(nomes[i]);
			}else {
				System.out.print(nomes[i]+", ");
			}
		}
		System.out.println("]");

	}

}
