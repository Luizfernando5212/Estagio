package br.com.kiman.curso.spring.rest.config;

import javax.ws.rs.ext.Provider;

import org.jboss.resteasy.plugins.providers.jackson.ResteasyJackson2Provider;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.databind.ObjectMapper;

@Provider
public class JBossJacksonConfigurator extends ResteasyJackson2Provider {

	public JBossJacksonConfigurator() {
		ObjectMapper defaultMapper = super._mapperConfig.getDefaultMapper();
		defaultMapper.setSerializationInclusion(Include.NON_NULL);
	}
}