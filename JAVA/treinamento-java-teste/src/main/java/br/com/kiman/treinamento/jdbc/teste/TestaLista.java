package br.com.kiman.treinamento.jdbc.teste;

import java.text.SimpleDateFormat;
import java.util.List;

import br.com.kiman.treinamento.jdbc.dao.ContatoDao;
import br.com.kiman.treinamento.jdbc.modelo.Contato;

public class TestaLista {

	public static void main(String[] args) {
//		Teste recuperando dados da tabela Contatos
		ContatoDao dao = new ContatoDao();
		List<Contato> contatos = dao.getLista();
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
		
		for (Contato contato : contatos) {
			System.out.println("Nome: " + contato.getNome());
			System.out.println("Email: " + contato.getEmail());
			System.out.println("Endereço: " + contato.getEndereco());
			System.out.println("Data de ascimento: " + formato.format(contato.getDataNascimento().getTime()) + "\n");
		}
		
		System.out.println("#############################\n");
		
////		Teste recuperando dados da tabela Funcionarios
//		FuncionarioDao newDao = new FuncionarioDao();
//		List<Funcionario> funcionarios = newDao.getLista();
//		
//		for (Funcionario func : funcionarios) {
//			System.out.println("Nome: " + func.getNome());
//			System.out.println("Usuário: " + func.getUsuario());
//			System.out.println("Senha: " + func.getSenha() + "\n");
//		}
		
		System.out.println("Lista completa");
	}

}
