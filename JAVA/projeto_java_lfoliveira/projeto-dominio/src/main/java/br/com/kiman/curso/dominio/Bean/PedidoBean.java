package br.com.kiman.curso.dominio.Bean;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.ejb.Stateless;
import javax.inject.Inject;

import br.com.kiman.curso.dominio.Dao.ItemPedidoDao;
import br.com.kiman.curso.dominio.Dao.PedidoDao;
import br.com.kiman.curso.dominio.Dto.ItemPedidoDto;
import br.com.kiman.curso.dominio.Dto.PedidoDto;
import br.com.kiman.curso.dominio.conversor.Conversor;
import br.com.kiman.curso.dominio.model.ItemPedido;
import br.com.kiman.curso.dominio.model.ItemPedidoId;
import br.com.kiman.curso.dominio.model.Pedido;

@Stateless
public class PedidoBean {
	
	@Inject
	PedidoDao pedidoDao;
	
	@Inject
	ItemPedidoDao itemPedidoDao;
	
	public List<PedidoDto> findAll(){
		List<Pedido> pedidos = pedidoDao.findAll();
		List<PedidoDto> pedidoDto = new ArrayList<PedidoDto>();	
		
		for(Pedido pedido : pedidos) 
			pedidoDto.add(Conversor.converteParaPedido(pedido, valorTotal(pedido)));
		
		return pedidoDto;
	}
	
	public PedidoDto findById(Long id) {
		Pedido pedido = pedidoDao.findById(id);
		PedidoDto pedidoDto = Conversor.converteParaPedido(pedido, valorTotal(pedido));
		
		List<ItemPedido> item = pedido.getItens();
		List<ItemPedidoDto> itemPedidoDto = new ArrayList<ItemPedidoDto>();
		
		for(ItemPedido itemPedido : item) 
			itemPedidoDto.add(Conversor.converteParaItemPedido(itemPedido));
		
		pedidoDto.setItens(itemPedidoDto);
		return pedidoDto;
	}
	
	public List<PedidoDto> findByFilter(Long idCliente, Long idProduto, String dataInicio, String dataFinal){
		if (idCliente.equals(0l) && idProduto.equals(0l) && 
				dataInicio.equals("empty") && dataFinal.equals("empty")) {
			return this.findAll();
		} else {
			try {
				SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
				Date nDataInicio = (Date) fm.parse(dataInicio);
				Date nDataFinal = (Date) fm.parse(dataFinal);
			
				List<Pedido> pedidos = pedidoDao.findByFilter(idCliente, idProduto, nDataInicio, nDataFinal);
				List<PedidoDto> pedidosDto = new ArrayList<PedidoDto>();
				
				for(Pedido pedido : pedidos) {
					pedidosDto.add(Conversor.converteParaPedido(pedido, valorTotal(pedido)));
				}
				
				return pedidosDto;
				
			} catch(Exception e) {
				List<Pedido> pedidos = pedidoDao.findByFilter(idCliente, idProduto);
				List<PedidoDto> pedidosDto = new ArrayList<PedidoDto>();
				
				for(Pedido pedido : pedidos) {
					pedidosDto.add(Conversor.converteParaPedido(pedido, valorTotal(pedido)));
				}
				
				return pedidosDto;
			}
		}
	}
	
	public void inserirPedido(Pedido pedido) throws Exception {
		if (!(pedido.getDataEntrega() == null))
			throw new Exception("Data de entrega não pode receber valor na criação.");
		
		if(verificaPedido(pedido)) {
			Pedido newPedido = new Pedido();
			
			newPedido.setIdCliente(pedido.getIdCliente());
			newPedido.setDataPedido(pedido.getDataPedido());
			newPedido.setIdPedido(pedidoDao.getSequence());
			
			pedidoDao.insert(newPedido);
			
			Long numItem = 1l;
			pedido.setIdPedido(newPedido.getIdPedido());
			for (ItemPedido itemPedido : pedido.getItens()) {
				
				ItemPedidoId itemPedidoId = new ItemPedidoId();
				
				itemPedidoId.setIdPedido(pedido.getIdPedido());
				itemPedidoId.setNumItem(numItem);
				
				itemPedido.setItemPedidoId(itemPedidoId);
				numItem += 1l;
				
				itemPedidoDao.insert(itemPedido);
			}
//			pedidoDao.insert(pedido);
		} else {
			System.out.println("não rolou.");
		}
	}
	
	public void UpdatePedido(Long id, Pedido pedido) throws Exception {
		Pedido oldPedido = pedidoDao.findById(id);
		if (pedido.getDataEntrega() == null || pedido.getDataEntrega().compareTo(oldPedido.getDataPedido()) < 0)
			throw new Exception("Data de entrega não pode ser anterior a data do pedido.");
		else {
			oldPedido.setDataEntrega(pedido.getDataEntrega());
			pedidoDao.update(oldPedido);
		}
	}
	
	public Boolean verificaPedido(Pedido pedido) {
		Boolean result = true;
		
		result = !(pedido.getDataPedido() == null);
		result = !(pedido.getIdCliente() == null);
		
		Set<Long> produtos = new HashSet<Long>();
		
		for(ItemPedido itemPedido : pedido.getItens()) {
			
			int comparePreco = Double.compare(itemPedido.getPreco(), 0.0);
			int compareQuantidade = Double.compare(itemPedido.getQuantidade(), 0.0);
			
			if (!produtos.contains(itemPedido.getIdProduto()) && 
					!(comparePreco <= 0) && !(compareQuantidade <= 0))
				produtos.add(itemPedido.getIdProduto());
			else
				result = false;	
		}
		return result;
	}
	
	public Double valorTotal(Pedido pedido) {
		
		Double scale = Math.pow(10, 2);
		
		Double total = 0.0;
		for (ItemPedido itemPedido : pedido.getItens()) {
			total += itemPedido.getPreco() * itemPedido.getQuantidade();
		}
		
		return Math.round(total*scale)/scale;
	}
}
