package br.com.kiman.treinamento.soap;

import javax.xml.ws.Endpoint;

public class Publisher {

	public static void main(String[] args) {
		
		Endpoint.publish("http://127.0.0.1:9990/treinamento-jpa-lfoliveira", new FilmeFacade());
	}

}
