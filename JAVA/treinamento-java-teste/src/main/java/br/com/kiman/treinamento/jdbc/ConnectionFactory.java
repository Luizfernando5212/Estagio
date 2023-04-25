package br.com.kiman.treinamento.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
	public Connection getConnection() {
		try {
			return DriverManager.getConnection("DB connection", 
					"User",  "Password");
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
