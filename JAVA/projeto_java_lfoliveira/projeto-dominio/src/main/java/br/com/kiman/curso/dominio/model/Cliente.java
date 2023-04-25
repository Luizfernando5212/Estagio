package br.com.kiman.curso.dominio.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;

//import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Cliente {
	
	@Id 
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "id_cliente_sequence")
	@SequenceGenerator(name = "id_cliente_sequence", sequenceName = "id_cliente_sequence")
	@Column(name = "id_cliente")
	private Long id;
	
	@Column(name = "razao_social")
	private String nome;
	
	@Column(name = "cpf")
	private String cpf;
	
	@Column(name = "ativo")
	private Long ativo;
	
	@OneToMany/*(fetch = FetchType.EAGER)*/
//	@JsonManagedReference
	@JoinColumn(name = "id_cliente")
	private List<ListaPreco> precos;	

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

	public List<ListaPreco> getPrecos() {
		return precos;
	}

	public void setPrecos(List<ListaPreco> precos) {
		this.precos = precos;
	}

	public Long getAtivo() {
		return ativo;
	}

	public void setAtivo(Long ativo) {
		this.ativo = ativo;
	}

	@Override
	public String toString() {
		return "{ id: " + id + ", \nnome: " + nome + ", \ncpf: " + cpf + ", \nativo: " + ativo + ", \nprecos: [" + precos + "] }";
	}
}
