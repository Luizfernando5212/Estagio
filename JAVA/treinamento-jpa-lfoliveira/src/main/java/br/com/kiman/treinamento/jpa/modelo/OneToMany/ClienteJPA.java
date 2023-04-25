package br.com.kiman.treinamento.jpa.modelo.OneToMany;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;

@Entity
@NamedQueries({
	@NamedQuery(name = "selectAllC", query = "SELECT c FROM ClienteJPA c"),
	@NamedQuery(name = "selectByIdC", query = "SELECT c FROM ClienteJPA c WHERE c.id = :id")
})
public class ClienteJPA {

	@Id @GeneratedValue
	private int id;
	
	@OneToOne
	private CPF cpf;
	
	@ManyToOne
	private LojaVirtual lojaVirtual;
	
	@Embedded
	private Endereco enderecoCobranca;

	public CPF getCpf() {
		return cpf;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LojaVirtual getLojaVirtual() {
		return lojaVirtual;
	}

	public void setLojaVirtual(LojaVirtual lojaVirtual) {
		this.lojaVirtual = lojaVirtual;
	}

	public void setCpf(CPF cpf) {
		this.cpf = cpf;
	}
	
	@Embedded
	@AttributeOverrides({
		@AttributeOverride(name="rua", column=@Column(name="ENT_RUA")),
		@AttributeOverride(name="cep", column=@Column(name="ENT_CEP")),
		@AttributeOverride(name="cidade", column=@Column(name="ENT_CIDADE"))
	})
	private Endereco enderecoEntrega;
	
}
