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
        // Verificar se a sessão é nula ou não contém o usuário logado
        if (session.getAttribute("vendedor") == null && session.getAttribute("funcionario") == null) {
            response.sendRedirect("login.jsp"); // Redirecionar para a página de login
            return;
        }

        Usuario usuarioLogado = (Usuario) session.getAttribute("vendedor") != null
                ? (Vendedor) session.getAttribute("vendedor")
                : (Funcionario) session.getAttribute("funcionario");

        boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("vendedor");
        boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("funcionario");
        int idVendedor = 0;

        if (verificadorUm) {
            Vendedor vendedor = (Vendedor) session.getAttribute("vendedor");
            idVendedor = vendedor.getId();
        } else if (verificadorDois) {
            Funcionario funcionario = (Funcionario) session.getAttribute("funcionario");
            idVendedor = funcionario.getIdPatrao();
        }

        if (verificadorUm || verificadorDois) {
    %>
    <form method="GET" action="">
        <label for="idProduto">Pesquisar por ID ou nome:</label>
        <input type="text" id="idProduto" name="idProduto" >
        <input type="submit" value="Pesquisar">
    </form>
    <table>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Categoria</th>
            <th>Marca</th>
            <th>Público</th>
        </tr>
        <%
            String idProduto = request.getParameter("idProduto");
            ArrayList<Produto> produtos;
            
            boolean verificadorTres = (idProduto != null) && (!idProduto.isEmpty());
            if (verificadorTres) {
                produtos = ProdutoDAO.BuscarProdutos(idProduto, idVendedor);
            } else {
                produtos = ProdutoDAO.BuscarProdutos("", idVendedor);
            }
            for (Produto u : produtos) {
                    out.println("<tr>");
                    out.println("<td>" + u.getId_produto() + "</td>");
                    out.println("<td>" + u.getNome() + "</td>");
                    out.println("<td>" + u.getCategoria() + "</td>");
                    out.println("<td>" + u.getMarca() + "</td>");
                    out.println("<td>" + u.getPublico() + "</td>");
                    out.println("</tr>");
                }
        %>
    </table>
    <% } else { %>
        <p>Usuário não está logado.</p>
    <% } %>
</body>
</html>
