package br.com.kiman.treinamento.ejb.modelo;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

@Entity
public class Pedido {
	
	@Id 
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "id_pedido_sequence")
	@SequenceGenerator(name = "id_pedido_sequence", sequenceName = "id_pedido_sequence")
	@Column(name = "id_pedido")
	private int idPedido;
	
	@Column(name = "id_cliente")
	private int idCliente;
	
	@Column(name = "data_pedido")
	private Date dataPedido;
	
	@Column(name = "data_entrega")
	private Date dataEntrega;
	
//	@OneToMany(fetch = FetchType.EAGER)
//	private Set<ItemPedido> itens;

//	public Set<ItemPedido> getItens() {
//		return itens;
//	}
//
//	public void setItens(Set<ItemPedido> itens) {
//		this.itens = itens;
//	}

	public int getIdPedido() {
		return idPedido;
	}

	public void setIdPedido(int id) {
		this.idPedido = id;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
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

	@Override
	public String toString() {
		return "Pedido [idPedido=" + idPedido + ", idCliente=" + idCliente + ", dataPedido=" + dataPedido
				+ ", dataEntrega=" + dataEntrega + "]";
	}

	
}
