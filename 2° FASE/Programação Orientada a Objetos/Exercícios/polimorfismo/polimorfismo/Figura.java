package polimorfismo;

public abstract class Figura {
	
	private String nome;

	protected Figura(String nome) {
		super();
		this.nome = nome;
	}

	protected Figura() {
		super();
	}

	protected String getNome() {
		return nome;
	}

	protected void setNome(String nome) {
		this.nome = nome;
	}
	
	abstract double cArea();
	
	abstract double cPerimetro();

}
