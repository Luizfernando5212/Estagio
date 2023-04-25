package br.com.kiman.curso.dominio.Dao;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
//import javax.persistence.StoredProcedureQuery;
import javax.transaction.Transactional;

import br.com.kiman.curso.dominio.model.Cliente;

public class ClienteDao {
	
	@PersistenceContext(unitName = "kiprevPU")
	EntityManager em;
	
	@SuppressWarnings("unchecked")
	public List<Cliente> findAll(){
		return (List<Cliente>)em.createQuery("SELECT c FROM Cliente c").getResultList();
	}
	
	public List<Cliente> findByFilter(String nome, String cpf) {
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Cliente> query = cb.createQuery(Cliente.class);
		Root<Cliente> raiz = query.from(Cliente.class);
		
		Predicate condicaoNome = cb.like(raiz.get("nome"), nome + "%");
		Predicate condicaoCpf = cb.like(raiz.get("cpf"), cpf + "%");
		Predicate filtro = cb.or(condicaoNome, condicaoCpf);
		
		query.where(filtro);
		query.select(raiz);
		
		TypedQuery<Cliente> consulta = em.createQuery(query);
		
		try {
			List<Cliente> result = consulta.getResultList();
			return result;

		} catch(Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public Boolean validaCpf(String cpf) {
		BigDecimal result = (BigDecimal) em.createNativeQuery("select cpf_pkg.valida_cpf(:cpf) from dual")
				.setParameter("cpf", cpf)
				.getSingleResult();
		return 0 == result.compareTo(new BigDecimal(1));

	}
	
	public Cliente findById(Long id) {
		return em.find(Cliente.class, id);
	}
	
	@Transactional
	public void delete(Long id) {
		em.remove(em.find(Cliente.class, id));
	}
	
	@Transactional
	public void update(Cliente cliente) {
		em.merge(cliente);
	}
	
	@Transactional
	public void insert(Cliente cliente) {
		em.merge(cliente);
	}
	
//	public void validaCpf(String cpf) {
//		StoredProcedureQuery query = em.createStoredF
//	}

}
