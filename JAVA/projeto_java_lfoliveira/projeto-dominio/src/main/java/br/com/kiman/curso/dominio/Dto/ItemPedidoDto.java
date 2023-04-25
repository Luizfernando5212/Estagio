package br.com.kiman.curso.dominio.Dto;

import javax.xml.bind.annotation.XmlRootElement;

//@XmlRootElement
public class ItemPedidoDto {
	
	private Long numItem;
	
	private Long idProduto;
	
	private String descricao;
	
	private Double preco;
	
	private Long quantidade;
	
	
	
	public ItemPedidoDto(Long numItem, Long idProduto, String descricao, Double preco, Long quantidade) {
		this.numItem = numItem;
		this.idProduto = idProduto;
		this.descricao = descricao;
		this.preco = preco;
		this.quantidade = quantidade;
	}

	public Long getNumItem() {
		return numItem;
	}

	public void setNumItem(Long numItem) {
		this.numItem = numItem;
	}

	public Long getIdProduto() {
		return idProduto;
	}

	public void setIdProduto(Long idProduto) {
		this.idProduto = idProduto;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Double getPreco() {
		return preco;
	}

	public void setPreco(Double preco) {
		this.preco = preco;
	}

	public Long getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(Long quantidade) {
		this.quantidade = quantidade;
	}
}
