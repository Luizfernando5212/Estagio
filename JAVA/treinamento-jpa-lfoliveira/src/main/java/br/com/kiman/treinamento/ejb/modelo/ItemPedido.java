package br.com.kiman.treinamento.ejb.modelo;

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
	private int idProduto;
	
	private int quantidade;
	
	@Column(name = "preco_unitario")
	private Double precoUnitario;	
	
	@ManyToOne
	@JoinColumn(name = "id_pedido", insertable = false, updatable = false)
	protected Pedido pedido;
	
//	@ManyToOne
//	@JoinColumn(referencedColumnName = "id_pedido")
//	private Pedido pedido;

	public int getIdProduto() {
		return idProduto;
	}

	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}

	public int getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}

	public Double getPrecoUnitario() {
		return precoUnitario;
	}

	public void setPrecoUnitario(Double precoUnitario) {
		this.precoUnitario = precoUnitario;
	}
	
	public Pedido getPedido() {
		return this.pedido;
	}

	@Override
	public String toString() {
		return "ItemPedido [itemPedidoId=" + itemPedidoId + ", idProduto=" + idProduto + ", quantidade=" + quantidade
				+ ", precoUnitario=" + precoUnitario + "]";
	}
}
