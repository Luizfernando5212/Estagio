package br.com.kiman.tarefas.dao;

import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import br.com.kiman.tarefas.modelo.Tarefa;

@Repository
public class JpaTarefaDao implements TarefaDao {

	@PersistenceContext
	EntityManager manager;
	
	public Tarefa buscaPorId(Long id) {
		return manager.find(Tarefa.class, id);
	}

	public List<Tarefa> lista() {
		return manager.createQuery("SELECT t FROM Tarefa t").getResultList();
	}

	public void adiciona(Tarefa t) {
		manager.persist(t);
		
	}

	public void altera(Tarefa t) {
		manager.merge(t);
		
	}

	public void remove(Tarefa t) {
		Tarefa tarefaARemover = buscaPorId(t.getId());
		manager.remove(tarefaARemover);
		
	}

	public void finaliza(Long id) {
		Tarefa tarefa = buscaPorId(id);
		tarefa.setFinalizado(true);
		tarefa.setDataFinalizacao(Calendar.getInstance());
		
	}

}
