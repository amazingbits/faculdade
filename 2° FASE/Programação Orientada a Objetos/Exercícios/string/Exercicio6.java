package strings;

import java.util.Scanner;

public class Exercicio6 {

	public static void main(String[] args) {
		
		/**
		 * CRIEUM  PROGRAMA QUE DADO  UM TEXTO  DIGITADO  PELO USU�RIO O  PROGRAMA TROQUE
		 * TODAS  AS OCORR�NCIAS DE UMA PALAVRA POR OUTRA. PARA ISSO O USU�RIO DEVER� 
		 * DIGITAR O TEXTO,A PALAVRA A SER PROCURADA  E A  PALAVRA  PARA  SER  TROCADA.
		 * AO  FINAL  O  PROGRAMA  DEVE  MOSTRAR  O TEXTO  ORIGINAL, O NOVO TEXTO E INFORMAR 
		 * QUANTAS OCORR�NCIAS DE TROCA OCORRERAM.
		 */
		
		Scanner teclado = new Scanner(System.in);
		
		System.out.println("Digite um texto: ");
		String texto = teclado.nextLine();
		
		System.out.println("Digite uma palavra a ser procurada: ");
		String procurar = teclado.next();
		
		System.out.println("Digite a palavra pra subtituir: ");
		String substituir = teclado.next();
		
		String[] palavras = texto.split(" ");
		
		int ocorrencia = 0;
		for(int i = 0; i < palavras.length; i++) {
			if(palavras[i].compareToIgnoreCase(procurar) == 0) {
				ocorrencia++;
			}
		}
		
		if(ocorrencia == 0) {
			System.out.println("N�o h� esta palavra na frase pra substituir!");
			System.exit(0);
		}else {
			
			String texto_novo = texto.replaceAll(procurar, substituir);
			
			System.out.println("Frase original: "+texto);
			System.out.println("Palavra pesquisada: "+procurar);
			System.out.println("Palavra substitu�da: "+substituir);
			System.out.println("Frase final: "+texto_novo);
			System.out.println("Ocorr�ncias: "+ocorrencia);
		}

	}

}
