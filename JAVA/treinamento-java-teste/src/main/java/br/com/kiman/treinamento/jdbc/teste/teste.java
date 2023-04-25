package br.com.kiman.treinamento.jdbc.teste;

public class teste {
	
	public static class Pessoa {
		
		private String nome;
		
		private int idade;
		public Pessoa(String nome, int idade) {
			this.idade = idade;
			this.nome = nome;
			// TODO Auto-generated constructor stub
		}
		
		public String getNome() {
			return nome;
		}

		public void setNome(String nome) {
			this.nome = nome;
		}

		public int getIdade() {
			return idade;
		}

		public void setIdade(int idade) throws Exception {
			if (idade < 18) {
				throw new Exception("A pessoa precisa ser maior de idade.");
			} else {
				this.idade = idade;
			}
		}
		
		
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Pessoa pessoa = new Pessoa("Luiz", 15);
		
		System.out.println(pessoa.getIdade());
	}

}
