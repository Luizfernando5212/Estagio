package br.com.kiman.treinamento.mvc.logica;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.kiman.treinamento.jdbc.dao.ContatoDao;
import br.com.kiman.treinamento.jdbc.modelo.Contato;

public class AlteraContatoLogic implements Logica {

	@Override
	public String executa(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		Connection connection = (Connection) req.getAttribute("conexao");
		
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
		Calendar data = Calendar.getInstance();

		Contato contato = new Contato();		
		ContatoDao dao = new ContatoDao(connection);
		
		String nome = req.getParameter("nome");
		String email = req.getParameter("email");
		String endereco = req.getParameter("endereco");
		String date = req.getParameter("dataNascimento");
		
		data.setTime(formato.parse(date));	
		
		contato.setNome(nome);
		contato.setEmail(email);
		contato.setEndereco(endereco);
		contato.setDataNascimento(data);
		
		if ((req.getParameter("id") == null) || req.getParameter("id").isEmpty()) {
			dao.adiciona(contato);
			System.out.println("Contato adicionado!");
		} else {
			long id = Long.parseLong(req.getParameter("id"));
			contato.setId(id);
			dao.altera(contato);
			System.out.println("Contato alterado!");
		}	
		return "mvc?logica=ListaContatosLogic";
	}

}
