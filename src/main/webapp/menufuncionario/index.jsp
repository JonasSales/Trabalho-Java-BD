<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Página Principal</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
    </head>
    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
            boolean verificador = usuarioLogado.getTipodeUsuario().equals("funcionario");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            if (verificador || verificadorDois) {
        %>
        <header>
            <h1>Menu Funcionario</h1>
        </header>
        <nav>
            <a href="http://localhost:8080/atualizar/atualizar_funcionario.jsp" target="centro">Atualizar dados</a>
            <a href="http://localhost:8080/atualizar/atualizar_produto.jsp" target="centro">Atualizar produto</a>
            <a href="http://localhost:8080/atualizar/atualizar_estoque.jsp" target="centro">Atualizar estoque</a>
            <a href="http://localhost:8080/LogoutServlet">Sair</a>
        </nav>
        <main>
            <iframe src="http://localhost:8080/apresentacao.html" name="centro"></iframe>
        </main>
        <footer>
            <p>Alunos: Jocineudo Oliveira, Jonas Sales, Thais Ribeiro © 2024</p>
        </footer>
        <%
        } else {
        %>
        <div>
            Você não tem permissão para acessar esta página. Por favor, entre como cliente.
        </div>
        <script>
            setTimeout(function () {
                window.location.href = 'http://localhost:8080/home.jsp'; // Redireciona após 5 segundos
            }, 5000);
        </script>
        <%
            }
        %>
    </body>
</html>
