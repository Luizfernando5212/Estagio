package br.com.kiman.treinamento.jpa.listener;

import javax.persistence.PostLoad;
import javax.persistence.PostPersist;
import javax.persistence.PostUpdate;
import javax.persistence.PrePersist;
import javax.persistence.PreRemove;
import javax.persistence.PreUpdate;

import br.com.kiman.treinamento.jpa.modelo.Livro;

//import org.apache.log4j.Logger;

//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;


/*Os métodos listeners são acionados assim que uma entidiade altera de estado, seja ela persistida, deletada, carregada. Conceituamente, são bem parecido com as triggers
 * 
 * Para os testes, os metódos estão sendo acionados pela classe LivroTest
 * 	
 * Um exemplo é: o usuário quer que toda vez que um livro com mais de 4000 páginas for incluído no banco dados, eu quero mostrar uma mensagem "Mais um livro raro incluído por sucesso"
 * 
 */
public class LivroListener {
	
//	private static Logger log = Logger.getLogger(LivroListener.class);
	
	@PrePersist
	public void prePostLivro(Livro livro)
	{
			System.out.println("\nPreparando para incluir o livro: " + livro.getTitulo());
	}
	
	@PostPersist	
	public void postLivro(Livro livro) {
		
		if(livro.getPaginas() > 40000) {
			System.out.println("\nMais um livro raro incluído com sucesso: "+livro.getTitulo());
		}
		else
		{
			System.out.println("\nMais um livro normal incluído com sucesso: " + livro.getTitulo());
		}
	}
	
	@PreRemove
	public void preRemove(Livro livro)
	{
		System.out.println("\nExcluindo o livro: " + livro.getTitulo());
	}
	
	@PreUpdate
	public void preUpdate(Livro livro)
	{
		System.out.println("\nPreparando para atualizar o livro! ");
	}
	
	@PostUpdate
	public void postUpdate(Livro livro)
	{
		System.out.println("\nLivro atualizado!! ");
	}
	
	@PostLoad
	public void postLoad(Livro livro) {
		System.out.println("\nLivro carregado!");
		System.out.println("ID: " + livro.getId());
		System.out.println("Título: " + livro.getTitulo());
	}

}
