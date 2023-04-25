package br.com.kiman.treinamento.jpa.modelo.ManyToOne;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class ProdutoJPA {
	
	@Id @GeneratedValue
	int id;
	String nome;
	double preco;
	
	public int getId() {
		return id;
	}
	public void setCodigo(int id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public double getPreco() {
		return preco;
	}
	public void setPreco(double preco) {
		this.preco = preco;
	}
}
