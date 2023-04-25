package br.com.kiman.curso.dominio.model;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Pedido {
	
	@Id 
//	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "id_pedido_sequence")
//	@SequenceGenerator(name = "id_pedido_sequence", sequenceName = "id_pedido_sequence")
	@Column(name = "id_pedido")
	private Long idPedido;
	
	@Column(name = "id_cliente")
	private Long idCliente;
	
	@Column(name = "data_pedido")
	private Date dataPedido;
	
	@Column(name = "data_entrega")
	private Date dataEntrega;
	
	@ManyToOne/*(fetch = FetchType.EAGER)*/
	@JoinColumn(name = "id_cliente", insertable = false, updatable = false)
	protected Cliente cliente;
	
	@OneToMany/*(fetch = FetchType.EAGER)*/
	@JoinColumn(name = "id_pedido", insertable = false, updatable = false)
	protected List<ItemPedido> itens;

	public Long getIdPedido() {
		return idPedido;
	}

	public void setIdPedido(Long id) {
		this.idPedido = id;
	}

	public Long getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(Long idCliente) {
		this.idCliente = idCliente;
	}

	public Date getDataPedido() {
		return dataPedido;
	}

	public void setDataPedido(Date dataPedido) {
		this.dataPedido = dataPedido;
	}

	public Date getDataEntrega() {
		return dataEntrega;
	}

	public void setDataEntrega(Date dataEntrega) {
		this.dataEntrega = dataEntrega;
	}
	
	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public List<ItemPedido> getItens() {
		return itens;
	}

	public void setItemPedido(List<ItemPedido> itens) {
		this.itens = itens;
	}

	@Override
	public String toString() {
		return "Pedido [idPedido=" + idPedido + ", idCliente=" + idCliente + ", dataPedido=" + dataPedido
				+ ", dataEntrega=" + dataEntrega + "]";
	}

	
}
