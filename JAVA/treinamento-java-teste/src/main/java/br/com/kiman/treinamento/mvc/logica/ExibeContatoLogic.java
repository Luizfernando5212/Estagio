package br.com.kiman.treinamento.mvc.logica;

//import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import br.com.kiman.treinamento.jdbc.dao.ContatoDao;
//import br.com.kiman.treinamento.jdbc.modelo.Contato;

public class ExibeContatoLogic implements Logica {

	@Override
	public String executa(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		return "WEB-INF/jsp/altera-contato.jsp";	
	}

}
