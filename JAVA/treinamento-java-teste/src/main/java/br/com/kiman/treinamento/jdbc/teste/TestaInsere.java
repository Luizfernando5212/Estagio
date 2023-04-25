package br.com.kiman.treinamento.jdbc.teste;

import java.util.Calendar;

import br.com.kiman.treinamento.jdbc.dao.ContatoDao;
//import br.com.kiman.treinamento.jdbc.dao.FuncionarioDao;
import br.com.kiman.treinamento.jdbc.modelo.Contato;
//import br.com.kiman.treinamento.jdbc.modelo.Funcionario;

public class TestaInsere {

	public static void main(String[] args) {
//		Teste adicionando Contato
		Contato contato = new Contato();
		contato.setNome("Baleum");
		contato.setEmail("contato@Baelum.com.br");
		contato.setEndereco("R. Vergueiro 3185 cj57");
		contato.setDataNascimento(Calendar.getInstance());
		
		
		ContatoDao dao = new ContatoDao();
		
		dao.adiciona(contato);
		
//		Teste adicionando Funcionario
//		Funcionario func = new Funcionario();
//		
//		func.setNome("Oliveira");
//		func.setSenha("olol123");
//		func.setUsuario("olol321");
//		
//		FuncionarioDao newDao = new FuncionarioDao();
//		newDao.adiciona(func);
//		
//		System.out.println("Gravado!");
	}

}
