package br.com.kiman.treinamento.jpa.modelo;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

import br.com.kiman.treinamento.jpa.listener.LivroListener;


@Entity
@EntityListeners(LivroListener.class)
@NamedQueries({
	@NamedQuery(name = "selectAll", query = "SELECT l FROM Livro l"),
	@NamedQuery(name = "selectById", query = "SELECT l FROM Livro l WHERE l.id = :id")
})
public class Livro implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	private Long id;
	
	private String titulo;
	private int paginas;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public int getPaginas() {
		return paginas;
	}
	public void setPaginas(int paginas) {
		this.paginas = paginas;
	}
	
	@Override
	public String toString() {
		return "Livro";
	}
}
