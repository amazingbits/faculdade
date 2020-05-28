package polimorfismo;

public class Quadrado extends Figura {

	private double lado;
	
	public Quadrado(String nome, double lado) {
		super(nome);
		this.lado = lado;
	}
	
	public Quadrado() {
		super();
	}

	public double getLado() {
		return lado;
	}

	public void setLado(double lado) {
		this.lado = lado;
	}
	
	@Override
	double cArea() {
		return this.getLado() * this.getLado();
	}

	@Override
	double cPerimetro() {
		return this.getLado() * 4;
	}

	@Override
	public String toString() {
		return "Nome: " 
				+ this.getNome() 
				+ "\nLado: " 
				+ this.getLado() 
				+ "\nÁrea: "
				+ this.cArea()
				+ "\nPerímetro: "
				+ this.cPerimetro()
				+"\n\n";
	}

}
