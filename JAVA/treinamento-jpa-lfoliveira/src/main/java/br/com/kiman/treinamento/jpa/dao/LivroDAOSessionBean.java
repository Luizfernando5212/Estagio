package br.com.kiman.treinamento.jpa.dao;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
public class LivroDAOSessionBean {
	
	@PersistenceContext(unitName = "tutorial-jpa")
	private EntityManager em;
	
	public List<?> findAll(String nome){
		List<?> lista = em.createNamedQuery(nome).getResultList();
		return lista;
	}
}
