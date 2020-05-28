package polimorfismo;

import java.util.Random;

public class App {

	public static void main(String[] args) {
		
		Random n = new Random();
		Figura fig[] = new Figura[7];
		int numero;
		
		for(int i = 0; i < fig.length; i++) {
			
			numero = n.nextInt(7) + 1;
			
			if(numero == 1) {
				fig[i] = new Quadrado("Quadrado", ( n.nextInt(50) + 1 ));
			}else if(numero == 2) {
				fig[i] = new Circulo("Círculo", ( n.nextInt(50) + 1 ));
			}else if(numero == 3) {
				fig[i] = new Retangulo("Retângulo", ( n.nextInt(50) + 1 ), ( n.nextInt(50) + 1 ));
			}else if(numero == 4) {
				fig[i] = new Losango("Losango", ( n.nextInt(50) + 1 ), ( n.nextInt(50) + 1 ), ( n.nextInt(50) + 1 ));
			}else if(numero == 5) {
				fig[i] = new TrianguloRetangulo("Triângulo Retângulo", ( n.nextInt(50) + 1 ), ( n.nextInt(50) + 1 ));
			}else if(numero == 6) {
				fig[i] = new TrianguloEquilatero("Triângulo Equilátero", ( n.nextInt(50) + 1 ), ( n.nextInt(50) + 1 ));
			}else{
				fig[i] = new TrianguloIsosceles("Triângulo Isósceles", ( n.nextInt(50) + 1 ), ( n.nextInt(50) + 1 ));
			}
			
			System.out.println(fig[i].toString());
		}

	}

}
