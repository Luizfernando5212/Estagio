package br.com.kiman.curso.dominio.model;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ListaPrecoId implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Column(name = "id_cliente")
	private Long idCliente;
	
	@Column(name = "id_produto")
	private Long idProduto;

	public Long getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(Long idCliente) {
		this.idCliente = idCliente;
	}

	public Long getIdProduto() {
		return idProduto;
	}

	public void setIdProduto(Long idProduto) {
		this.idProduto = idProduto;
	}

	@Override
	public int hashCode() {
		return Objects.hash(idCliente, idProduto);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ListaPrecoId other = (ListaPrecoId) obj;
		return Objects.equals(idCliente, other.idCliente) && Objects.equals(idProduto, other.idProduto);
	}

	@Override
	public String toString() {
		return "ListaPrecoId [idCliente=" + idCliente + ", idProduto=" + idProduto + "]";
	}
	 
}
