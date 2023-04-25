package br.com.kiman.treinamento.rest.root;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;

@Path("sala")
public class SalaResource {
	
//	@POST
//	public void create(int id, String nome, boolean ocupada) {
//		
//	}
	
	@PUT
	public void ocuparProximaSala() {
		
	}
	
	@GET
	public int[] getSalas() {
		return null;
		
	}
	
//	@GET @Path("livre")
//	public id getProximaSalaLivre() {
//		
//	}
}
