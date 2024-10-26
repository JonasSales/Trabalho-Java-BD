<%@page import="bancodedados.Funcionario"%>
<%@page import="bancodedados.Usuario"%>
<%@page import="bancodedados.Vendedor"%>
<%@page import="java.sql.*" %>
<%@page import="dao.ProdutoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bancodedados.Produto"%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listar Produtos</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesTabelas.css"/>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <h1>Lista de Produtos</h1>

        <%  
            Usuario usuarioLogado = (Usuario) session.getAttribute("vendedor") != null
                    ? (Vendedor) session.getAttribute("vendedor")
                    : (Funcionario) session.getAttribute("funcionario");
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("vendedor");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("funcionario");
            int id = 0;
            if (verificadorUm) {
                    Vendedor vendedor = (Vendedor) session.getAttribute("vendedor");
                    id = vendedor.getId();
                } else if (verificadorDois) {
                        Funcionario funcionario = (Funcionario) session.getAttribute("funcionario");
                        id = funcionario.getIdPatrao();
                    }

            if (verificadorUm || verificadorDois) {%>
        <a href="http://localhost:8080/redirecionarMenu.jsp">Retornar para página principal</a>
        <form method="GET" action="">
            <label for="idProduto">Pesquisar por ID:</label>
            <input type="number" id="idProduto" name="idProduto">
            <input type="submit" value="Pesquisar">
        </form>
        <%
            String idProdutoStr = request.getParameter("idProduto");
            ArrayList<Produto> produtos;
            if (idProdutoStr != null && !idProdutoStr.isEmpty()) {
            produtos = ProdutoDAO.BuscarProdutoPorId(idProdutoStr, id);
            } else {
            produtos = ProdutoDAO.BuscarProdutos(id);
            }
        %>
        <table>
            <tr><th>ID</th><th>Nome</th><th>Categoria</th><th>Marca</th><th>Publico</th></tr>
                    <% for (Produto u : produtos) {
                            out.println("<tr>");
                            out.println("<td>" + u.getId_produto() + "</td>");
                            out.println("<td>" + u.getNome() + "</td>");
                            out.println("<td>" + u.getCategoria() + "</td>");
                            out.println("<td>" + u.getMarca() + "</td>");
                            out.println("<td>" + u.getPublico() + "</td>");
                            out.println("</tr>");
                        } %>
        </table>
        <%}%>
    </body>
</html>
