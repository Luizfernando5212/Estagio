package br.com.kiman.curso.dominio.Dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import br.com.kiman.curso.dominio.model.Produto;

public class ProdutoDao {

	@PersistenceContext(unitName = "kiprevPU")
	EntityManager em;
	
	@SuppressWarnings("unchecked")
	public List<Produto> findAll() {
		return (List<Produto>)em.createQuery("SELECT p FROM Produto p").getResultList();
	}
	
	public Produto findById(Long id) {
		return em.find(Produto.class, id);
	}
	
	public List<Produto> findByDescricao(String descricao){
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Produto> query = cb.createQuery(Produto.class);
		Root<Produto> raiz = query.from(Produto.class);
		
		Predicate condicaoDescricao = cb.like(raiz.get("descricao"), descricao+ "%");
		
		query.where(condicaoDescricao);
		query.select(raiz);
		
		TypedQuery<Produto> consulta = em.createQuery(query);
		
		try {
			List<Produto> result = consulta.getResultList();
			return result;

		} catch(Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	@Transactional
	public void update(Produto produto) {
		em.merge(produto);
	}
	
	@Transactional
	public void delete(Long id) {
		em.remove(em.find(Produto.class, id));
	}
	
	@Transactional
	public void insert(Produto produto) {
		em.merge(produto);
	}
}	
