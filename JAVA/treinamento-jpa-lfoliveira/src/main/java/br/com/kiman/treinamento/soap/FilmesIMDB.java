package br.com.kiman.treinamento.soap;

import java.util.List;

import javax.jws.WebParam;
import javax.jws.WebService;
import javax.ws.rs.DefaultValue;
import javax.xml.ws.RequestWrapper;

import br.com.kiman.treinamento.jpa.modelo.Filme;

@WebService
public interface FilmesIMDB {
	public Filme getFilme(@WebParam(name = "imdb")String codigoIMDB);
	
	public List<Filme> getFilmes();
	
	public void deleteFilme(@WebParam(name = "id") Long id);
	
	public void create(Filme filme);
	
	public void edit(@WebParam(name = "id") Long id, Filme filme);
	
	@RequestWrapper(targetNamespace="http://soap.treinamento.kiman.com.br/", 
			className="br.com.kiman.treinamento.soap.wrapper.Wrapper")
	public List<Filme> getFilmesPorAno(@WebParam(name = "limitBottom") String min, 
			@WebParam(name = "limitTop") String max);
	
	public String metodoSeguro(String msg);
}
