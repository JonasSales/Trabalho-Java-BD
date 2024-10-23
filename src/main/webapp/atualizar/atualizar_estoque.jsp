<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Formulário de Atualização</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraDimensoes , redirecionar} from 'http://localhost:8080/utils.js';
            window.mascaraDimensoes = mascaraDimensoes;
            window.redirecionar= redirecionar;
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
            if (verificadorUm || verificadorDois || verificadorTres) {%>
        <form action="http://localhost:8080/AtualizarEstoqueServlet" method="post">
            <h2>Atualizar</h2>
            
            <label>ID:</label>
            <input type="number" id="id" name="id" required>
            <label>Quantidade:</label>
            <input type="number" id="quantidade" name="quantidade" required>
            <label>Peso:</label>
            <input type="number" step="any" id="peso"  name="peso"
                   required>
            <label>Dimensoes:</label>
            <input type="text" id="dimensoes" name="dimensoes" maxlength="8"
                   oninput="mascaraDimensoes(this)" required>
            <label>Preco:</label>
            <input type="number" id="preco" step="any" name="preco"  required>
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
