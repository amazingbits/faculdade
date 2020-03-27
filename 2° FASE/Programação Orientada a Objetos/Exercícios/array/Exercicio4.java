package array;

import java.util.Scanner;

public class Exercicio4 {

	public static void main(String[] args) {
		
		/**
		 * LER AS DUAS NOTAS BIMESTRAIS PARA UM CONJUNTO DE 5ALUNOS. ARMAZENAR 
		 * AS NOTAS INFORMADAS PELO USUÁRIO EM DOISARRAYS “NOTA1”E “NOTA2”, BEM 
		 * COMO O NOME DO ALUNO EM UM ARRAY “ALUNO”. O PROGRAMA DEVE CALCULAR A 
		 * MÉDIA DAS NOTASE INFORMAR:
		 * 	
		 * 		• NOME DO ALUNO;
		 * 		• NOTA 1;
		 * 		• NOTA 2;
		 * 		• MÉDIA;
		 * 		• SITUAÇÃO;
		 * 
		 * SE A MÉDIA CALCULADA FOR SUPERIOR OU IGUAL A 7O ALUNO ESTARÁ COM A SITUAÇÃO 
		 * “APROVADO”,CASO CONTRÁRIO,A SITUAÇÃO SERÁ “REPROVADO”
		 */
		
		String[] nomes = new String[5];
		double[] nota1 = new double[5];
		double[] nota2 = new double[5];
		double[] media = new double[5];
		String[] ordem = {"primeiro", "segundo", "terceiro", "quarto", "quinto"};
		
		Scanner teclado = new Scanner(System.in);
		
		for(int i = 0; i < nomes.length; i++) {
			System.out.println("Informe o nome do "+ordem[i]+" aluno:");
			System.out.println();
			nomes[i] = teclado.next();
			
			System.out.println("Informe a nota 1 do "+ordem[i]+" aluno:");
			System.out.println();
			nota1[i] = teclado.nextDouble();
			
			System.out.println("Informe a nota 2 do "+ordem[i]+" aluno:");
			System.out.println();
			nota2[i] = teclado.nextDouble();
			
			media[i] = (nota1[i] + nota2[i]) / 2;
		}
		
		for(int i = 0; i < nomes.length; i++) {
			System.out.println("Aluno: "+nomes[i]);
			System.out.println("Média: "+String.format("%.2f", media[i]));
			if(media[i] >= 7) {
				System.out.println("Status: Aprovado(a)");
			}else {
				System.out.println("Status: Reprovado(a)");
			}
			System.out.println();
			System.out.println();
		}

	}

}
