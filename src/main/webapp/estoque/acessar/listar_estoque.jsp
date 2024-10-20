<%@ page import="dao.EstoqueDAO" %>
<%@ page import="bancodedados.Estoque" %>
<%@ page import="java.util.ArrayList"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Produtos</title>
<link rel="stylesheet" href="http://localhost:8080/style/configuracoesTabelas.css"/>
</head>
<body>
    <h1>Estoque</h1>
    <a href="http://localhost:8080/home.jsp">Retornar para página principal</a>
    <%
        ArrayList<Estoque> estoque = EstoqueDAO.BuscarEstoque();
        // Criar tabela para exibir os clientes
        out.println("<table>");
        out.println("<tr><th>ID</th><th>Nome</th><th>Quantidade</th><th>Peso</th><th>Dimensoes</th><th>Preço</th></tr>");
        for (Estoque u : estoque) {
            out.println("<tr>");
            out.println("<td>" + u.getId() + "</td>");
            out.println("<td>" + u.getNome() + "</td>");
            out.println("<td>" + u.getQuantidade() + "</td>");
            out.println("<td>" + u.getPeso() + "</td>");
            out.println("<td>" + u.getDimensoes() + "</td>");
            out.println("<td>" + u.getPreco() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    %>
</body>
</html>
