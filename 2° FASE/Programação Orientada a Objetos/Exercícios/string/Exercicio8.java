package strings;

import java.util.Scanner;

public class Exercicio8 {

	public static void main(String[] args) {
		
		/**
		 * CRIEUM  PROGRAMA  QUE SOLICITE A  DATA  DE  NASCIMENTO (DD/MM/AAAA) DO  
		 * USUÁRIO E  IMPRIMA ADATA COM O NOME DO MÊS POR EXTENSO.
		 * 
		 * EXEMPLO:
		 * 
		 * DATA DE NASCIMENTO: 15/03/1998
		 * 
		 * •VOCÊ NASCEU EM 15 DE MARÇO DE 1998.
		 */
		
		Scanner teclado = new Scanner(System.in);
		
		System.out.println("Informe sua data de nascimento: ");
		String nasc = teclado.next();
		
		String[] itens = nasc.split("/");
		
		String[] extenso = {"Janeiro", "Fevereiro","Março","Abril","Maio",
							"Junho", "Julho", "Agosto", "Setembro",
							"Outubro", "Novembro", "Dezembro"};
		
		int mes = Integer.parseInt(itens[1]) - 1;
		
		System.out.println(itens[0]+" de "+extenso[mes]+" de "+itens[2]);

	}

}
