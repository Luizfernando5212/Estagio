package br.com.kiman.tarefas.jpa;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import br.com.kiman.tarefas.modelo.Tarefa;

public class AlteraTarefa {

	public static void main(String[] args) {
		
		Tarefa tarefa = new Tarefa();
		tarefa.setId(1L);
		tarefa.setDescricao("Estudar JPA e Hibernate");
		tarefa.setFinalizado(false);
		tarefa.setDataFinalizacao(null);
		
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("tarefas");
		EntityManager manager = factory.createEntityManager();
		
		manager.getTransaction().begin();
		manager.merge(tarefa);
		manager.getTransaction().commit();
	}
}
