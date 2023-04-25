package br.com.kiman.curso.dominio.Dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import br.com.kiman.curso.dominio.model.ItemPedido;
import br.com.kiman.curso.dominio.model.Pedido;


public class PedidoDao {
	
	@PersistenceContext(unitName = "kiprevPU")
	EntityManager em;
	
	@SuppressWarnings("unchecked")
	public List<Pedido> findAll() {
		return (List<Pedido>) em.createQuery("SELECT p FROM Pedido p").getResultList();
	}

	public Pedido findById(Long id) {
		Pedido pedido = em.find(Pedido.class, id);
		return pedido;
	}
	
	public List<Pedido> findByFilter(Long idCliente, Long idProduto, Date dataInicio, Date dataFinal) {
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Pedido> query = cb.createQuery(Pedido.class);
		Root<Pedido> raiz = query.from(Pedido.class);
		
		Join<Pedido, ItemPedido> itemPedido = raiz.join("itemPedido");
		
		Predicate condicaoIdCliente = cb.equal(raiz.get("idCliente"), idCliente);
		Predicate condicaoIdProduto = cb.equal(itemPedido.get("idProduto"), idProduto);
		Predicate condicaoIntervalo = cb.between(raiz.get("dataPedido"), dataInicio, dataFinal);
//		
		Predicate filtro = cb.or(condicaoIdCliente, condicaoIdProduto, condicaoIntervalo);
		
		query.where(filtro);
		query.select(raiz);
		
		TypedQuery<Pedido> consulta = em.createQuery(query);
		
		List<Pedido> result = consulta.getResultList();
		return result;
//		return null;
	}

	public List<Pedido> findByFilter(Long idCliente, Long idProduto) {
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Pedido> query = cb.createQuery(Pedido.class);
		Root<Pedido> raiz = query.from(Pedido.class);
		
		Join<Pedido, ItemPedido> itemPedido = raiz.join("itemPedido");
		
		Predicate condicaoIdCliente = cb.equal(raiz.get("idCliente"), idCliente);
		Predicate condicaoIdProduto = cb.equal(itemPedido.get("idProduto"), idProduto);
//		
		Predicate filtro = cb.or(condicaoIdCliente, condicaoIdProduto);
		
		query.where(filtro);
		query.select(raiz);
		
		TypedQuery<Pedido> consulta = em.createQuery(query);
		
		List<Pedido> result = consulta.getResultList();
		return result;
//		return null;
	}

	public Long getSequence() {
		Query query = em.createNativeQuery("SELECT id_pedido_sequence.NEXTVAL FROM dual"); 
		BigDecimal num = (BigDecimal) query.getSingleResult();
		return num.longValue();
	}

	@Transactional
	public void delete(Pedido pedido) {
		em.remove(pedido);
	}

	@Transactional
	public void update(Pedido pedido) {
		em.merge(pedido);
	}

	@Transactional
	public void insert(Pedido pedido) {
		em.persist(pedido);
	}
	
	public Double valorTotal(Long id) {
		Query query = em.createQuery("SELECT SUM(i.quantidade * i.precoUnitario) " + "FROM   ItemPedido i "
				+ "GROUP  BY i.itemPedidoId.idPedido " + "HAVING i.itemPedidoId.idPedido = :id");

		query.setParameter("id", id);
		Double result = (Double) query.getSingleResult();

		return result;

	}

}
