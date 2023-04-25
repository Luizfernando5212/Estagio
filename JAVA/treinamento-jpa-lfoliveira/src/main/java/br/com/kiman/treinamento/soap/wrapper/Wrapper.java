package br.com.kiman.treinamento.soap.wrapper;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Wrapper {
	
	@XmlElement(name = "limitBottom", required = false, defaultValue = "1990")
	int limitBottom;
	
	@XmlElement(name = "limitTop", required = false, defaultValue = "2000")
	int limitTop;
}
