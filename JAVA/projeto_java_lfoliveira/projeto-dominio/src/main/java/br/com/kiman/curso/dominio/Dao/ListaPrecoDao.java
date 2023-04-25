package br.com.kiman.curso.dominio.Dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import br.com.kiman.curso.dominio.model.ListaPreco;

public class ListaPrecoDao {
	
	@PersistenceContext(unitName = "kiprevPU")
	EntityManager em;
	
	public ListaPreco findById(Long idCliente, Long idProduto) {
		
		Query query = em.createQuery("select lp from ListaPreco lp "
				+ "where lp.listaPrecoId.idCliente = :idCliente "
				+ "and lp.listaPrecoId.idProduto = : idProduto");
		
		query.setParameter("idCliente", idCliente);
		query.setParameter("idProduto", idProduto);
		ListaPreco listaPreco = (ListaPreco) query.getSingleResult();
		
		return listaPreco;
	}
	
	@Transactional
	public void update(ListaPreco listaPreco) {
		em.merge(listaPreco);
	}
	
	@Transactional
	public void insert(ListaPreco listaPreco) {
		em.merge(listaPreco);
	}
	
}
