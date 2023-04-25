package br.com.kiman.treinamento.jpa.teste;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import br.com.kiman.treinamento.jpa.modelo.Livro;


public class LivroTest {

	public static void main(String[] args) {

		EntityManagerFactory factory = Persistence.createEntityManagerFactory("tutorial-jpa");
		EntityManager em = factory.createEntityManager();

		Livro livro = new Livro();
		livro.setTitulo("Meu Livro");
		livro.setPaginas(100);		
		
		try {
			em.getTransaction().begin();

			em.persist(livro);
			em.flush();
	
			livro.setTitulo("Testando o Pre-update");
			em.merge(livro);
			em.flush();
			
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		} finally {
			em.close();
		}
	}

}
