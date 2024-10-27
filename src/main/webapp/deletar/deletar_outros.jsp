<%@page import="bancodedados.Funcionario"%>
<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Estoque"%>
<%@page import="bancodedados.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Atualizar estoque</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraDimensoes, redirecionar } from 'http://localhost:8080/utils.js';
            window.mascaraDimensoes = mascaraDimensoes;
            window.redirecionar = redirecionar;
        </script>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("admin") != null
                    ? (Usuario) session.getAttribute("admin")
                    : (Usuario) session.getAttribute("vendedor");
            Usuario usuario = null;
            boolean verificadorUm = usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals("admin");
            boolean verificadorDois = usuarioLogado != null && usuarioLogado.getTipodeUsuario().equals("vendedor");

            if (verificadorUm || verificadorDois) {
        %>
        <form method="GET" action="">
            <label for="id">Pesquisar por ID:</label>
            <input type="number" id="id" name="id" required>
            <input type="submit" value="Pesquisar">
        </form>
        <%
                String idUsuario = request.getParameter("id");
                if (idUsuario != null && !idUsuario.isEmpty()) {
                    usuario = UsuarioDAO.buscarUsuario(" ", Integer.parseInt(idUsuario));
                }
            }
    if ( (usuario == null) || (usuario.getNome() == null) || usuario.getTipodeUsuario().equals("admin")) {%>
        <p>Não existe esse usuário na lista</p> <%} else {%>
        <form action="http://localhost:8080/DeletarClienteServlet" method="post">
            <h2>Deletar</h2>
            <label>Nome:</label>
            <input type="text" id="nome" name="nome" required value="<%= usuario.getNome()%>">
            <label>Cpf:</label>
            <input type="text" id="nome" name="nome" required value="<%= usuario.getCpf()%>">
            <label>Email:</label>
            <input type="text" id="nome" name="nome" required value="<%= usuario.getEmail()%>">
            <input type="hidden" name="id" value="<%= usuario.getId()%>">
            <input type="submit" value="Deletar">
        </form>
        <%}%>
    </body>
</html>
