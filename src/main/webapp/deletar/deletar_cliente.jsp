<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Formulário de Cadastro</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script src="http://localhost:8080/utils.js"></script>
    </head>

    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("cliente");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            boolean verificadorTres = usuarioLogado.getTipodeUsuario().equals("vendedor");
            if (verificadorUm || verificadorDois || verificadorTres) {
                if (verificadorDois) {%>
        <form action="http://localhost:8080/DeletarClienteServlet" method="post">
            <label>Preencha o ID</label>
            <input type="number" id="id" name="id" required>
            <input type="submit" value="Deletar">
        </form>
        <%} else if (verificadorUm || verificadorTres) {%>
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
        <%}%>
    </body>
</html>
