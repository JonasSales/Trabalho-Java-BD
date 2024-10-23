<%@page import="bancodedados.Usuario"%>
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
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>

        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("funcionario") != null
                    ? (Usuario) session.getAttribute("funcionario")
                    : (session.getAttribute("vendedor") != null
                    ? (Usuario) session.getAttribute("vendedor")
                    : (Usuario) session.getAttribute("cliente"));

            if (usuarioLogado != null) {
        %>
        <h1>Estoque</h1>
        <a href="http://localhost:8080/redirecionarMenu.jsp">Retornar para página principal</a>
        <table>
            <tr><th>ID</th><th>Nome</th><th>Quantidade</th><th>Peso</th><th>Dimensoes</th><th>Preço</th></tr>
                    <%ArrayList<Estoque> estoque = EstoqueDAO.BuscarEstoque();
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
                    } else {%>
            <div>
                Você não tem permissão para acessar esta página. Por favor, entre como vendedor ou funcionario.
            </div>
            <script>
                setTimeout(function () {
                    window.location.href = 'http://localhost:8080/redirecionarMenu.jsp'; // Redireciona após 5 segundos
                }, 5000);
            </script>
            <%}%>
        </table>
    </body>
</html>
