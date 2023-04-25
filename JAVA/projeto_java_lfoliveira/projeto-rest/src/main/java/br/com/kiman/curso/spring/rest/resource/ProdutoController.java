package br.com.kiman.curso.spring.rest.resource;

import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import br.com.kiman.curso.dominio.Bean.ProdutoBean;
import br.com.kiman.curso.dominio.exception.ErroInfo;
import br.com.kiman.curso.dominio.model.Produto;

@Path("/produto")
@Consumes(value = { MediaType.APPLICATION_JSON })
public class ProdutoController {
	
	@Inject
	ProdutoBean produtoBean;

//	@GET
//	@Produces(MediaType.APPLICATION_JSON)
//	public Response getProdutos() {
//		List<Produto> produtos = produtoBean.findAll();
//		return Response.ok(produtos).build();
//	}
	
	@GET
	@Path("{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getProduto(@PathParam("id") Long id) {
		try {
			Produto produto = produtoBean.findById(id);
			return Response.ok(produto).build();
		} catch(Exception e) {
			return Response.status(302).entity(new ErroInfo("id", "Número de id não encontrado")).build();
		}
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getByFiltro(@DefaultValue("empty") 
											@QueryParam("descricao") String descricao) {
		List<Produto> produtos = produtoBean.findByFilter(descricao);
		
		if (produtos.size() == 0)
			return Response.status(204).build();
		else
			return Response.ok(produtos).build();
	}
	
	@POST
	public void createProduto(Produto produto) {
		produtoBean.insertProduto(produto);
	}
	
	@PUT
	@Path("{id}")
	public void updateProduto(@PathParam("id") Long id, Produto produto) {
		produtoBean.updateProduto(id, produto);
	}
	
	@DELETE
	@Path("{id}")
	public void deleteProduto(@PathParam("id") Long id) {
		produtoBean.deleteProduto(id);
	}
}
