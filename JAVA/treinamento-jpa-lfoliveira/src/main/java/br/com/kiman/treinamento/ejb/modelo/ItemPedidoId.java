package br.com.kiman.treinamento.ejb.modelo;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

//import br.com.kiman.treinamento.ejb.modelo.ItemPedido.Pk;

@Embeddable
public class ItemPedidoId implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

//	@ManyToOne
//	@JoinColumn(name = "id_pedido")
//	protected Pedido pedido;
	
	@Column(name = "id_pedido")
	private Long idPedido;
	
	@Column(name = "num_item")
	protected int numItem;

//	public Pedido getPedido() {
//		return pedido;
//	}
//
//	public void setPedido(Pedido pedido) {
//		this.pedido = pedido;
//	}

	
	public int getNumItem() {
		return numItem;
	}

	public Long getIdPedido() {
		return idPedido;
	}

	public void setIdPedido(Long idPedido) {
		this.idPedido = idPedido;
	}

	public void setNumItem(int numItem) {
		this.numItem = numItem;
	}

	@Override
	public int hashCode() {
		return Objects.hash(numItem, idPedido);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ItemPedidoId other = (ItemPedidoId) obj;
		return numItem == other.numItem && Objects.equals(idPedido, other.idPedido);
	}

	@Override
	public String toString() {
		return "ItemPedidoId [pedido=" + idPedido + ", numItem=" + numItem + "]";
	}
}
