package br.com.kiman.treinamento.jpa.modelo.ManyToOne;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Item {
	
	@Id
	private int numItem;
	
	@ManyToOne
	private ProdutoJPA produto;
	
	@ManyToOne
	private PedidoJPA pedido;

	private int quantidade;

	public PedidoJPA getPedido() {
		return pedido;
	}

	public void setPedido(PedidoJPA pedido) {
		this.pedido = pedido;
	}

	public int getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}

	public ProdutoJPA getProduto() {
		return produto;
	}

	public void setProduto(ProdutoJPA produto) {
		this.produto = produto;
	}
	
	public double subtotal() {
		return this.produto.getPreco() * this.quantidade;
	}

}
