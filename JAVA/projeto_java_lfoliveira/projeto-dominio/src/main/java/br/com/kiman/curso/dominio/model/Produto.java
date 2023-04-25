package br.com.kiman.curso.dominio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

@Entity
public class Produto {

	@Id 
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "id_produto_sequence")
	@SequenceGenerator(name = "id_produto_sequence", sequenceName = "id_produto_sequence")
	@Column(name = "id_produto")
	private Long id;
	
	private String descricao;
	
	public Long getIdProduto() {
		return id;
	}

	public void setIdProduto(Long idProduto) {
		this.id = idProduto;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	@Override
	public String toString() {
		return "idProduto: " + id + ", descricao: " + descricao;
	}
	
}
