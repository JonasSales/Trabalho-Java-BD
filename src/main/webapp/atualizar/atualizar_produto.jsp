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
    
    Produto produto = null;
    int idVendedor;
    boolean verificadorUm = usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals("vendedor");
    boolean verificadorDois = usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals("funcionario");
    if (verificadorUm) {
            idVendedor = usuarioLogado.getId();
        }else{
        Funcionario funcionario = FuncionarioDAO.buscarFuncionario(usuarioLogado.getEmail(), usuarioLogado.getId());
        idVendedor = funcionario.getIdPatrao();
    }
    if (verificadorUm || verificadorDois) {
%>
    <form method="GET" action="">
        <label for="id">Pesquisar produto por ID:</label>
        <input type="number" id="id" name="id" required>
        <input type="submit" value="Pesquisar">
    </form>
<%
        String idProduto = request.getParameter("id");
        if (idProduto != null && !idProduto.isEmpty()) {
            produto = ProdutoDAO.BuscarProduto(Integer.parseInt(idProduto), idVendedor);
        }
    }
    if (produto != null) {
%>
    <form action="http://localhost:8080/AtualizarProdutoServlet" method="post">
        <h2>Atualizar</h2>
        <label>Nome:</label>
        <input type="text" id="nome" name="nome" required value="<%= produto.getNome() %>">
        <label>Categoria:</label>
        <input type="text" id="categoria" name="categoria" required value="<%= produto.getCategoria() %>">
        <label>Marca:</label>
        <input type="text" id="marca" name="marca" required value="<%= produto.getMarca() %>">
        <label>Publico:
                <select  id="publico" name="publico">
                    <option value="Adulto">Adulto</option>
                    <option value="Infantil">Infantil</option>
                    <option value="Masculino">Masculino</option>
                    <option value="Feminino">Feminino</option>
                    <option value ="Unissex">Unissex</option>
                  </select>  
              </label>
        <input type="hidden" name="id" value="<%= produto.getId_produto()%>">
        <input type="hidden" name="idVendedor" value="<%=idVendedor%>">
        <input type="submit" value="Atualizar">
    </form>
<%
    }
%>
</body>
</html>
