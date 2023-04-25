package br.com.kiman.treinamento.ejb.servlet;

import java.io.IOException;
import java.io.Writer;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.kiman.treinamento.ejb.modelo.CarrinhoDeCompras;
import br.com.kiman.treinamento.ejb.modelo.ItemPedido;

@WebServlet("/EjbServlet")
public class EjbServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
//	@Inject
//	CarrinhoDeComprasR carrinho;
	@Inject
	CarrinhoDeCompras carrinho;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Writer out = response.getWriter();

//		List<ItemPedido> itens = carrinho.findAll();
//		
//		for(ItemPedido item : itens) {
//			
//			out.write("<p>" + "IdPedido: " + item.getPedido().getIdPedido() + "</p>");
//			out.write("<p>" + "IdPedido: " + item.getPedido().getIdPedido() + " IdProduto: " 
//					+ item.getIdProduto() + " quantidade: " + item.getQuantidade() + "</p>");
//		}
		
		int cont = 0;
		String f = "__________";
		
		List<ItemPedido> itens = (List<ItemPedido>) carrinho.findById(1l);
		for(ItemPedido item : itens) {
			if (cont == 0)
				out.write("<p>" + f + f + f  + "IdPedido: " + item.getPedido().getIdPedido() 
						+ f + f + f + "</p>");
			out.write("<p>" + "IdProduto: " + item.getIdProduto() 
			+ f + " Quantidade: " + item.getQuantidade() 
			+ f + " Preço unitário: " + item.getPrecoUnitario() +  "</p>");
			cont+=1;
		}
		out.write("<p>" + "Valor total da compra: " + carrinho.getValorCompra() + "</p>");
		
//			List<Pedido> pedidos = (List<Pedido>) dao.findAll(new Pedido());
			
			
//			for (Pedido pedido : pedidos) {
//				out.write("<p>" + " O pedido " + pedido.getIdPedido() + "</p>");
//		}
		
	
	}
}
