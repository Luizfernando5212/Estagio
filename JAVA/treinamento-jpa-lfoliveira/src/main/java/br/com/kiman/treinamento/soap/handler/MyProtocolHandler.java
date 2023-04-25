package br.com.kiman.treinamento.soap.handler;

import java.util.Set;

import javax.xml.soap.SOAPMessage;
import javax.xml.ws.handler.MessageContext;
import javax.xml.ws.handler.soap.SOAPHandler;

public class MyProtocolHandler implements SOAPHandler{

	@Override
	public void close(MessageContext arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean handleFault(MessageContext ctx) {
		String operacao = (String) ctx.get(MessageContext.WSDL_OPERATION);
		// Logar nome da operaçãoq ue causou erro
		return true;
	}

	@Override
	public boolean handleMessage(MessageContext ctx) {
//		SOAPMessage message = ctx.get();
		return true;
	}

	@Override
	public Set getHeaders() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
