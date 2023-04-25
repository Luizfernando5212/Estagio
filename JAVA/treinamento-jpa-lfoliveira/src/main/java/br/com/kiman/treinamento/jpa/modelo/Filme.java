package br.com.kiman.treinamento.jpa.modelo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@XmlRootElement(name = "filme")
public class Filme {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "id_filme_seq")
	@SequenceGenerator(name = "id_filme_seq", sequenceName = "id_filme_seq", allocationSize = 1)
	@Column(name = "id")
	private Long idFilme;
	
	private String titulo;
	
	@Column(name = "Imdb_code")
	private String imdbCode;
	
	@Column(name = "ano_lancamento")
	private Date anoLancamento;

	public Long getIdFilme() {
		return idFilme;
	}

	public void setIdFilme(Long idFilme) {
		this.idFilme = idFilme;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String nome) {
		this.titulo = nome;
	}

	public String getImdbCode() {
		return imdbCode;
	}

	public void setImdbCode(String imdbCode) {
		this.imdbCode = imdbCode;
	}

	public Date getAnoLancamento() {
		return anoLancamento;
	}

	public void setAnoLancamento(Date anoLancamento) {
		this.anoLancamento = anoLancamento;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "Filme";
	}
	
}
