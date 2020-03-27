package strings;

import java.util.Scanner;

public class Exercicio5 {

	public static void main(String[] args) {
		
		/**
		 * CRIE  UM  PROGRAMA ONDE  O  USU�RIO  IR�  DIGITAR UM  VERBO  REGULAR  
		 * TERMINADO  EM AR E  MOSTRE A CONJUGA��O NO TEMPO PRESENTE. EXEMPLO:
		 * 
		 * 		VERBO ANDAR
		 * 
		 * 			� EU ANDO
		 * 			� TU ANDAS
		 * 			� ELE ANDA
		 * 			� N�S ANDAMOS
		 * 			� V�S ANDAIS
		 * 			� ELES ANDAM
		 */
		
		Scanner teclado = new Scanner(System.in);
		String[] conjugar = {"o", "as", "a", "amos", "ais", "am"};
		String[] sujeito = {"eu ", "tu ", "ele ", "n�s ", "v�s ", "eles "};
		
		System.out.println("Digite um verbo no infinitivo terminado em 'ar': ");
		String verbo = teclado.next().toLowerCase();
		
		if(verbo.endsWith("ar")) {
			
			for(int i = 0; i < sujeito.length; i++) {
				System.out.println(sujeito[i]+verbo.replace("ar", conjugar[i]));
			}
			
		}else {
			System.out.println("Palavra inv�lida!");
			System.exit(0);
		}

	}

}
