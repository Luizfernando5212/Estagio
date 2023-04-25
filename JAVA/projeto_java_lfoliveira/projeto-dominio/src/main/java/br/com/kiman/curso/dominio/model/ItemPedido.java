package br.com.kiman.curso.dominio.model;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "item_pedido")
public class ItemPedido {
	
	@EmbeddedId
	private ItemPedidoId itemPedidoId;
	
	@Column(name = "id_produto")
	private Long idProduto;
	
	@Column(name = "preco_unitario")
	private Double preco;	
	
	private Long quantidade;
	
//	@ManyToOne
//	@JoinColumn(name = "id_pedido", insertable = false, updatable = false)
//	protected Pedido pedido;
	
	@ManyToOne
	@JoinColumn(name = "id_produto", insertable = false, updatable = false)
	protected Produto produto;
	
//	@ManyToOne
//	@JoinColumn(referencedColumnName = "id_pedido")
//	private Pedido pedido;

	public ItemPedidoId getItemPedidoId() {
		return itemPedidoId;
	}

	public void setItemPedidoId(ItemPedidoId itemPedidoId) {
		this.itemPedidoId = itemPedidoId;
	}

	public Long getIdProduto() {
		return idProduto;
	}

	public void setIdProduto(Long idProduto) {
		this.idProduto = idProduto;
	}

	public Long getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(Long quantidade) {
		this.quantidade = quantidade;
	}

	public Double getPreco() {
		return preco;
	}

	public void setPreco(Double preco) {
		this.preco = preco;
	}

	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}
	
	@Override
	public String toString() {
		return "ItemPedido [itemPedidoId=" + itemPedidoId + ", idProduto=" + idProduto + ", quantidade=" + quantidade
				+ ", precoUnitario=" + preco + ", produto=" + produto + "]";
	}
}
