<%@page import="bancodedados.Usuario"%>
<%@page import="dao.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atualização</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraCPF, redirecionar } from 'http://localhost:8080/utils.js';
            window.mascaraCPF = mascaraCPF;
            window.redirecionar = redirecionar;
        </script>
    </head>
    <body>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("cliente");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            if (verificadorUm || verificadorDois) {%>
        <h2>Atualização</h2>
        <form action="http://localhost:8080/AtualizarClienteServlet" method="post">
            <%if (verificadorDois) {%>
            <label>Id do cliente:</label>
            <input type="text" id="id_cliente" name="id_cliente" required>
            <%}%>
            <label>Nome:</label>
            <input type="text" id ="nome" name="nome" required>
            <label>CPF: </label>
            <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required>
            <label>Email:</label>
            <input type="email" id="email" name="email" required>
            <label>Data de Nascimento:</label>
            <input type="date" id="datadenascimento" name="datadenascimento" required>
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
