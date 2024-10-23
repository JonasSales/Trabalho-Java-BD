<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Formul�rio de Cadastro</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script src="http://localhost:8080/utils.js"></script>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("funcionario") != null
                    ? (Usuario) session.getAttribute("funcionario")
                    : (session.getAttribute("admin") != null
                    ? (Usuario) session.getAttribute("admin")
                    : (Usuario) session.getAttribute("cliente"));
            
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("cliente");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            boolean verificadorTres = usuarioLogado.getTipodeUsuario().equals("vendedor");
            if (verificadorUm || verificadorDois || verificadorTres) {%>
        <form action="http://localhost:8080/DeletarClienteServlet" method="post" onsubmit="reloadPage()">
            <%out.println("<input type=\"hidden\" name=\"id\" value=\"" + usuarioLogado.getId() + "\">");%>
            <input type="submit" value="Deletar Minha Conta">
        </form>
        <script>
            function reloadPage()
            {
                setTimeout(function () {
                    location.reload();
                }, 1000);
            }
        </script>
        <%}%>
    </body>
</html>
