package br.com.kiman.curso.dominio.model;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "lista_preco")
public class ListaPreco {
	
	@EmbeddedId
	private ListaPrecoId listaPrecoId;
	
	@Column(name = "preco_unitario")
	private Double precoUnitario;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "id_produto", insertable = false, updatable = false)
	protected Produto produto;

	public ListaPrecoId getListaPrecoId() {
		return listaPrecoId;
	}

	public void setListaPrecoId(ListaPrecoId listaPrecoId) {
		this.listaPrecoId = listaPrecoId;
	}

	public Double getPrecoUnitario() {
		return precoUnitario;
	}

	public void setPrecoUnitario(Double precoUnitario) {
		this.precoUnitario = precoUnitario;
	}

	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}

	@Override
	public String toString() {
		return "{" + produto + ", precoUnitario: " + precoUnitario + "}";
	}
}
