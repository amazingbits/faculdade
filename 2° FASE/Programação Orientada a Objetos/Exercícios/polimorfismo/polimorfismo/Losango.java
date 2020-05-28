package polimorfismo;

public class Losango extends Figura {
	
	private double d_maior;
	private double d_menor;
	private double lado;
	
	public Losango(String nome, double d_maior, double d_menor, double lado) {
		super(nome);
		this.d_maior = d_maior;
		this.d_menor = d_menor;
		this.lado = lado;
	}

	public Losango() {
		super();
	}

	public double getD_maior() {
		return d_maior;
	}

	public void setD_maior(double d_maior) {
		this.d_maior = d_maior;
	}

	public double getD_menor() {
		return d_menor;
	}

	public void setD_menor(double d_menor) {
		this.d_menor = d_menor;
	}

	public double getLado() {
		return lado;
	}

	public void setLado(double lado) {
		this.lado = lado;
	}

	@Override
	double cArea() {
		return (this.getD_maior() * this.getD_menor()) / 2;
	}

	@Override
	double cPerimetro() {
		return this.getLado() * 4;
	}

	@Override
	public String toString() {
		return "Nome: " 
				+ this.getNome() 
				+ "\nDiagonal Maior: " 
				+ this.getD_maior() 
				+ "\nDiagonal Menor: " 
				+ this.getD_menor()
				+ "\nLado: " 
				+ this.getLado()
				+ "\nÁrea: "
				+ this.cArea()
				+ "\nPerímetro: "
				+ this.cPerimetro()
				+"\n\n";
	}

}
