<%@page import="bancodedados.Usuario"%>
<%@page import="bancodedados.Funcionario"%>
<%@ page import="dao.ProdutoDAO" %>
<%@ page import="dao.FuncionarioDAO" %>
<%@ page import="bancodedados.Produto" %>
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
            
            int idVendedor = 0;
            boolean verificadorUm = usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals("vendedor");
            boolean verificadorDois = usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals("funcionario");
            if (verificadorUm) {
                idVendedor = usuarioLogado.getId();
            } else if (verificadorDois) {
                Funcionario funcionario = FuncionarioDAO.buscarFuncionario(usuarioLogado.getEmail(), usuarioLogado.getId());
                idVendedor = funcionario.getIdPatrao();
            }
            if (verificadorUm || verificadorDois) {
        %>
        <h1>Estoque</h1>
        <table>
            <tr><th>ID</th><th>Nome</th><th>Quantidade</th><th>Peso</th><th>Dimensoes</th><th>Preço</th></tr>
            <%ArrayList<Produto> estoque = ProdutoDAO.BuscarProdutos("", idVendedor);
                        for (Produto u : estoque) {
                            out.println("<tr>");
                            out.println("<td>" + u.getId_produto() + "</td>");
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
