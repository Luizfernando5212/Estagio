package br.com.kiman.curso.dominio.Dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import br.com.kiman.curso.dominio.model.ItemPedido;

public class ItemPedidoDao {
	
	@PersistenceContext(unitName = "kiprevPU")
	EntityManager em;

	public List<?> findById(Long id) {
		TypedQuery<?> query = (TypedQuery<?>) em
				.createQuery("SELECT i FROM ItemPedido i" 
						+ " WHERE i.itemPedidoId.idPedido = :id");
		query.setParameter("id", id);
		return query.getResultList();
	}

	public List<?> findAll() {
		return em.createQuery("SELECT i FROM ItemPedido i").getResultList();
	}

	@Transactional
	public void delete(ItemPedido item) {
		em.remove(item);
	}

	@Transactional
	public void update(ItemPedido item) {
		em.merge(item);
	}

	@Transactional
	public void insert(ItemPedido item) {
		em.merge(item);
	}

}
