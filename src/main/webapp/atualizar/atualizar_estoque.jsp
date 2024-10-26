<%@page import="bancodedados.Funcionario"%>
<%@page import="dao.FuncionarioDAO"%>
<%@page import="dao.EstoqueDAO"%>
<%@page import="bancodedados.Estoque"%>
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
    
    Estoque estoque = null;
    boolean verificadorUm = usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals("vendedor");
    boolean verificadorDois = usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals("funcionario");
    
    if (verificadorUm || verificadorDois) {
%>
    <form method="GET" action="">
        <label for="id">Pesquisar por ID:</label>
        <input type="number" id="id" name="id" required>
        <input type="submit" value="Pesquisar">
    </form>

<%
        String idEstoque = request.getParameter("id");
        if (idEstoque != null && !idEstoque.isEmpty()) {
            estoque = EstoqueDAO.BuscarEstoquePorId(Integer.parseInt(idEstoque));
        }
    }

    if (estoque != null) {
%>
    <form action="http://localhost:8080/AtualizarEstoqueServlet" method="post">
        <h2>Atualizar</h2>
        
        <label>Peso:</label>
        <input type="text" id="peso" name="peso" required value="<%= estoque.getPeso() %>">
        
        <label>Dimensões:</label>
        <input type="text" id="dimensoes" name="dimensoes" required value="<%= estoque.getDimensoes() %>">
        
        <label>Preço:</label>
        <input type="text" id="preco" name="preco" required value="<%= estoque.getPreco() %>">
        
        <label>Quantidade:</label>
        <input type="text" id="quantidade" name="quantidade" required value="<%= estoque.getQuantidade() %>">
        
        <input type="hidden" name="id" value="<%= estoque.getId() %>">
        <input type="submit" value="Atualizar">
    </form>
<%
    }
%>
</body>
</html>
