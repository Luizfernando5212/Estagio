package br.com.kiman.treinamento.jpa.dao;

//import java.text.SimpleDateFormat;
//import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import br.com.kiman.treinamento.jpa.modelo.Filme;

public class FilmeDao {
	
	@PersistenceContext//(unitName = "tutorial-jpa")
	EntityManager em;
	
	public Filme findById(Long id) {
		Query query = em.createQuery("SELECT o FROM " + "Filme" + 
						   		     " o WHERE id = :id");
		query.setParameter("id", id);
		return (Filme) query.getSingleResult();
	}
	
	public List<?> findAll(){
		return em.createQuery("SELECT o FROM " + "Filme" + " o").getResultList();
	}
	
	public Filme findByIMDBCode(String codigo) {
		Query query = em.createQuery("SELECT o FROM Filme o"
								   + " WHERE imdbCode = :code");
		
		query.setParameter("code", codigo);
		
		return (Filme) query.getSingleResult();
	}
	
	public List<Filme> findByFilter(String titulo, Long id) {
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Filme> query = cb.createQuery(Filme.class);
		Root<Filme> raiz = query.from(Filme.class);
		
		Predicate condicaoNome = cb.like(raiz.get("titulo"), titulo + "%");
		Predicate condicaoId = cb.like(raiz.get("idFilme"), id + "%");
		
		Predicate filtro = cb.or(condicaoNome, condicaoId);
		
		query.where(filtro);
		query.select(raiz);
		
		TypedQuery<Filme> consulta = em.createQuery(query);
		
		try {
			List<Filme> result = consulta.getResultList();
			return result;

		} catch(Exception e) {
			System.out.println(e);
		}

		
		return null;
	}
	
	public List<?> findBetween(String anoMin, String anoMax){
		
//        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyyMMdd");
//        Date date = originalFormat.parse(anoMin.toString());
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Filme> query = cb.createQuery(Filme.class);
		Root<Filme> raiz = query.from(Filme.class);
		Predicate condicao = cb.between(raiz.get("ano_lancamento"), anoMin, anoMax);
		
		query.where(condicao);
		query.select(raiz);
		
		TypedQuery<Filme> consulta = em.createQuery(query);
		List<Filme> result = consulta.getResultList();
		
		return result;
	}
	
	@Transactional
	public void delete(Long id) {
		em.remove(em.find(Filme.class, id));
	}
	
	@Transactional
	public void update(Filme objeto) {
		em.merge(objeto);
	}
	
	@Transactional
	public Filme insert(Filme objeto) {
		return em.merge(objeto);
	}

}
