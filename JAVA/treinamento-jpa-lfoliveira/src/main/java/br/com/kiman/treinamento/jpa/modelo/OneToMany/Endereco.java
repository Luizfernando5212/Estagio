package br.com.kiman.treinamento.jpa.modelo.OneToMany;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class Endereco {
	
	@Column(name="COB_RUA")
	private String rua;
	
	@Column(name="COB_CEP")
	private String cep;
	
	@Column(name="COB_CIDADE")
	private String cidade;

	public String getRua() {
		return rua;
	}

	public void setRua(String rua) {
		this.rua = rua;
	}

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
}
