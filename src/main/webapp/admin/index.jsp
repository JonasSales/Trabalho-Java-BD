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

        // Verifica se o usuário está logado e se é admin
        String tipoUsuario = "admin";
        if (usuarioLogado == null || !usuarioLogado.getTipodeUsuario().equals(tipoUsuario)) {
    %>
            <div>
                Você não tem permissão para acessar esta página. Por favor, entre como administrador.
            </div>
            <script>
                setTimeout(function() {
                    window.location.href = 'http://localhost:8080/home.jsp'; // Redireciona após 5 segundos
                }, 5000);
            </script>
    <%
        } else {
    %>
            <header>
                <h1>Menu Admin</h1>
            </header>

            <nav>
                <a href="http://localhost:8080/admin/acessar/adicionar.jsp">Adicionar</a>
                <a href="http://localhost:8080/admin/acessar/atualizar.jsp">Atualizar</a>
                <a href="http://localhost:8080/admin/acessar/listar.jsp">Listar</a>
                <a href="http://localhost:8080/clientes/acessar/deletar_cliente.jsp" target="centro">Deletar</a>
                <a href="http://localhost:8080/">Voltar para a página principal</a>
            </nav>

            <main>
                <iframe src="http://localhost:8080/apresentacao.html" name="centro"></iframe>
            </main>

            <footer>
                <p>Alunos: Jocineudo Oliveira, Jonas Sales, Thais Ribeiro © 2024</p>
            </footer>
    <%
        }
    %>
</body>
</html>
