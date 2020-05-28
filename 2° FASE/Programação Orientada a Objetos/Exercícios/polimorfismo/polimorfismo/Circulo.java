package polimorfismo;

public class Circulo extends Figura {

	private double raio;

	public Circulo(String nome, double raio) {
		super(nome);
		this.raio = raio;
	}

	public Circulo() {
		super();
	}

	public double getRaio() {
		return raio;
	}

	public void setRaio(double raio) {
		this.raio = raio;
	}

	@Override
	double cArea() {
		return 3.14 * (this.getRaio() * this.getRaio());
	}

	@Override
	double cPerimetro() {
		return (2 * 3.14) * this.getRaio();
	}

	@Override
	public String toString() {
		return "Nome: " 
				+ this.getNome() 
				+ "\nRaio: " 
				+ this.getRaio() 
				+ "\nÁrea: "
				+ this.cArea()
				+ "\nPerímetro: "
				+ this.cPerimetro()
				+"\n\n";
	}
	
	

}
