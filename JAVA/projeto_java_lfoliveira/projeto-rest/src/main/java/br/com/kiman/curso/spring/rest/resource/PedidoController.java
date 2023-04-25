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

import br.com.kiman.curso.dominio.Bean.PedidoBean;
import br.com.kiman.curso.dominio.Dto.PedidoDto;
import br.com.kiman.curso.dominio.exception.ErroInfo;
import br.com.kiman.curso.dominio.model.Pedido;


@Path("/pedido")
@Consumes(value = { MediaType.APPLICATION_JSON })
public class PedidoController {
	
	@Inject
	PedidoBean pedidoBean;

//	@GET
//	@Produces(MediaType.APPLICATION_JSON)
//	public Response getPedidos() {
//		List<PedidoDto> novoPedido = pedidoBean.findAll();
//		return Response.ok(novoPedido).build();
//	}
	
	@GET
	@Path("{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getPedido(@PathParam("id") Long id) {
		try {
			PedidoDto pedidoDto = pedidoBean.findById(id);
			return Response.ok(pedidoDto).build();
		} catch(Exception e) {
			return Response.status(302).entity(new ErroInfo("id", "Número de id não encontrado")).build();
		}
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getPedidoPorFiltro(@DefaultValue("0") @QueryParam("idCliente") Long idCliente,
			@DefaultValue("0") @QueryParam("idProduto") Long idProduto,
			@DefaultValue("empty") @QueryParam("dataInicio") String dataInicio,
			@DefaultValue("empty") @QueryParam("dataFinal") String dataFinal) {
		List<PedidoDto> pedidosDto = null;

		pedidosDto = pedidoBean.findByFilter(idCliente, idProduto, dataInicio, dataFinal);
	
		if (pedidosDto.size() == 0)
			return Response.status(204).build();
		else
			return Response.ok(pedidosDto).build();
	}

	
	@POST
	public void createPedido(Pedido pedido) {
		try {
			pedidoBean.inserirPedido(pedido);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PUT
	@Path("{id}")
	public void updatePedido(@PathParam("id") Long id, Pedido pedido) throws Exception {
		pedidoBean.UpdatePedido(id, pedido);
	}

}
