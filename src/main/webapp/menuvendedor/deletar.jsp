<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Página Principal</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("vendedor");
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("vendedor");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            if (verificadorUm || verificadorDois) {
        %>
        <header>
            <h1>Atualizar</h1>
        </header>
        <nav>
            <a href="http://localhost:8080/deletar/deletar_cliente.jsp" target="centro">Deletar Funcionario</a>
            <a href="http://localhost:8080/deletar/deletar_produto.jsp" target="centro">Deletar produto</a>
            <a href="http://localhost:8080/deletar/deletar_conta.jsp" target="centro">Deletar Conta</a>
            <a href="http://localhost:8080/redirecionarMenu.jsp">Retornar para página principal</a>
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
                window.location.href = 'http://localhost:8080/redirecionarMenu.jsp'; // Redireciona após 5 segundos
            }, 1000);
        </script>
        <%
            }
        %>
    </body>
</html>
