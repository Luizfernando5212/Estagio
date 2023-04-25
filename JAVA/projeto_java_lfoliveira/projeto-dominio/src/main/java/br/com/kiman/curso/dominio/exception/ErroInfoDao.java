package br.com.kiman.curso.dominio.exception;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public class ErroInfoDao {
	
	@PersistenceContext(unitName = "kiprevPU")
	EntityManager em;
	
	public void insert(ErroInfo erroInfo) {
		em.persist(erroInfo);
	}
}
