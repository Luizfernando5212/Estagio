package br.com.kiman.treinamento.jdbc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.kiman.treinamento.jdbc.ConnectionFactory;
import br.com.kiman.treinamento.jdbc.modelo.Funcionario;

public class FuncionarioDao {
private Connection connection;
	
	public FuncionarioDao() {
		this.connection = new ConnectionFactory().getConnection();
	}
	
	public void adiciona(Funcionario funcionario) {
		String sql = "INSERT INTO funcionarios " +
					 "(nome, usuario, senha)" +
					 "VALUES (?, ?, ?)";
		
		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			
			stmt.setString(1, funcionario.getNome());
			stmt.setString(2, funcionario.getUsuario());
			stmt.setString(3, funcionario.getSenha());
			
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			throw new DAOException("N�o foi poss�vel inserir os dados ", e);
		}
	}
	
	public List<Funcionario> getLista(){
		try {
			List<Funcionario> funcionarios = new ArrayList<Funcionario>();
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM funcionarios");
			
			ResultSet rs = stmt.executeQuery();
			
			while (rs.next()) {
				Funcionario funcionario = new Funcionario();
				funcionario.setId(rs.getLong("id"));
				funcionario.setNome(rs.getString("nome"));
				funcionario.setUsuario(rs.getString("usuario"));
				funcionario.setSenha(rs.getString("senha"));
				
				funcionarios.add(funcionario);
			}
			rs.close();
			stmt.close();
			return funcionarios;
		} catch (SQLException e) {
			throw new DAOException("N�o foi poss�vel realizar a consulta ", e);
		}
	}
	
	public Funcionario pesquisar(int i) {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM funcionarios WHERE id = ?");
			stmt.setLong(1, i);
			ResultSet rs = stmt.executeQuery();
			
			rs.next();
			Funcionario funcionario = new Funcionario();
			funcionario.setId(rs.getLong("id"));
			funcionario.setNome(rs.getString("nome"));
			funcionario.setUsuario(rs.getString("usuario"));
			funcionario.setSenha(rs.getString("senha"));
			
			rs.close();
			stmt.close();
			return funcionario;
		} catch (SQLException e) {
			throw new DAOException("N�o foi poss�vel realizar a consulta ", e);
		}
	}
	
	public void altera(Funcionario funcionario) {
		String sql = "UPDATE funcionarios " +
				     "SET nome = ?, usuario = ?, senha = ? " +
				     "WHERE id = ?";
		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, funcionario.getNome());
			stmt.setString(2, funcionario.getUsuario());
			stmt.setString(3, funcionario.getSenha());
			stmt.setLong(4, funcionario.getId());
			
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			throw new RuntimeException("N�o foi poss�vel alterar o contato ", e);
		}
	}
	
	public void remove(Funcionario funcionario) {
		String sql = "DELETE FROM funcionarios WHERE id = ?";
		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setLong(1, funcionario.getId());
			
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			throw new DAOException("N�o foi poss�vel deletar contato ", e);
		}
	}

}
