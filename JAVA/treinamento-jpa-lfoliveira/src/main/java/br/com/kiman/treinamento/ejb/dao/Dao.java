package br.com.kiman.treinamento.ejb.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

public class Dao {

	@PersistenceContext(unitName = "tutorial-jpa")
	EntityManager em;

	public List<?> findById(Long id) {
		TypedQuery<?> query = (TypedQuery<?>) em
				.createQuery("SELECT i FROM ItemPedido i" + " WHERE i.itemPedidoId.idPedido = :id");
//		Pedido pedido = em.find(Pedido.class, id);
		query.setParameter("id", id);
		return query.getResultList();
	}

	public List<?> findAll() {
		return em.createQuery("SELECT o FROM " + "ItemPedido" + " o").getResultList();
	}

	public Double valorTotal(Long id) {
		Query query = em.createQuery("SELECT SUM(i.quantidade * i.precoUnitario) " + "FROM   ItemPedido i "
				+ "GROUP  BY i.itemPedidoId.idPedido " + "HAVING i.itemPedidoId.idPedido = :id");

		query.setParameter("id", id);
		Double result = (Double) query.getSingleResult();

		return result;

	}

	@Transactional
	public void delete(Object objeto) {
		em.remove(objeto);
	}

	@Transactional
	public void update(Object objeto) {
		em.merge(objeto);
	}

	@Transactional
	public Object insert(Object objeto) {
		return em.merge(objeto);
	}

}
