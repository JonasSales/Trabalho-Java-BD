<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Formul�rio de Cadastro</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script src="http://localhost:8080/utils.js"></script>
    </head>

    <body>
        <%
            Usuario a = (Usuario) session.getAttribute("usuario");
            String cliente = "cliente";
            String admin = "admin";

            if (a != null) { // Verifica se o usu�rio est� logado
                if (a.getTipodeUsuario().equals(admin)) {
                    out.println("<form action=\"http://localhost:8080/DeletarClienteServlet\" method=\"post\">");
                    out.println("<h2>Deletar Usu�rio</h2>");
                    out.println("<label>ID do usu�rio:</label>");
                    out.println("<input type=\"number\" id=\"id\" name=\"id\" required>");
                    out.println("<input type=\"submit\" value=\"Deletar\">");
                    out.println("</form>");
                } else {
                    // Redirecionar para a p�gina de confirma��o
                    out.println("<form id=\"deleteForm\" action=\"http://localhost:8080/DeletarClienteServlet\" method=\"post\" onsubmit=\"reloadPage()\">");
                    out.println("<input type=\"hidden\" name=\"id\" value=\"" + a.getId() + "\">");
                    out.println("<input type=\"submit\" value=\"Deletar Minha Conta\">");
                    out.println("</form>");
                    out.println("<script>");
                    out.println("function reloadPage() {");
                    out.println("    setTimeout(function() { location.reload(); }, 1000);"); // Ajuste o tempo se necess�rio
                    out.println("}");
                    out.println("</script>");

                }
            } else {
                out.println("<script>");
                out.println("redirecionar('http://localhost:8080/login.html');"); // Redirecionar para login se n�o estiver logado
                out.println("</script>");
            }

            // Aqui voc� pode adicionar l�gica para redirecionar ap�s a dele��o
            // Isso depender� da resposta do servlet DeletarClienteServlet
%>
    </body>
</html>
