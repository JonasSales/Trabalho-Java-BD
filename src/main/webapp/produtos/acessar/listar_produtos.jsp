<%@ page import="java.sql.*" %>
<%@ page import="dao.ProdutoDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="bancodedados.Produto"%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listar Produtos</title>
     <link rel="stylesheet" href="http://localhost:8080/style/configuracoesTabelas.css"/>
</head>
<body>
    <h1>Lista de Produtos</h1>
    <a href="http://localhost:8080/home.jsp">Retornar para página principal</a>
    <%
        // Configurações da conexão
        ArrayList<Produto> produtos = ProdutoDAO.BuscarProdutos();
       
        // Criar tabela para exibir os clientes
        out.println("<table>");
        out.println("<tr><th>ID</th><th>Nome</th><th>Categoria</th><th>Marca</th><th>Publico</th></tr>");
        
        for (Produto u : produtos) {
            out.println("<tr>");
            out.println("<td>" + u.getId_produto() + "</td>");
            out.println("<td>" + u.getNome() + "</td>");
            out.println("<td>" + u.getCategoria() + "</td>");
            out.println("<td>" + u.getMarca() + "</td>");
            out.println("<td>" + u.getPublico() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    %>
</body>
</html>
