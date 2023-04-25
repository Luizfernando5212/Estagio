package br.com.kiman.treinamento.soap;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.jws.Oneway;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.ws.rs.FormParam;
import javax.xml.ws.WebServiceContext;
import javax.xml.ws.handler.MessageContext;

import br.com.kiman.treinamento.jpa.dao.FilmeDao;
import br.com.kiman.treinamento.jpa.modelo.Filme;


@Stateless
@WebService(endpointInterface = "br.com.kiman.treinamento.soap.FilmesIMDB")
public class FilmeFacade implements FilmesIMDB {
	
	@Inject
	FilmeDao dao;
	
	@Resource
	private WebServiceContext ctx;
	
	@WebMethod
	public List<Filme> getFilmes(){
		return (List<Filme>) dao.findAll();
	}
	
	@WebMethod @WebResult(name = "filme")
	public Filme getFilme(@WebParam(name = "imdb") String codigoIMDB) {
		return dao.findByIMDBCode(codigoIMDB);
	}
	
	@WebMethod
	public List<Filme> getFilmesPorAno(@WebParam(name = "limitBottom") String min,
			@WebParam(name = "limitTop") String max) {
		@SuppressWarnings("unchecked")
		List<Filme> findBetween = (List<Filme>) dao.findBetween(min, max);
		return findBetween;
	}
	
	/*
	@GET
	@Produces({MediaType.TEXT_PLAIN})
	public Response getMyCookies(
			@MatrixParam(value = "userid") String userid,
			@MatrixParam(value = "version") String version) {
		return Response.status(200)
				.entity("Your URL contains: " + userid + " and " + version).build();
	}*/
	
	
	@WebMethod @Oneway
	public void deleteFilme(@WebParam(name = "id") Long id) {
//		dao.findById(id, new Filme());
		dao.delete(id);
	}
	
	@WebMethod @Oneway
	public void create(Filme filme) {
		dao.insert(filme);
	}
	
	@WebMethod @Oneway
	public void post(@FormParam("diretor") String titulo,
			@FormParam("imdb") String code,
			@FormParam("ano") Date ano) {
		
		Filme filme = new Filme();
		
		filme.setTitulo(titulo);
		filme.setImdbCode(code);
		filme.setAnoLancamento(ano);
		
		dao.insert(filme);
		
	}
	
	@WebMethod @Oneway
	public void edit(@WebParam(name = "id") Long id, Filme filme) {
		dao.update(filme);
	}

	@WebMethod
	public String metodoSeguro(String msg) {
		String userid = ctx.getUserPrincipal().getName();
		
		if (userid.equals("czar")) {
			// return "mensagem"
		} else if (ctx.isUserInRole("admin")) {
			// return outra msg
		}
		
		return userid;
	}
	
	@WebMethod
	public void metodo() {
		MessageContext msg = ctx.getMessageContext();
		
		@SuppressWarnings("unchecked")
		Map<Integer, String> header = (Map<Integer, String>) msg.get(MessageContext.HTTP_REQUEST_HEADERS);
		System.out.println(header);
	}

}
