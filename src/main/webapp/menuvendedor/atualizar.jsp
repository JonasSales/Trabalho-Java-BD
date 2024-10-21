<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>P�gina Principal</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
    </head>
    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("vendedor");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            if (verificadorUm || verificadorDois) {
        %>
        <header>
            <h1>Atualizar</h1>
        </header>
        <nav>
            <a href="http://localhost:8080/atualizar/atualizar_funcionario.jsp" target="centro">Atualizar Funcionario</a>
            <a href="http://localhost:8080/atualizar/atualizar_produto.jsp" target="centro">Atualizar produto</a>
            <a href="http://localhost:8080/atualizar/atualizar_estoque.jsp" target="centro">Atualizar estoque</a>
            <a href="http://localhost:8080/atualizar/atualizar_vendedor.jsp" target="centro">Atualizar dados</a>
            <a href="http://localhost:8080/redirecionarMenu.jsp">Retornar para p�gina principal</a>
        </nav>
        <main>
            <iframe src="http://localhost:8080/apresentacao.html" name="centro"></iframe>
        </main>
        <footer>
            <p>Alunos: Jocineudo Oliveira, Jonas Sales, Thais Ribeiro � 2024</p>
        </footer>
        <%
        } else {
        %>
        <div>
            Voc� n�o tem permiss�o para acessar esta p�gina. Por favor, entre como cliente.
        </div>
        <script>
            setTimeout(function () {
                window.location.href = 'http://localhost:8080/redirecionarMenu.jsp'; // Redireciona ap�s 5 segundos
            }, 1000);
        </script>
        <%
            }
        %>
    </body>
</html>