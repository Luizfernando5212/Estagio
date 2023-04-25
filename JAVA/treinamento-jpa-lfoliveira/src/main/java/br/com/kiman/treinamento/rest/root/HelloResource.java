package br.com.kiman.treinamento.rest.root;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("sayhello")
public class HelloResource {
	
	@GET
	public String getResposta() {
		return "Hello ,world!";
	}
}
