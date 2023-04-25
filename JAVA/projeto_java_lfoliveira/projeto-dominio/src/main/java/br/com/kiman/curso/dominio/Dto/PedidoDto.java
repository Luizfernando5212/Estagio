package br.com.kiman.curso.dominio.Dto;

import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

//@XmlRootElement
//@XmlAccessorType(XmlAccessType.FIELD)
public class PedidoDto {
	
	private Long id;
	
	private Long idCliente;
	
	private String nomeCliente;
	
	private String cpfCliente;
	
	private String dataPedido;
	
	private String dataEntrega;
	
	private Double valorTotal;
	
//	@XmlElement(nillable = false)
	private List<ItemPedidoDto> itens;
	
	public PedidoDto(Long id, Long idCliente, String nomeCliente, String cpfCliente, 
			String dataPedido, Double valorTotal) {
		this.id = id;
		this.idCliente = idCliente;
		this.nomeCliente = nomeCliente;
		this.cpfCliente = cpfCliente;
		this.dataPedido = dataPedido;
		this.valorTotal = valorTotal;
	}
	
	public PedidoDto(Long id, Long idCliente, String nomeCliente, String cpfCliente, 
			String dataPedido, String dataEntrega, Double valorTotal) {
		this.id = id;
		this.idCliente = idCliente;
		this.nomeCliente = nomeCliente;
		this.cpfCliente = cpfCliente;
		this.dataPedido = dataPedido;
		this.dataEntrega = dataEntrega;
		this.valorTotal = valorTotal;
	}
	
	public PedidoDto(Long id, Long idCliente, String nomeCliente, String cpfCliente, 
			String dataPedido, String dataEntrega, Double valorTotal, List<ItemPedidoDto> itens) {
		this.id = id;
		this.idCliente = idCliente;
		this.nomeCliente = nomeCliente;
		this.cpfCliente = cpfCliente;
		this.dataPedido = dataPedido;
		this.dataEntrega = dataEntrega;
		this.valorTotal = valorTotal;
		this.itens = itens;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(Long idCliente) {
		this.idCliente = idCliente;
	}

	public String getNomeCliente() {
		return nomeCliente;
	}

	public void setNomeCliente(String nomeCliente) {
		this.nomeCliente = nomeCliente;
	}

	public String getCpfCliente() {
		return cpfCliente;
	}

	public void setCpfCliente(String cpfCliente) {
		this.cpfCliente = cpfCliente;
	}

	public String getDataPedido() {
		return dataPedido;
	}

	public void setDataPedido(String dataPedido) {
		this.dataPedido = dataPedido;
	}

	public String getDataEntrega() {
		return dataEntrega;
	}

	public void setDataEntrega(String dataEntrega) {
		this.dataEntrega = dataEntrega;
	}

	public Double getValorTotal() {
		return valorTotal;
	}

	public void setValorTotal(Double valorTotal) {
		this.valorTotal = valorTotal;
	}

	public List<ItemPedidoDto> getItens() {
		return itens;
	}

	public void setItens(List<ItemPedidoDto> itens) {
		this.itens = itens;
	}
}
