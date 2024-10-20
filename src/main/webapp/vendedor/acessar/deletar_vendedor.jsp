<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Formulário de Cadastro</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
    </head>

    <body>
        <%  
            Usuario a = (Usuario) session.getAttribute("usuario");
            String vendedor = "vendedor";
            String admin = "admin";
            if (a.getTipodeUsuario().equals(vendedor) || a.getTipodeUsuario().equals(admin)) {
                out.println("<form action='http://localhost:8080/DeletarClienteServlet' method='post'>");
                out.println("<h2>Deletar</h2>");
                out.println("<label>ID do vendedor</label>");
                out.println("<input type='number' id='id' name='id' required>");
                out.println("<input type='submit' value='Deletar'>");
                out.println("</form>");
            } else {
                out.println("<script type='module'>");
                out.println("import { redirecionar } from 'http://localhost:8080/utils.js';");
                out.println("redirecionar('http://localhost:8080/home.jsp');");
                out.println("</script>");
            }
        %>
    </body>
</html>
