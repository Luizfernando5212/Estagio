package br.com.kiman.treinamento.jpa.dao;

import java.util.List;

import javax.inject.Named;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import br.com.kiman.treinamento.jpa.modelo.Filme;
import br.com.kiman.treinamento.jpa.modelo.Livro;


@SuppressWarnings("unused")
@Named("livroManagedBean")
public class LivroDAOManagedBean {
	
//	@Inject
	@PersistenceContext//(unitName = "tutorial-jpa")
	EntityManager em;
	
	public Object findById(Long id, Object objeto) {
		Query query = em.createQuery("SELECT o FROM " + objeto.toString() + 
						   		     " o WHERE id = :id");
		query.setParameter("id", id);
		return query.getSingleResult();
	}
	
	public List<?> findAll(Object objeto){
		return em.createQuery("SELECT o FROM " + objeto.toString() + " o").getResultList();
	}
	
	public Filme findByIMDBCode(String codigo) {
		Query query = em.createQuery("SELECT o FROM Filme o"
								   + " WHERE imdbCode = :code");
		
		query.setParameter("code", codigo);
		
		return (Filme) query.getSingleResult();
	}
	
	@Transactional
	public void delete(Livro objeto) {
		em.remove(objeto);
	}
	
	@Transactional
	public void delete(Long id) {
		em.remove(em.find(Filme.class, id));
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
