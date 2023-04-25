<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<body>
	<c:if test="${not empty param.id}">
		<c:set var="operacao" value="Alterar" />
	</c:if>
	<c:if test="${empty param.id}">
		<c:set var="operacao" value="Incluir" />
	</c:if>
	<h2>${operacao} contato</h2>
	<br />
	<c:if test="${not empty param.id}">
		<table>
			<tr>
				<th>ID</th>
				<th>Nome</th>
				<th>Email</th>
				<th>Endereço</th>
				<th>Data de Nascimento</th>
			</tr>
			<jsp:useBean id="dao"
				class="br.com.kiman.treinamento.jdbc.dao.ContatoDao" />
			<c:set var="contato" value="${dao.pesquisar(param.id)}" />
				<tr>
					<td>${contato.id}</td>
					<td>${contato.nome}</td>
					<td>${contato.email}</td>
					<td>${contato.endereco}</td>
					<td><fmt:formatDate value="${contato.dataNascimento.time}"
							pattern="dd/MM/yyyy" /></td>
				</tr>
		</table>
		<hr />
		<form action="mvc?logica=AlteraContatoLogic&id=${param.id}"
			method="POST">
			Nome: <input type="text" name="nome"> <br /> Email: <input
				type="text" name="email"> <br /> Endereço: <input
				type="text" name="endereco"> <br /> Data de Nascimento: <input
				type="text" name="dataNascimento"> <br /> <input
				type="submit" value="Alterar" />
		</form>
	</c:if>
	<c:if test="${empty param.id}">
		<form action="mvc?logica=AlteraContatoLogic"
			method="POST">
			Nome: <input type="text" name="nome"> <br /> 
			Email: <input type="text" name="email"> <br /> 
			Endereço: <input type="text" name="endereco"> <br /> 
			Data de Nascimento: <input type="text" name="dataNascimento"> <br /> 
			<input type="submit" value="Incluir" />
		</form>
	</c:if>
</body>
</html>