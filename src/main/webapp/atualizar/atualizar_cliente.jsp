<%@page import="bancodedados.Usuario"%>
<%@page import="bancodedados.Funcionario"%>
<%@page import="dao.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atualização</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraCPF, redirecionar, mascaraData } from 'http://localhost:8080/utils.js';
            window.mascaraCPF = mascaraCPF;
            window.mascaraData = mascaraData;
            window.redirecionar = redirecionar;
        </script>
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
            boolean verificadorTres = usuarioLogado.getTipodeUsuario().equals("funcionario");

            if (verificadorUm || verificadorDois || verificadorTres) {
        %>
        <form action="http://localhost:8080/AtualizarClienteServlet" method="post">
            <h2>Atualização</h2>
            <%if (verificadorDois) {%>
            <label>Id do cliente:</label>
            <input type="text" id="id_cliente" name="id_cliente" required>
            <script>
                var input = document.getElementById("id_cliente");
                var numero = Number(input.value);
            </script>
            <%}%>
            <label>Nome:</label>
            <input type="text" id="nome" name="nome" required value="<%= usuarioLogado.getNome()%>">
            <label>CPF: </label>
            <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required
                   value="<%= usuarioLogado.getCpf()%>">
            <label>Email:</label>
            <input type="email" id="email" name="email" required value="<%= usuarioLogado.getEmail()%>">
            <label>Senha:</label>
            <input type="password" id="senha" name="senha" required>
            <input type="submit" value="Atualizar">
        </form>
        <%} else {%>
        <div>
            Você não tem permissão para acessar esta página. Por favor, entre como cliente.
        </div>
        <script>
            setTimeout(function () {
                window.location.href = 'http://localhost:8080/redirecionarMenu.jsp'; // Redireciona após 5 segundos
            }, 5000);
        </script>
        <%}%>
    </body>
</html>
