<%@page import="bancodedados.Vendedor"%>
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
            Vendedor usuarioLogado = (Vendedor) session.getAttribute("vendedor");
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("vendedor");
            if (verificadorUm) {
        %>
        <header>
            <h1>Menu Vendedor</h1>
        </header>
        <nav>
            <a href="http://localhost:8080/menuvendedor/adicionar.jsp">Menu adicionar</a>
            <a href="http://localhost:8080/menuvendedor/atualizar.jsp">Menu atualizar</a>
            <a href="http://localhost:8080/menuvendedor/listar.jsp">Menu listar</a>
            <a href="http://localhost:8080/vendas/registrarvendas.jsp">Registrar vendas</a>
            <a href="http://localhost:8080/menuvendedor/deletar.jsp">Menu Deletar</a>
            
           
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
                window.location.href = 'http://localhost:8080/redirecionarMenu.jsp'; // Redireciona após 5 segundos
            }, 5000);
        </script>
        <%
            }
        %>
    </body>
</html>
