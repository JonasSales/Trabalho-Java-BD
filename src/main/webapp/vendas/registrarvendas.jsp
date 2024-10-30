<%@ page import="bancodedados.Funcionario" %>
<%@ page import="bancodedados.Usuario" %>
<%@ page import="bancodedados.Vendedor" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.ProdutoDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bancodedados.Produto" %>

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

        <a href="http://localhost:8080/redirecionarMenu.jsp">Voltar para a página principal</a>
        <%

            ArrayList<Produto> carrinho = (ArrayList<Produto>) session.getAttribute("carrinho");
            if (session.getAttribute("vendedor") == null && session.getAttribute("funcionario") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            Usuario usuarioLogado = (Usuario) session.getAttribute("vendedor") != null
                    ? (Vendedor) session.getAttribute("vendedor")
                    : (Funcionario) session.getAttribute("funcionario");

            int idVendedor = usuarioLogado instanceof Vendedor
                    ? ((Vendedor) usuarioLogado).getId()
                    : ((Funcionario) usuarioLogado).getIdPatrao();
            //Começo é ali em baixo na linha 105
        %>



        <h1>Saída de estoque</h1>
        <table>

            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Quantidade para saída</th>
                <th>Preço</th>
                <th>Ação</th>
            </tr>

            <%
                if (carrinho != null) {
                    for (Produto produto : carrinho) {
            %>
            <tr>
                <td><%= produto.getId_produto()%></td>
                <td><%= produto.getNome()%></td>
                <td><%= produto.getQuantidade()%></td>
                <td><%= produto.getPreco()%></td>
                <td>
                    <form method="post" action="http://localhost:8080/RemoverCarrinhoServlet">
                        <input type="hidden" name="idDoProduto" value="<%= produto.getId_produto()%>">
                        <input type="hidden" name="idDoVendedor" value="<%= idVendedor%>">
                        <input type="submit" value="Remover produto">
                    </form>
                </td>
            </tr>
            <%
                }
            } else {%>
            <h1>CHORA BOY</h1>
            <%}%>
        </table>
        
        <br><br>
        <form method="post" action="http://localhost:8080/RenovarEstoqueServlet">
            <input type="submit" value="Confirmar saída de estoque  " download>
        </form>
        <br><br>
        <form method="GET" action="">
            <label for="idProduto">Pesquisar por ID ou nome:</label>
            <input type="text" id="idProduto" name="idProduto">
            <input type="submit" value="Pesquisar">
        </form>
        <h1>Lista de Produtos</h1>
        <table>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Quantidade em estoque</th>
                <th>Preço</th>
                <th>Ação</th>
            </tr>
            <%
                String idProduto = request.getParameter("idProduto");
                ArrayList<Produto> produtos = (idProduto != null && !idProduto.isEmpty())
                        ? ProdutoDAO.BuscarProdutos(idProduto, idVendedor)
                        : ProdutoDAO.BuscarProdutos("", idVendedor);
                for (Produto produto : produtos) {
            %>
            <tr>
                <td><%= produto.getId_produto()%></td>
                <td><%= produto.getNome()%></td>
                <td><%= produto.getQuantidade()%></td>
                <td><%= produto.getPreco()%></td>
                <td>
                    <form method="post" action="http://localhost:8080/carrinhoServlet">
                        <input type="hidden" name="idDoProduto" value="<%= produto.getId_produto()%>">
                        <input type="hidden" name="idDoVendedor" value="<%= idVendedor%>">
                        <input type="number" name="quantidade" required min="1" pattern="^[0-9]+">
                        <input type="submit" value="Adicionar ao carrinho">
                    </form>
                </td>
            </tr>
            <%
                }
            %>   
        </table>
    </body>
</html>
