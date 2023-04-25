package br.com.kiman.curso.dominio.Dto;

import java.util.List;

public class ClienteDto {
	
	private Long id;
	
	private String nome;
	
	private String cpf;
	
	private List<ListaPrecoDto> precos;
	
	public ClienteDto() {
		
	}
	
	public ClienteDto(Long id, String razaoSocial, String cpf) {
		this.id = id;
		this.nome = razaoSocial;
		this.cpf = cpf;
	}
	
	public ClienteDto(Long id, String razaoSocial, String cpf, List<ListaPrecoDto> listaDto) {
		this.id = id;
		this.nome = razaoSocial;
		this.cpf = cpf;
		this.precos = listaDto;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public List<ListaPrecoDto> getPrecos() {
		return precos;
	}

	public void setPrecos(List<ListaPrecoDto> precos) {
		this.precos = precos;
	}

	@Override
	public String toString() {
		return "ClienteDto [id=" + id + ", nome=" + nome + ", cpf=" + cpf + ", precos=" + precos + "]";
	}
	
	
}
