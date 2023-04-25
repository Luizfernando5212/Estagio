package br.com.kiman.treinamento.jpa.modelo.OneToMany;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MapKey;
import javax.persistence.OneToMany;

@Entity
public class LojaVirtual {
	
	@Id @GeneratedValue
	private int id;
	
	@OneToMany(mappedBy = "lojaVirtual")
	@MapKey(name = "cpf")
	private Map<String, ClienteJPA> clientes = new HashMap<>();

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Map<String, ClienteJPA> getClientes() {
		return clientes;
	}

	public void setClientes(Map<String, ClienteJPA> clientes) {
		this.clientes = clientes;
	}
	
	
}
