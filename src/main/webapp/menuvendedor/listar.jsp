<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>P�gina Principal</title>
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
            <h1>Listar</h1>
        </header>
        <nav>
            <a href="http://localhost:8080/listar/listar_funcionarios.jsp" target="centro">Listar Funcionarios</a>
            <a href="http://localhost:8080/listar/listar_estoque.jsp"  target="centro">Listar Estoque</a>
            <a href="http://localhost:8080/listar/listar_produtos.jsp" target="centro">Listar Produtos</a>
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
            }, 5000);
        </script>
        <%
            }
        %>
    </body>
</html>
