package polimorfismo;

public class TrianguloIsosceles extends Triangulo {
	
	private double base;
	private double altura;
	
	public TrianguloIsosceles(String nome, double base, double altura) {
		super(nome);
		this.base = base;
		this.altura = altura;
	}

	public TrianguloIsosceles(String nome) {
		super(nome);
	}

	public double getBase() {
		return base;
	}

	public void setBase(double base) {
		this.base = base;
	}

	public double getAltura() {
		return altura;
	}

	public void setAltura(double altura) {
		this.altura = altura;
	}

	@Override
	double cArea() {
		return (this.getBase() * this.getAltura()) / 2;
	}

	@Override
	double cPerimetro() {
		return this.getBase() * 3;
	}

	@Override
	public String toString() {
		return "Nome: " 
				+ this.getNome() 
				+ "\nBase: " 
				+ this.getBase() 
				+ "\nAltura: " 
				+ this.getAltura()
				+ "\nÁrea: "
				+ this.cArea()
				+ "\nPerímetro: "
				+ this.cPerimetro()
				+"\n\n";
	}
	
	

}
