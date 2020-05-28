package polimorfismo;

public class Retangulo extends Figura {
	
	private double base;
	private double altura;
	
	public Retangulo(String nome, double base, double altura) {
		super(nome);
		this.base = base;
		this.altura = altura;
	}

	public Retangulo() {
		super();
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
		return this.getBase() * this.getAltura();
	}

	@Override
	double cPerimetro() {
		return (2 * this.getBase()) + (2 * this.getAltura());
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
