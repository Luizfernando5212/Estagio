package br.com.kiman.treinamento.ejb.modelo;



public class FilmeDto {
	private Long idFilme;
	
	private String titulo;
	
	private String imdbCode;
	
	private String anoLancamento;
	
	public FilmeDto(Long id, String titulo, String imdb) {
		this.idFilme = id;
		this.titulo = titulo;
		this.imdbCode = imdb;
	}

	public Long getIdFilme() {
		return idFilme;
	}

	public void setIdFilme(Long idFilme) {
		this.idFilme = idFilme;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getImdbCode() {
		return imdbCode;
	}

	public void setImdbCode(String imdbCode) {
		this.imdbCode = imdbCode;
	}

	public String getAnoLancamento() {
		return anoLancamento;
	}

	public void setAnoLancamento(String anoLancamento) {
		this.anoLancamento = anoLancamento;
	}
}
