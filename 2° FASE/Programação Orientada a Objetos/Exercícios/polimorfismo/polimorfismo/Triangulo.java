package polimorfismo;

public abstract class Triangulo extends Figura {

	public Triangulo(String nome) {
		super(nome);
	}

	abstract double cArea();
	
	abstract double cPerimetro();

}
