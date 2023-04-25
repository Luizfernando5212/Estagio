package br.com.kiman.treinamento.ejb.modelo;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.ejb.PostActivate;
import javax.ejb.PrePassivate;
import javax.ejb.Remove;
import javax.ejb.Stateful;
import javax.inject.Inject;

import br.com.kiman.treinamento.ejb.dao.Dao;

@Stateful
public class CarrinhoDeCompras/* implements CarrinhoDeComprasR */{
	
	@Inject
	Dao dao;
	
	private Double valorCompra;

	public CarrinhoDeCompras() {
	}
	
	@SuppressWarnings("unchecked")
	public List<ItemPedido> findAll() {
		return (List<ItemPedido>) dao.findAll();
	}
	
	@SuppressWarnings("unchecked")
	public List<ItemPedido> findById (Long id) {
		this.valorCompra = dao.valorTotal(id);
		return (List<ItemPedido>) dao.findById(id);
	}
	
	public void adicionarItem(ItemPedido item) {
		dao.insert(item);
	}
	
	public void removerItem(ItemPedido item) {
		dao.delete(item);
	}
	
	public void atualizarItem(ItemPedido item) {
		dao.update(item);
	}
	
	public Double getValorCompra() {
		return valorCompra;
	}
	
	@Remove
	public void remover() {}
	
	@PostConstruct
	private void testePostConstruct() {
		System.out.println("Teste post Construct."); // Método é executado após a execução do construtor
	}
	
	@PreDestroy
	private void testePreDestroy() {
		System.out.println("Teste pre Destroy."); // Esse método normalmente é utilizado para liberar recursos
												  // que foram utilizados durante o funcionamento da aplicação
	}
	
	@PrePassivate
	private void testePrePassivate() {
		System.out.println("Teste pre Passivate.");
	}
	
	@PostActivate
	private void testePostActivate() {
		System.out.println("Teste post Activate.");
	}
	
}
