<html>
	<body>
		<%-- coment�rio em JSP aqui: nossa primeira p�gina JSP --%>
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