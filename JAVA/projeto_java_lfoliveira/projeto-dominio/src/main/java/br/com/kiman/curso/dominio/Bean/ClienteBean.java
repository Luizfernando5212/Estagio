package br.com.kiman.curso.dominio.Bean;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;
import javax.inject.Inject;

import br.com.kiman.curso.dominio.Dao.ClienteDao;
import br.com.kiman.curso.dominio.Dao.ListaPrecoDao;
import br.com.kiman.curso.dominio.Dto.ClienteDto;
import br.com.kiman.curso.dominio.Dto.ListaPrecoDto;
import br.com.kiman.curso.dominio.conversor.Conversor;
import br.com.kiman.curso.dominio.exception.ErroInfo;
import br.com.kiman.curso.dominio.model.Cliente;
import br.com.kiman.curso.dominio.model.ListaPreco;
import br.com.kiman.curso.dominio.model.ListaPrecoId;

@Stateless
public class ClienteBean {
	
	@Inject
	ClienteDao clienteDao;
	
	@Inject
	ListaPrecoDao listaPrecoDao;
	
	public List<ClienteDto> findAll() {
		List<Cliente> clientes = clienteDao.findAll();
		List<ClienteDto> novoCliente = new ArrayList<ClienteDto>();
		for(Cliente cliente : clientes){
			if (cliente.getAtivo() == 1l)
				novoCliente.add(Conversor.converteParaClienteDto(cliente));
		}
		return novoCliente;
	}
	
	public ClienteDto findById(Long id) {
		ClienteDto clienteDto = Conversor.converteParaClienteDto(clienteDao.findById(id));
		Cliente cliente = clienteDao.findById(id);
		
		List<ListaPreco> lista = cliente.getPrecos();
		List<ListaPrecoDto> listaPrecoDto = new ArrayList<ListaPrecoDto>();
		
		for(ListaPreco listaPreco : lista)
			listaPrecoDto.add(Conversor.converteParaListaPrecoDto(listaPreco));
		
		clienteDto.setPrecos(listaPrecoDto);
		return clienteDto;
	}
	
	public List<ClienteDto> findByFilter(String nome, String cpf) {
		if (nome.equals("oi") && cpf.equals("oi")) 
			return this.findAll();
		else {
			List<Cliente> clientes = clienteDao.findByFilter(nome, cpf);
			List<ClienteDto> clientesDto = new ArrayList<ClienteDto>();
			
			for(Cliente cliente : clientes) 
				clientesDto.add(Conversor.converteParaClienteDto(cliente));
			
			return clientesDto;
		}
	}
	
	public void insertCliente(Cliente cliente) throws Exception {
		if (cliente.getNome().length() >= 3 
				&& clienteDao.validaCpf(cliente.getCpf()) 
					&& cliente.getAtivo() != null)
			clienteDao.insert(cliente);
		else {
			throw new Exception("" + new ErroInfo("(nome, cpf ou ativo)", "Algum dos requisitos está fora do padrão"));
		}
	}
	
	public void UpdateCliente(Long id, Cliente cliente) throws Exception {
		if (cliente.getNome().length() >= 3 && clienteDao.validaCpf(cliente.getCpf())) {
			Cliente oldCliente = clienteDao.findById(id);
			oldCliente.setNome(cliente.getNome());
			oldCliente.setCpf(cliente.getCpf());
			clienteDao.update(oldCliente);
		} else {
			throw new Exception("" + new ErroInfo("(nome, cpf)", "Algum dos requisitos está fora do padrão"));
		}
	}
	
	public void ativarCliente(Long id) {
		Cliente cliente = clienteDao.findById(id);
		cliente.setAtivo(1l);
		clienteDao.update(cliente);
	}
	
	public void inativarCliente(Long id) {
		Cliente cliente = clienteDao.findById(id);
		System.out.println(cliente);
		cliente.setAtivo(0l);
		System.out.println((cliente));
		clienteDao.update(cliente);
	}
	
	public void insertListaPreco(ClienteDto cliente) {
		for (ListaPrecoDto listaPrecoDto : cliente.getPrecos()) {
			
			ListaPreco listaPreco = new ListaPreco();
			ListaPrecoId listaPrecoId = new ListaPrecoId();
			
			listaPrecoId.setIdCliente(cliente.getId());
			listaPrecoId.setIdProduto(listaPrecoDto.getIdProduto());
			
			listaPreco.setListaPrecoId(listaPrecoId);
			listaPreco.setPrecoUnitario(listaPrecoDto.getPrecoUnitario());
			
			listaPrecoDao.insert(listaPreco);
		}
	}
	
	public void updateListaPreco(ClienteDto clienteDto) {
		for (ListaPrecoDto listaPrecoDto : clienteDto.getPrecos()) {
			ListaPreco oldListaPreco = listaPrecoDao.findById(clienteDto.getId()
					, listaPrecoDto.getIdProduto());
			
			oldListaPreco.setPrecoUnitario(listaPrecoDto.getPrecoUnitario());
			listaPrecoDao.update(oldListaPreco);
		}
	}
}
