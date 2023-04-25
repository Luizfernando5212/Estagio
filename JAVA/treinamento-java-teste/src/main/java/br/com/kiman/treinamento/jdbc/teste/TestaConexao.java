package br.com.kiman.treinamento.jdbc.teste;

import java.sql.Connection;
import java.sql.SQLException;

import br.com.kiman.treinamento.jdbc.ConnectionFactory;

public class TestaConexao {

	public static void main(String[] args) throws SQLException {
		Connection conexao = new ConnectionFactory().getConnection();
		System.out.println("Conex�o aberta!");
		conexao.close();
	}
}
