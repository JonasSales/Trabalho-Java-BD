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
            import {redirecionar } from 'http://localhost:8080/utils.js';
            window.redirecionar = redirecionar;
        </script>
    </head>
    <body>
        <%
            Usuario a = (Usuario) session.getAttribute("usuario");
            if (a == null) {
                out.println("<script>");
                out.println("redirecionar('http://localhost:8080/apresentacao.html');");
                out.println("</script>");
            } else {
                out.println("<header>");
                out.println("<h1>Menu vendedor</h1>");
                out.println(" </header>");

                out.println("<nav>");
                out.println("<a>Seja bem vindo " + a.getNome() + "</a>");
                out.println("<br><br/>");

                out.println("<a href=\"http://localhost:8080/funcionarios/acessar/adicionar_funcionario.jsp\" target=\"centro\">Adicionar Funcionario</a>");
                out.println("<a href=\"acessar/atualizar_vendedor.jsp\" target=\"centro\">Atualizar Vendedor</a>");
                out.println(" <a href=\"acessar/deletar_vendedor.jsp\" target=\"centro\">Deletar vendedor</a>");
                out.println(" <a href=\"acessar/listar_vendedores.jsp\">Listar vendedores</a>");
                out.println("<a href=\"http://localhost:8080/home.jsp\">Voltar para a Página Principal</a>");

                out.println("</nav>");

                out.println("<main>");
                out.println("<iframe src=\"http://localhost:8080/apresentacao.html\" name =\"centro\"></iframe>");
                out.println("</main>");

                out.println("<footer>");
                out.println("<p>Alunos: Jocineudo Oliveira Jonas Sales Thais Ribeiro © 2024</p>");
                out.println("</footer>");
            }
        %>
    </body>
</html>