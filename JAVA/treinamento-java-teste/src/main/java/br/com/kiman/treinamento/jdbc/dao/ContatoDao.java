package br.com.kiman.treinamento.jdbc.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import br.com.kiman.treinamento.jdbc.ConnectionFactory;
import br.com.kiman.treinamento.jdbc.modelo.Contato;

public class ContatoDao {
	private Connection connection;
	
	public ContatoDao() {
		this.connection = new ConnectionFactory().getConnection();
	}
	
	public ContatoDao(Connection connection) {
		this.connection = connection;
	}
	
	public void adiciona(Contato contato) {
		String sql = "INSERT INTO contatos " +
					 "(nome, email, endereco, dataNascimento)" +
					 "VALUES (?, ?, ?, ?)";
		
		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			
			stmt.setString(1, contato.getNome());
			stmt.setString(2, contato.getEmail());
			stmt.setString(3, contato.getEndereco());
			stmt.setDate(4, new Date(contato.getDataNascimento().getTimeInMillis()));
			
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			throw new DAOException("Não foi possível inserir os dados ", e);
		}
	}
	
	public List<Contato> getLista(){
		try {
			List<Contato> contatos = new ArrayList<Contato>();
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM contatos");
			
			ResultSet rs = stmt.executeQuery();
			
			while (rs.next()) {
				Contato contato = new Contato();
				contato.setId(rs.getLong("id"));
				contato.setNome(rs.getString("nome"));
				contato.setEmail(rs.getString("email"));
				contato.setEndereco(rs.getString("endereco"));
				
				Calendar data = Calendar.getInstance();
				data.setTime(rs.getDate("dataNascimento"));
				contato.setDataNascimento(data);
				
				contatos.add(contato);
			}
			rs.close();
			stmt.close();
			return contatos;
		} catch (SQLException e) {
			throw new DAOException("Não foi possível realizar a consulta ", e);
		}
	}
	
	public Contato pesquisar(int i) {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM contatos WHERE id = ?");
			stmt.setLong(1, i);
			ResultSet rs = stmt.executeQuery();
			
			rs.next();
			Contato contato = new Contato();
			contato.setId(rs.getLong("id"));
			contato.setNome(rs.getString("nome"));
			contato.setEmail(rs.getString("email"));
			contato.setEndereco(rs.getString("endereco"));
			
			Calendar data = Calendar.getInstance();
			data.setTime(rs.getDate("dataNascimento"));
			contato.setDataNascimento(data);
			
			rs.close();
			stmt.close();
			return contato;
		} catch (SQLException e) {
			throw new DAOException("Não foi possível realizar a consulta ", e);
		}
	}
	
	public void altera(Contato contato) {
		String sql = "UPDATE contatos " +
				     "SET nome = ?, email = ?, endereco = ?, dataNascimento = ? " +
				     "WHERE id = ?";
		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, contato.getNome());
			stmt.setString(2, contato.getEmail());
			stmt.setString(3, contato.getEndereco());
			stmt.setDate(4, new Date(contato.getDataNascimento().getTimeInMillis()));
			stmt.setLong(5, contato.getId());
			
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			throw new RuntimeException("N�o foi poss�vel alterar o contato ", e);
		}
	}
	
	public void remove(Contato contato) {
		String sql = "DELETE FROM contatos WHERE id = ?";
		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setLong(1, contato.getId());
			
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			throw new DAOException("Não foi possível deletar contato ", e);
		}
	}
}
