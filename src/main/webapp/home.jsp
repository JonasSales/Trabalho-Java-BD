<%@page import="bancodedados.Usuario"%>
<%@page import="dao.UsuarioDAO"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Página Principal</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesPGP.css"/>
        
    </head>
    <body>
        <header>
            <h1>Inicio</h1>
        </header>
        <%
            Usuario a = (Usuario) session.getAttribute("usuario");
            if (a != null) {
                out.println("<nav>");
                out.println("<a>Seja bem vindo " + a.getNome()+ "</a>");
                out.println("<br><br/>");
                out.println("<a href=\"clientes/index.jsp\" >Clientes</a>");
                out.println("<a href=\"estoque/index.jsp\" >Estoque</a>");
                out.println("<a href=\"produtos/index.jsp\" >Produtos</a>");
                out.println("<a href=\"log/index.jsp\" >Logs</a>");
                out.println("<a href=\"funcionarios/index.jsp\" >Funcionarios</a>");
                out.println("<a href=\"vendedor/index.jsp\" >Vendedores</a>");
                out.println("<a href=\"admin/index.jsp\" >Admin</a>");
                out.println("<a href=\"localhost:8080/LogoutServlet\">Sair</a>");
                out.println("</nav>");

            } else {
                out.println("<script>");
                out.println("setTimeout(function() {");
                out.println("window.location.href = 'http://localhost:8080/index.jsp';"); // Substitua pela sua página principal
                out.println("}, 0);"); // Redireciona após 5 segundos
                out.println("</script>");
            }
        %>
        <footer>
            <p>Alunos: Jocineudo Oliveira Jonas Sales Thais Ribeiro © 2024</p>
        </footer>
    </body>
</html>