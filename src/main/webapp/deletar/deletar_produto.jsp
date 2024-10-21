<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Adicionar produto</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraDimensoes , redirecionar} from 'http://localhost:8080/utils.js';
            window.mascaraDimensoes = mascaraDimensoes;
            window.redirecionar= redirecionar;
        </script>
    </head>
    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("vendedor");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            boolean verificadorTres = usuarioLogado.getTipodeUsuario().equals("funcionario");
            if (verificadorUm || verificadorDois || verificadorTres) {%>
        <form action="http://localhost:8080/DeletarProdutoServlet" method="post">
            <h2>Deletar</h2>
            <label>ID:</label>
            <input type="number" id="id_produto" name="id_produto" required>
            <input type="submit" value="Atualizar">
        </form>
        <%}else {%>
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
