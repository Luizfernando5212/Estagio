package br.com.kiman.treinamento.rest.app;

import java.util.Set;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

@ApplicationPath("webapi")
public class HelloApplication extends Application {
	
	@Override
	public Set<Class<?>> getClasses() {
	Set<Class<?>> resources = new java.util.HashSet<>();
	resources.add(br.com.kiman.treinamento.rest.root.FilmesIMDBResource.class);
	resources.add(br.com.kiman.treinamento.rest.root.HelloResource.class);
	resources.add(br.com.kiman.treinamento.rest.cors.CorsFilter.class);
	return resources;
	}
}
