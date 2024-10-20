<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página Principal</title>
    <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
    <script type="module">
        import { redirecionar } from 'http://localhost:8080/utils.js';
        window.redirecionar = redirecionar;
    </script>
</head>
<body>
    <%
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
        String tipoUsuario = "admin";
        
        if (usuarioLogado == null || !usuarioLogado.getTipodeUsuario().equals(tipoUsuario)) {
            out.println("<script>");
            out.println("redirecionar('http://localhost:8080');");
            out.println("</script>");
        } else {
    %>
            <header>
                <h1>Clientes</h1>
                <nav>
                    <a>Seja bem-vindo, <strong><%= usuarioLogado.getNome() %></strong></a>
                    <br><br>
                    <a href="acessar/atualizar_cliente.jsp" target="centro">Adicionar Cliente</a>
                    <a href="acessar/deletar_cliente.jsp" target="centro">Adicionar Vendedor</a>
                    <a href="acessar/listar_cliente.jsp" target="centro">Adicionar Produto</a>
                    <a href="http://localhost:8080/admin/index.jsp">Voltar para a Página Principal</a>
                </nav>
            </header>
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
