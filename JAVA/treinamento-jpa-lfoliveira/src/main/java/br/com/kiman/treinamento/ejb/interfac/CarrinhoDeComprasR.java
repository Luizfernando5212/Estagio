package br.com.kiman.treinamento.ejb.interfac;

import java.util.List;

import javax.ejb.Remote;

import br.com.kiman.treinamento.ejb.modelo.ItemPedido;

@Remote
public interface CarrinhoDeComprasR {
	
	public void adicionarItem(ItemPedido item);
	
	public void removerItem(ItemPedido item);
	
	public List<ItemPedido> findAll();
	
	public ItemPedido findById (Long id);
	
	public void atualizarItem(ItemPedido item);

}
