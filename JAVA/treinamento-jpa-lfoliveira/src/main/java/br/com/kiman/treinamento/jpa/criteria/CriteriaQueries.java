package br.com.kiman.treinamento.jpa.criteria;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import br.com.kiman.treinamento.jpa.modelo.Departments;
import br.com.kiman.treinamento.jpa.modelo.Employees;
import br.com.kiman.treinamento.jpa.modelo.Livro;

@Stateless
public class CriteriaQueries {
	
	@PersistenceContext(unitName = "tutorial-jpa")
	private EntityManager em;
	
	public List<Livro> menorQue(int numero){
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Livro> query = cb.createQuery(Livro.class); // Tipo do Select
		Root<Livro> raiz = query.from(Livro.class); // Tipo do From
		Predicate condicao = cb.lessThan(raiz.get("paginas"), numero); // Predicado/Condição
		
		query.where(condicao); // Adiciona a clausula Where
		query.select(raiz);	// Adiciona a clausula Select
		
		TypedQuery<Livro> consulta = em.createQuery(query);
		List<Livro> result = consulta.getResultList();
		
		return result;
	}
	
	public List<Livro> intervalo(int menor, int maior) {
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Livro> query = cb.createQuery(Livro.class);
		Root<Livro> raiz = query.from(Livro.class);
		Predicate condicao = cb.between(raiz.get("paginas"), menor, maior);
		
		query.where(condicao);
		query.select(raiz);
		
		TypedQuery<Livro> consulta = em.createQuery(query);
		List<Livro> result = consulta.getResultList();
		
		return result;
	}
	
	public List<Livro> estaEntre(List<Integer> num){
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Livro> query = cb.createQuery(Livro.class);
		Root<Livro> raiz = query.from(Livro.class);
//		Predicate condicao = (raiz.get("id"));
		
		query.where(raiz.get("id").in(num));
		query.select(raiz);
		
		TypedQuery<Livro> consulta = em.createQuery(query);
		List<Livro> result = consulta.getResultList();
		
		return result;
	}
	
	public List<Object[]> agrupamento() {
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Object[]> query = cb.createQuery(Object[].class);
		Root<Livro> raiz = query.from(Livro.class);
		
		query.multiselect(raiz.get("paginas"), cb.count(raiz));
		query.groupBy(raiz.get("paginas"));
		
		TypedQuery<Object[]> consulta = em.createQuery(query);
		List<Object[]> result = consulta.getResultList(); 
		
		
		return result;
	}
	
	@SuppressWarnings("unused")
	public List<Employees> join(){
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Employees> query = cb.createQuery(Employees.class);
		Root<Employees> raiz = query.from(Employees.class);
		
		Join<Employees, Departments> funcionario = raiz.join("departmentId");
		
		query.select(raiz);
		
		TypedQuery<Employees> consulta = em.createQuery(query);
		List<Employees> result = consulta.getResultList();
		return result;
	}
	
}
