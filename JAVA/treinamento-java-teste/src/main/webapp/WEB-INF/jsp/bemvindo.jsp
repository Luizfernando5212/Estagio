<html>
	<body>
		<%-- comentário em JSP aqui: nossa primeira página JSP --%>
		<%
			String mensagem = "Bem vindo ao sistema de treinamento!";
		%>
		<%
			out.println(mensagem);
		%>
		<br />
		<%
			String desenvolvido = "Desenvolvido por Igor";
		%>
		<%=desenvolvido%>
		<br />
		<%
			System.out.println("Tudo foi executado!");
		%>
	</body>
</html>