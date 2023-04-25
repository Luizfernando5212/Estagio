package br.com.kiman.curso.spring.rest.config;

import java.util.Set;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

@ApplicationPath("api")
public class Config extends Application{
	
	@Override
	public Set<Class<?>> getClasses() {
	Set<Class<?>> resources = new java.util.HashSet<>();
	resources.add(br.com.kiman.curso.spring.rest.resource.ClienteController.class);
	resources.add(br.com.kiman.curso.spring.rest.resource.ProdutoController.class);
	resources.add(br.com.kiman.curso.spring.rest.resource.PedidoController.class);
	resources.add(br.com.kiman.curso.spring.rest.config.JBossJacksonConfigurator.class);
	return resources;
	}
}