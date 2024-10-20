<%@page import="bancodedados.Usuario"%>
<%@page import="dao.UsuarioDAO"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Logs</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
        <script type="module">
            import {redirecionar } from 'http://localhost:8080/utils.js';
            window.redirecionar = redirecionar;
        </script>
    </head>
    <body>
        <header>
            <h1>Logs</h1>
        </header>

        <%
            Usuario a = (Usuario) session.getAttribute("usuario");
            if (a != null) {
                out.println("<nav>");
                out.println("<a>Seja bem vindo " + a.getNome() + "</a>");
                out.println("<br><br/>");
                out.println("<a href=\"acessar/listar_log.jsp\">Ver logs</a>");
                out.println("<a href=\"http://localhost:8080/home.jsp\">Voltar para a Página Principal</a>");
                out.println("</nav>");
            } else {
                out.println("<script>");
                out.println("redirecionar('http://localhost:8080/apresentacao.html');");
                out.println("</script>");
            }
        %>
        <footer>
            <p>Alunos: Jocineudo Oliveira Jonas Sales Thais Ribeiro © 2024</p>
        </footer>
    </body>
</html>