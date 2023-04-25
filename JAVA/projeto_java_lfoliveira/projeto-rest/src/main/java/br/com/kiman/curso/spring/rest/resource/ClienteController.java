package br.com.kiman.curso.spring.rest.resource;

import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
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

import br.com.kiman.curso.dominio.Bean.ClienteBean;
import br.com.kiman.curso.dominio.Dao.ClienteDao;
import br.com.kiman.curso.dominio.Dto.ClienteDto;
import br.com.kiman.curso.dominio.exception.ErroInfo;
import br.com.kiman.curso.dominio.model.Cliente;

@Path("/cliente")
@Consumes(value = { MediaType.APPLICATION_JSON })
public class ClienteController {
	
	@Inject
	ClienteDao clienteDao;
	
	@Inject
	ClienteBean clienteBean;

//	@GET
//	@Produces(MediaType.APPLICATION_JSON)
//	public Response getClientes() {
//		List<ClienteDto> novoCliente = clienteBean.findAll();
//		return Response.ok(novoCliente).build();
//	}
	
	@GET
	@Path("{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getCliente(@PathParam("id") Long id) throws Exception {
		try {
			ClienteDto clienteDto = clienteBean.findById(id);
			return Response.ok(clienteDto).build();
		} catch(Exception e) {
			return Response.status(302).entity(new ErroInfo("id", "Número de id não encontrado")).build();
		}
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getClientesPorNomeOuCpf(@DefaultValue("oi") @QueryParam("nome") String nome,
			@DefaultValue("oi") @QueryParam("cpf") String cpf) {
		List<ClienteDto> clientesDto = clienteBean.findByFilter(nome, cpf);
		
		if (clientesDto.size() == 0)
			return Response.status(204).build();
		else
			return Response.ok(clientesDto).build();
	}
	
	@POST
	public void createCliente(Cliente cliente) throws Exception {
		clienteBean.insertCliente(cliente);
	}
	
	@PUT
	@Path("{id}")
	public void updateCliente(@PathParam("id") Long id, Cliente cliente) throws Exception {
		clienteBean.UpdateCliente(id, cliente);
	}
	
	@POST
	@Path("/listaPreco")
	public void createListaPreco(ClienteDto cliente) {
		clienteBean.insertListaPreco(cliente);
	}
	
	@PUT
	@Path("/listaPreco/update")
	public void updateListaPreco(ClienteDto cliente) {
		clienteBean.updateListaPreco(cliente);
	}
	
	@PUT
	@Path("/inativar/{id}")
	public void inativarCliente(@PathParam("id") Long id) {
		clienteBean.inativarCliente(id);
	}
	
	@PUT
	@Path("/ativar/{id}")
	public void ativarCliente(@PathParam("id") Long id) {
		clienteBean.ativarCliente(id);
	}
}
