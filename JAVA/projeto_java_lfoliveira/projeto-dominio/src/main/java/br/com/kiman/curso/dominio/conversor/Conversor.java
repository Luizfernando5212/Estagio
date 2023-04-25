package br.com.kiman.curso.dominio.conversor;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import br.com.kiman.curso.dominio.Dto.ClienteDto;
import br.com.kiman.curso.dominio.Dto.ItemPedidoDto;
import br.com.kiman.curso.dominio.Dto.ListaPrecoDto;
import br.com.kiman.curso.dominio.Dto.PedidoDto;
import br.com.kiman.curso.dominio.model.Cliente;
import br.com.kiman.curso.dominio.model.ItemPedido;
import br.com.kiman.curso.dominio.model.ListaPreco;
import br.com.kiman.curso.dominio.model.Pedido;

public class Conversor {
	public static ClienteDto converteParaClienteDto(Cliente cliente) {
		ClienteDto clienteDTO = new ClienteDto(cliente.getId(),
				cliente.getNome(),
				cliente.getCpf());
		return clienteDTO;
	}
	
//	public static Cliente converteParaCliente(ClienteDto clienteDto) {
//		Cliente cliente = new Cliente();
//		cliente.set
//		
//		
//		return cliente;
//	}
	
	public static ListaPrecoDto converteParaListaPrecoDto(ListaPreco lista) {
		ListaPrecoDto listaDto = new ListaPrecoDto(lista.getListaPrecoId().getIdProduto(),
				lista.getProduto().getDescricao(),
				lista.getPrecoUnitario());
		
		return listaDto;
	}
	
	public static PedidoDto converteParaPedido(Pedido pedido, Double valorTotal) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		PedidoDto pedidoDto = new PedidoDto(pedido.getIdPedido(),
				pedido.getCliente().getId(),
				pedido.getCliente().getNome(),
				pedido.getCliente().getCpf(),
				df.format(pedido.getDataPedido()),
				valorTotal);
		try {
			pedidoDto.setDataEntrega(df.format(pedido.getDataEntrega()));
		} catch(Exception e) {}
		
		return pedidoDto;
	}
	
	public static ItemPedidoDto converteParaItemPedido(ItemPedido itemPedido) {
		ItemPedidoDto itemPedidoDto = new ItemPedidoDto(
				itemPedido.getItemPedidoId().getNumItem(),
				itemPedido.getIdProduto(),
				itemPedido.getProduto().getDescricao(),
				itemPedido.getPreco(),
				itemPedido.getQuantidade());
		return itemPedidoDto;
	}
}
