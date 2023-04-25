package br.com.kiman.treinamento.rest.root;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import br.com.kiman.treinamento.ejb.modelo.FilmeDto;
import br.com.kiman.treinamento.jpa.modelo.Filme;

public class Conversor {
	public static FilmeDto converteFilme (Filme filme) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		FilmeDto filmeDto = new FilmeDto(filme.getIdFilme(),
				filme.getTitulo(),
				filme.getImdbCode());
		
		try {
			filmeDto.setAnoLancamento(df.format(filme.getAnoLancamento()));
		} catch(Exception e) {}
		return filmeDto;
	}
}
