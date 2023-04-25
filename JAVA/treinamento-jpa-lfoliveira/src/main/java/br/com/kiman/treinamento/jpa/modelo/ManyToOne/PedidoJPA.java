package br.com.kiman.treinamento.jpa.modelo.ManyToOne;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class PedidoJPA {
	
	@Id @GeneratedValue
	int id;
	
	@OneToMany(mappedBy="pedido")
	private Set<Item> itens = new HashSet<Item>();

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Set<Item> getItens() {
		return itens;
	}

	public void setItens(Set<Item> itens) {
		this.itens = itens;
	}
	
	public void addItem(Item item) {
		itens.add(item);
		item.setPedido(this);
	}
	
	public double subtotal() {
		double subtotal = 0;
		for (Item item : itens) {
			subtotal += item.subtotal();
		}
		return subtotal;
	}
}
