<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Formulário de Cadastro</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script src="http://localhost:8080/utils.js"></script>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("admin") != null
                    ? (Usuario) session.getAttribute("admin")
                    : (Usuario) session.getAttribute("funcionario") != null
                    ? (Usuario) session.getAttribute("funcionario")
                    : (session.getAttribute("vendedor") != null
                    ? (Usuario) session.getAttribute("vendedor")
                    : (Usuario) session.getAttribute("cliente"));

            if (usuarioLogado != null) {
                boolean isCliente = usuarioLogado.getTipodeUsuario().equals("cliente");
                boolean isFuncionario = usuarioLogado.getTipodeUsuario().equals("funcionario");
                boolean isVendedor = usuarioLogado.getTipodeUsuario().equals("vendedor");
                boolean isAdmin = usuarioLogado.getTipodeUsuario().equals("admin");
        %>
        <%-- Formulário para o cliente deletar sua própria conta --%>
        <% if (isCliente || isFuncionario || isVendedor) { %>
        <form action="http://localhost:8080/DeletarClienteServlet" method="post">
            <% out.println("<input type=\"hidden\" name=\"id\" value=\"" + usuarioLogado.getId() + "\">"); %>
            <input type="submit" value="Deletar Minha Conta">
        </form>
        <% } %>

        <%-- Formulário para o admin deletar conta de usuário --%>
        <% if (isAdmin) { %>
        <form action="http://localhost:8080/DeletarClienteServlet" method="post">
            <input type="number" name="id" placeholder="ID do usuário a ser deletado" required>
            <input type="submit" value="Deletar Conta de Usuário">
        </form>
        <% } %>
        <%
            } else {
                out.println("<p>Você precisa estar logado para acessar esta página.</p>");
            }
        %>
    </body>
</html>
