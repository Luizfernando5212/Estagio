package br.com.kiman.treinamento.mvc.logica;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PrimeiraLogica implements Logica {

	public String executa(HttpServletRequest req, HttpServletResponse res) throws Exception {
		System.out.println("Executando a logica ...");
		
		System.out.println("Retornando o nome da página JSP ...");
		return "WEB-INF/jsp/primeira-logica.jsp";
	}

}
