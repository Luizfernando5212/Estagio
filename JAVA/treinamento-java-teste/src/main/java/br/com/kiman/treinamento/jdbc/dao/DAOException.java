package br.com.kiman.treinamento.jdbc.dao;

public class DAOException extends RuntimeException{
	private static final long serialVersionUID = 1L;

	public DAOException(String errorMessage, Throwable err) {
		super(errorMessage, err);
	}

}
