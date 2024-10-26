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
        <title>Adicionar produto</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraDimensoes, redirecionar} from 'http://localhost:8080/utils.js';
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
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("vendedor");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            boolean verificadorTres = usuarioLogado.getTipodeUsuario().equals("funcionario");
            Produto produto = new Produto();
            if (verificadorUm || verificadorDois || verificadorTres) {%>

        <form method="GET" action="">
            <label for="id">Pesquisar por ID:</label>
            <input type="number" id="id" name="id" required>
            <input type="submit" value="Pesquisar">
        </form>

        <%
            String idProduto = request.getParameter("id");
            if (idProduto != null && !idProduto.isEmpty()) {
                if (verificadorUm) {
                    produto = ProdutoDAO.BuscarProduto(Integer.parseInt(idProduto), usuarioLogado.getId());
                } else if (verificadorTres) {
                    Funcionario funcionario = FuncionarioDAO.buscarFuncionario(" ", usuarioLogado.getId());
                    produto = ProdutoDAO.BuscarProduto(Integer.parseInt(idProduto), funcionario.getIdPatrao());
                }
            }
        %>

        <form action="http://localhost:8080/AtualizarProdutoServlet" method="post">
            <h2>Atualizar</h2>
            <label>Nome do produto:</label>
            <input type="text" id="nome" name="nome" required value="<%= produto.getNome()%>">
            <label>Categoria:</label>
            <input type="text" id="categoria"  name="categoria" required value="<%= produto.getCategoria()%>">
            <label>Marca:</label>
            <input type="text" id="marca"  name="marca" required value="<%= produto.getMarca()%>">
            <label>Publico:
                <select  id="publico" name="publico">
                    <option value="Adulto">Adulto</option>
                    <option value="Infantil">Infantil</option>
                    <option value="Masculino">Masculino</option>
                    <option value="Feminino">Feminino</option>
                    <option value ="Unissex">Unissex</option>
                </select>
            </label>
            <input type="hidden" name="id_produto" value="<%= idProduto%>">
            <input type="submit" value="Atualizar">
        </form>
        <%} else {%>
        <div>
            Você não tem permissão para acessar esta página. Por favor, entre como cliente.
        </div>
        <script>
            setTimeout(function () {
                window.location.href = 'http://localhost:8080/redirecionarMenu.jsp'; // Redireciona após 5 segundos
            }, 5000);
        </script>
        <%}%>
    </body>
</html>
