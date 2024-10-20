<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atualização de Dados</title>
    <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
    <script type="module">
        import { redirecionar } from 'http://localhost:8080/utils.js';
        window.redirecionar = redirecionar;
    </script>
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
                    redirecionar('http://localhost:8080');
                }, 5000); // redireciona após 5 segundos
            </script>
    <%
        } else {
    %>
            <header>
                <h1>Atualizar</h1>
            </header>
            <nav>
                <a>Seja bem-vindo, <strong><%= usuarioLogado.getNome() %></strong></a>
                <br><br>
                <a href="http://localhost:8080/clientes/acessar/adicionar_cliente.jsp" target="centro">AdicionarCliente</a>
                <a href="http://localhost:8080/produtos/acessar/adicionar_produto.html" target="centro">Adicionar Produto</a>
                <a href="http://localhost:8080/vendedor/acessar/adicionar_vendedor.jsp" target="centro">Adicionar Vendedor</a>
                <a href="http://localhost:8080/admin/index.jsp">Voltar para a Página Principal</a>
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
