package br.com.kiman.curso.dominio.Dto;

public class ListaPrecoDto {
	
	private Long idProduto;
	
	private String descricao;
	
	private Double precoUnitario;
	
	public ListaPrecoDto() {}
	
	public ListaPrecoDto(Long id, String descricao, Double preco) {
		this.idProduto = id;
		this.descricao = descricao;
		this.precoUnitario = preco;
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

	public Double getPrecoUnitario() {
		return precoUnitario;
	}

	public void setPrecoUnitario(Double precoUnitario) {
		this.precoUnitario = precoUnitario;
	}

	@Override
	public String toString() {
		return "ListaPrecoDto [idProduto=" + idProduto + ", descricao=" + descricao + ", precoUnitario=" + precoUnitario
				+ "]";
	}
	
}
