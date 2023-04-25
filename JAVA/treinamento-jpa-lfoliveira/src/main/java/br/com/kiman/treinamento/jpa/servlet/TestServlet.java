package br.com.kiman.treinamento.jpa.servlet;

import java.io.IOException;
import java.io.Writer;

import javax.inject.Inject;
import javax.inject.Named;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.kiman.treinamento.jpa.dao.LivroDAOManagedBean;
import br.com.kiman.treinamento.jpa.modelo.Filme;
import br.com.kiman.treinamento.jpa.modelo.Livro;
//import br.com.kiman.treinamento.jpa.modelo.Livro;



@WebServlet("/LivroTestServlet")
public class TestServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@PersistenceContext//(unitName = "tutorial-jpa")
	EntityManager em;
	
//	LivroDAOManagedBean dao = new LivroDAOManagedBean();
//	@Inject
//	LivroDAOSessionBean dao;
	
//	@Inject
//	CriteriaQueries query;

	@Inject
	@Named("livroManagedBean")
	LivroDAOManagedBean dao;
	
//	@Resource
//	private UserTransaction ut;

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Writer out = response.getWriter();
		
	// Teste para lista de itens	
	/*  List<Integer> lista = new ArrayList();
		
		lista.add(62);
		lista.add(63);
		lista.add(65);
		lista.add(85);
		lista.add(71);
		lista.add(74);
		
		List<Livro> livros = query.estaEntre(lista); */
		
//		List<Livro> livros = query.intervalo(0, 400);
		
//		List<Livro> livros = query.menorQue(500);
		
//		List<Employees> funcionarios = query.join();
//		
//		for (Employees funcionario : funcionarios) {
//			out.write("<p>" + funcionario.getFirstName() + "</p>");
//	}
		
	// Teste usando o GROUP BY ********
//		List<Object[]> livros = (List<Object[]>) query.agrupamento();
//		for (Object obj[] : livros) {
//			Integer paginas = (Integer) obj[0];
//			Long 	count = (Long)obj[1];
//			
//			out.write("<p>" + paginas + " " + count +  "</p>");
//		}
		//try {
			//ut.begin();
//		Livro l = new Livro();
//			List<Livro> livros = (List<Livro>) dao.findById(64l, l);
//		Pedido p = new Pedido();
//			List<Pedido> pedidos = (List<Pedido>) dao.findAll(new Pedido());
//			
//			
//			for (Pedido pedido : pedidos) {
//				out.write("<p>" + " O pedido " + pedido.getIdPedido() + "</p>");
//		}
		
//			List<ItemPedido> pedidos = (List<ItemPedido>) dao.findAll(new ItemPedido());
//			
//			
//			for (ItemPedido pedido : pedidos) {
//				out.write("<p>" + " O pedido " + pedido.getPedido().getIdPedido() + " possui os itens: " + pedido + "</p>");
//		}
		
//		Livro livro = new Livro();
//		
//		livro.setPaginas(50);
//		livro.setTitulo("nome");
		
		Filme filme = new Filme();
		filme.setImdbCode("abc123");
		filme.setTitulo("O dia depois de ontem");
		dao.insert(filme);
		out.write("<p>" + "Filme inserido" + "</p>");
	}
}
