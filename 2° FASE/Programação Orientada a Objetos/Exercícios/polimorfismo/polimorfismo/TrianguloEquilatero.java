package polimorfismo;

public class TrianguloEquilatero extends Triangulo {
	
	private double lado;
	private double altura;
	
	public TrianguloEquilatero(String nome, double lado, double altura) {
		super(nome);
		this.lado = lado;
		this.altura = altura;
	}

	public TrianguloEquilatero(String nome) {
		super(nome);
	}

	public double getLado() {
		return lado;
	}

	public void setLado(double lado) {
		this.lado = lado;
	}

	public double getAltura() {
		return altura;
	}

	public void setAltura(double altura) {
		this.altura = altura;
	}

	@Override
	double cArea() {
		return (this.getLado() * this.getAltura()) / 2;
	}

	@Override
	double cPerimetro() {
		return this.getLado() * 3;
	}

	@Override
	public String toString() {
		return "Nome: " 
				+ this.getNome() 
				+ "\nLado: " 
				+ this.getLado() 
				+ "\nAltura: " 
				+ this.getAltura()
				+ "\nÁrea: "
				+ this.cArea()
				+ "\nPerímetro: "
				+ this.cPerimetro()
				+"\n\n";
	}	

}
