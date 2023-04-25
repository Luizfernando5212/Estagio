package br.com.kiman.treinamento.rest.root;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
//import javax.ws.rs.MatrixParam;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import br.com.kiman.treinamento.ejb.modelo.FilmeDto;
import br.com.kiman.treinamento.jpa.dao.FilmeDao;
import br.com.kiman.treinamento.jpa.modelo.Filme;

@Path("/filmes")
@Consumes(value = { MediaType.APPLICATION_JSON })
public class FilmesIMDBResource {
	
	@Inject
	FilmeDao dao;
	
	@Context
	Request request;
	
	@Context
	UriInfo uriInfo;
	
	@SuppressWarnings("unchecked")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getFilmes(){
		List<Filme> filmes = (List<Filme>) dao.findAll();
		List<FilmeDto> filmesDto = new ArrayList<FilmeDto>();
		
		
		for (Filme filme : filmes) {
			filmesDto.add(Conversor.converteFilme(filme));
		}
		
		return Response.ok().entity(filmesDto)/*.header("Access-Control-Allow-Origin", "*")*/.build();
	}
	
	@GET
	@Path("{imdb}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getFilme(@PathParam("imdb") String codigoIMDB) {
		Filme filme =  dao.findByIMDBCode(codigoIMDB);
		FilmeDto filmeDto = Conversor.converteFilme(filme);

		
		return Response.ok().entity(filmeDto)/*.header("Access-Control-Allow-Origin", "*")*/.build();
		//		return dao.findByIMDBCode(codigoIMDB);
	}
	
	@GET @Path("title")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getFilmesPorAno(@DefaultValue("#") @QueryParam("titulo") String titulo,
			@DefaultValue("-2") @QueryParam("id") Long id) {
//		if (titulo.equals("#") && id.equals(-2l))
		List<Filme> findBetween = (List<Filme>) dao.findByFilter(titulo, id);
		List<FilmeDto> filmesDto = new ArrayList<FilmeDto>();
		
		for (Filme filme : findBetween) {
			filmesDto.add(Conversor.converteFilme(filme));
		}
		
		return Response.ok().entity(filmesDto)/*.header("Access-Control-Allow-Origin", "*")*/.build();
	}
	
//	@GET @Path("filme")
//	@Produces(MediaType.APPLICATION_JSON)
//	public Response getFilmesPorAno(@DefaultValue("1900") @QueryParam("minAno") String min,
//			@DefaultValue("2013") @QueryParam("maxAno") String max) {
//		@SuppressWarnings("unchecked")
//		List<Filme> findBetween = (List<Filme>) dao.findBetween(min, max);
//		List<FilmeDto> filmesDto = new ArrayList<FilmeDto>();
//		
//		
//		for (Filme filme : findBetween) {
//			filmesDto.add(Conversor.converteFilme(filme));
//		}
//		
//		return Response.ok().entity(filmesDto).header("Access-Control-Allow-Origin", "*").build();
//	}
	
//	@GET
//	@Path("/echo")
//	@Produces(MediaType.APPLICATION_JSON)
//	public Response echo(@HeaderParam("Cookie") String cookieList) {
//		return Response.status(200)
//				.entity("You sent me cookies: " + cookieList)
//					.build();
//	}
	
	/*
	@GET
	@Produces({MediaType.TEXT_PLAIN})
	public Response getMyCookies(
			@MatrixParam(value = "userid") String userid,
			@MatrixParam(value = "version") String version) {
		return Response.status(200)
				.entity("Your URL contains: " + userid + " and " + version).build();
	}*/
	
	
	
	@DELETE
	@Path("{id}")
	public void deleteFilme(@PathParam("id") Long id) {
//		dao.findById(id, new Filme());
		dao.delete(id);
	}
	
	@POST
	@Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
	public void create(Filme filme) {
//		System.out.println(filme.getAnoLancamento());
		
		LocalDate localDate = filme.getAnoLancamento()
				.toInstant()
					.atZone(ZoneId.systemDefault())
						.toLocalDate()
							.plusDays(1l);
		LocalDateTime localDateTime = localDate.atStartOfDay();
		filme.setAnoLancamento(Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant()));
		
		dao.insert(filme);
	}
	
//	@POST
//	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
//	public void post(@FormParam("diretor") String titulo,
//			@FormParam("imdb") String code,
//			@FormParam("ano") Date ano) {
//		
//		Filme filme = new Filme();
//		
//		filme.setTitulo(titulo);
//		filme.setImdbCode(code);
//		filme.setAnoLancamento(ano);
//		
//		dao.insert(filme);
//		
//	}
	
	@PUT
	@Path("{id}")
//	@Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON, MediaType.MULTIPART_FORM_DATA})
	@Consumes(MediaType.APPLICATION_JSON)
	public void edit(@PathParam("id") Long id, Filme filme) {
		
		Filme old = dao.findById(id);
		
		LocalDate localDate = filme.getAnoLancamento()
				.toInstant()
					.atZone(ZoneId.systemDefault())
						.toLocalDate()
							.plusDays(1l);
		LocalDateTime localDateTime = localDate.atStartOfDay();
		filme.setAnoLancamento(Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant()));
		
		old.setAnoLancamento(filme.getAnoLancamento());
		old.setTitulo(filme.getTitulo());
		dao.update(filme);
	}
	
	/* Exemplos ussando injeção de Context
	@PUT
	public void metodo(@Context HttpHeaders headers) {
		String m = request.getMethod();
		URI ap = uriInfo.getAbsolutePath();
		Map<String, Cookie> c = headers.getCookies();
	}
	@GET @Path("auth")
	public void login(@Context SecurityContext sc) {
		String userid =
				sc.getUserPrincipal().getName();
		//(if sc.isUserInRole("admin")) { ... }
	}*/
	
	/*@GET
	public String getParams(@Context UriInfo ui,
	@Context HttpHeaders hh) {
		MultivaluedMap<String, String> queryParams =
				ui.getQueryParameters();
		MultivaluedMap<String, String> pathParams =
				ui.getPathParameters();
		MultivaluedMap<String, String> headerParams =
				hh.getRequestHeaders();
		Map<String, Cookie> cookieParams =
				hh.getCookies();
		return "queryParams: " + queryParams;

	}*/
}
