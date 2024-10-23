<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administração</title>
    <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
    <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
</head>
<body>
    <%
        Usuario usuarioLogado = null;
        try {
            usuarioLogado = (Usuario) session.getAttribute("admin");
        } catch (Exception e) {
            // Logar o erro se necessário
            out.println("Erro ao recuperar o usuário da sessão: " + e.getMessage());
        }

        String tipoUsuario = "admin";
        if (usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals(tipoUsuario)) {
    %>
    <header>
        <h1>Menu Admin</h1>
    </header>
    <nav>
        <a href="http://localhost:8080/menuadmin/adicionar.jsp">Adicionar</a>
        <a href="http://localhost:8080/menuadmin/atualizar.jsp">Atualizar</a>
        <a href="http://localhost:8080/menuadmin/listar.jsp">Listar</a>
        <a href="http://localhost:8080/menuadmin/log.jsp">Ver logs</a>
        <a href="http://localhost:8080/deletar/deletar_cliente.jsp" target="centro">Deletar</a>
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
        Você não tem permissão para acessar esta página. Por favor, entre como administrador.
    </div>
    <script>
        setTimeout(function() {
            window.location.href = 'http://localhost:8080/home.jsp'; // Redireciona após 5 segundos
        }, 5000);
    </script>
    <%
        }
    %>
</body>
</html>
