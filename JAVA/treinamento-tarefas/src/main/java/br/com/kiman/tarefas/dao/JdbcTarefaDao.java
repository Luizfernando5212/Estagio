package br.com.kiman.tarefas.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.com.kiman.tarefas.modelo.Tarefa;



@Repository
public class JdbcTarefaDao {
	private Connection connection;
	
	@Autowired
	public JdbcTarefaDao(DataSource dataSource) {
		try {
			this.connection = dataSource.getConnection();
		} catch(SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	public void adiciona(Tarefa tarefa) {
		String sql = "INSERT INTO tarefas " +
					 "(descricao, finalizado) " +
					 "VALUES (?, ?)";
		
		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			
			stmt.setString(1, tarefa.getDescricao());
			stmt.setBoolean(2, tarefa.isFinalizado());
			if(!(tarefa.getDataFinalizacao() == null)) {
				stmt.setDate(3, new Date(tarefa.getDataFinalizacao().getTimeInMillis()));
			}
			
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			throw new DAOException("Não foi possível inserir os dados ", e);
		}
	}
	
	public List<Tarefa> getLista(){
		try {
			List<Tarefa> tarefas = new ArrayList<Tarefa>();
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM tarefas");
			
			ResultSet rs = stmt.executeQuery();
			
			while (rs.next()) {
				Tarefa tarefa = new Tarefa();
				tarefa.setId(rs.getLong("id"));
				tarefa.setDescricao(rs.getString("descricao"));
				tarefa.setFinalizado(rs.getBoolean("finalizado"));
				
				Calendar data = Calendar.getInstance();
				if (!(rs.getDate("dataFinalizacao") == null)) {
					data.setTime(rs.getDate("dataFinalizacao"));
					tarefa.setDataFinalizacao(data);
				}
				
				tarefas.add(tarefa);
			}
			rs.close();
			stmt.close();
			return tarefas;
		} catch (SQLException e) {
			throw new DAOException("Não foi possível realizar a consulta ", e);
		}
	}
	
	public Tarefa pesquisar(Long i) {
		try {
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM tarefas WHERE id = ?");
			stmt.setLong(1, i);
			ResultSet rs = stmt.executeQuery();
			
			rs.next();
			Tarefa tarefa = new Tarefa();
			tarefa.setId(rs.getLong("id"));
			tarefa.setDescricao(rs.getString("descricao"));
			tarefa.setFinalizado(rs.getBoolean("finalizado"));
			
			Calendar data = Calendar.getInstance();
			if (!(rs.getDate("dataFinalizacao") == null)) {
				data.setTime(rs.getDate("dataFinalizacao"));
				tarefa.setDataFinalizacao(data);
			}
				
			rs.close();
			stmt.close();
			return tarefa;
		} catch (SQLException e) {
			throw new DAOException("Não foi possível realizar a consulta ", e);
		}
	}
	
	public void altera(Tarefa tarefa) {
		String sql = "UPDATE tarefas " +
				     "SET descricao = ?, finalizado = ?, dataFinalizacao = ? " +
				     "WHERE id = ?";
		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, tarefa.getDescricao());
			stmt.setBoolean(2, tarefa.isFinalizado());
			stmt.setDate(3, new Date(tarefa.getDataFinalizacao().getTimeInMillis()));
			stmt.setLong(4, tarefa.getId());
			
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			throw new RuntimeException("Não foi possível alterar tarefa ", e);
		}
	}
	
	public void remove(Tarefa tarefa) {
		String sql = "DELETE FROM tarefas WHERE id = ?";
		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setLong(1, tarefa.getId());
			
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			throw new DAOException("Não foi possível deletar tarefa ", e);
		}
	
	}
}
