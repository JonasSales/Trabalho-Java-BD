<%@page import="bancodedados.Funcionario"%>
<%@page import="dao.FuncionarioDAO"%>
<%@page import="dao.ProdutoDAO"%>
<%@page import="bancodedados.Produto"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atualizar estoque</title>
    <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
    <script type="module">
        import { mascaraDimensoes, redirecionar } from 'http://localhost:8080/utils.js';
        window.mascaraDimensoes = mascaraDimensoes;
        window.redirecionar = redirecionar;
    </script>
    <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
</head>
<body>
<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("vendedor") != null
            ? (Usuario) session.getAttribute("vendedor")
            : (Usuario) session.getAttribute("funcionario");
    Produto estoque = null;
    boolean verificadorUm = usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals("vendedor");
    boolean verificadorDois = usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals("funcionario");
    int idVendedor;
    if (verificadorUm) {
            idVendedor = usuarioLogado.getId();
        }else{
        Funcionario funcionario = FuncionarioDAO.buscarFuncionario(usuarioLogado.getEmail(), usuarioLogado.getId());
        idVendedor = funcionario.getIdPatrao();
    }
    
    if (verificadorUm || verificadorDois) {
%>
    <form method="GET" action="">
        <label for="id">Pesquisar estoque por ID:</label>
        <input type="number" id="id" name="id" required>
        <input type="submit" value="Pesquisar">
    </form>

<%
        String idEstoque = request.getParameter("id");
        if (idEstoque != null && !idEstoque.isEmpty()) {
            estoque = ProdutoDAO.BuscarProduto(Long.parseLong(idEstoque), idVendedor);
        }
    }

    if (estoque != null) {
%>
    <form action="http://localhost:8080/AtualizarEstoqueServlet" method="post">
        <h2>Atualizar</h2>
        <label>Nome:</label>
        <input type="text" id="nome" name="nome" required value="<%= estoque.getNome()%>">
        <label>Peso:</label>
        <input type="text" id="peso" name="peso" required value="<%= estoque.getPeso()%>">
        <label>Dimensões:</label>
        <input type="text" id="dimensoes" name="dimensoes" required value="<%= estoque.getDimensoes()%>" oninput="mascaraDimensoes(this)"
               maxlength="8" pattern=".{8,8}">
        <label>Preço:</label>
        <input type="text" id="preco" name="preco" required value="<%= estoque.getPreco() %>">
        <label>Quantidade:</label>
        <input type="number" id="quantidade" name="quantidade" required value="<%=estoque.getQuantidade()%>">
        <input type="hidden" name="id" value="<%= estoque.getId_produto()%>">
        <input type="hidden" name="idVendedor" value="<%= estoque.getId_vendedor()%>">
        <input type="submit" value="Atualizar">
    </form>
<%
    }
%>
</body>
</html>
