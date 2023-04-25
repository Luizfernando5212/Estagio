package br.com.kiman.treinamento.jdbc.teste;

import java.text.SimpleDateFormat;

import br.com.kiman.treinamento.jdbc.dao.ContatoDao;
import br.com.kiman.treinamento.jdbc.dao.FuncionarioDao;
import br.com.kiman.treinamento.jdbc.modelo.Contato;
import br.com.kiman.treinamento.jdbc.modelo.Funcionario;

public class TestaPesquisa {

	public static void main(String[] args) {
		
		
//		Teste pesquisando Contato
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
		ContatoDao dao = new ContatoDao();
		Contato contato = dao.pesquisar(2);
		
		System.out.println("Nome: " + contato.getNome());
		System.out.println("Email: " + contato.getEmail());
		System.out.println("Endere�o: " + contato.getEndereco());
		System.out.println("Data de ascimento: " + formato.format(contato.getDataNascimento().getTime()) + "\n");
		
		System.out.println("#########################\n");
		
//		Teste pesquisando Funcionario
		FuncionarioDao newDao = new FuncionarioDao();
		Funcionario funcionario = newDao.pesquisar(2);
		
		System.out.println("Nome: " + funcionario.getNome());
		System.out.println("Usu�rio: " + funcionario.getUsuario());
		System.out.println("Senha: " + funcionario.getSenha());
		
		System.out.println("Pesquisa Completa!");
	}

}
