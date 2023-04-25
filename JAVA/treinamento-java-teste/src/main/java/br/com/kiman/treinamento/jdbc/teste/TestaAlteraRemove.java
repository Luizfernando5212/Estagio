package br.com.kiman.treinamento.jdbc.teste;

import java.util.Calendar;

import br.com.kiman.treinamento.jdbc.dao.ContatoDao;
import br.com.kiman.treinamento.jdbc.dao.FuncionarioDao;
import br.com.kiman.treinamento.jdbc.modelo.Contato;
import br.com.kiman.treinamento.jdbc.modelo.Funcionario;

public class TestaAlteraRemove {

	public static void main(String[] args) {
//		Teste alterando e removendo contato 
//		Connection conexao = new ConnectionFactory().getConnection();
		ContatoDao dao = new ContatoDao();
		Contato contato = new Contato();
		
		contato.setId(1L);
		contato.setNome("Daelum");
		contato.setEmail("contato@Daelum.com.br");
		contato.setEndereco("Av. Brasil 1234");
		contato.setDataNascimento(Calendar.getInstance());
		
//		dao.altera(contato);
		dao.remove(contato);;
//		System.out.println("Contato alterado!");
		System.out.println("Contato Removido!");
		
//		Teste alterando e removendo Funcion�rio
		FuncionarioDao newDao = new FuncionarioDao();
		Funcionario funcionario = new Funcionario();
		
		funcionario.setId(1L);
		funcionario.setNome("Jota");
		funcionario.setUsuario("Jotinha");
		funcionario.setSenha("Jotinha123");
//		newDao.altera(funcionario);
		newDao.remove(funcionario);
//		System.out.println("Contato alterado!");
		System.out.println("Contato removido!");
	}
}
