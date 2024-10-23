<%@page import="bancodedados.Vendedor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atualizar Funcionario</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraCPF, redirecionar } from 'http://localhost:8080/utils.js';
            window.mascaraCPF = mascaraCPF;
            window.redirecionar = redirecionar;
        </script>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <%
            Vendedor usuarioLogado = (Vendedor) session.getAttribute("vendedor");
            boolean verificador = usuarioLogado.getTipodeUsuario().equals("funcionario");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            boolean verificadorTres = usuarioLogado.getTipodeUsuario().equals("vendedor");
            if (verificador || verificadorDois || verificadorTres) {%>
        <form action="http://localhost:8080/AtualizarFuncionarioServlet" method="post">
            <h2>Atualizar dados</h2>
            <% if (verificadorTres || verificadorDois) { %>
            <label>Id funcionario:</label>
            <%%>
            <input type="text" id="id" name="id" required>
            <% }%>
            <label>Nome:</label>
            <input type="text" id="nome" name="nome" required> 
            <label>CPF: </label>
            <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required>
            <label>Email:</label>
            <input type="email" id="email" name="email" required>
            <label>Salario: </label>
            <input type="number" id="salario" name="salario" required>
            <label>Cargo:</label>
            <input type="text" id="cargo" name="cargo" required>
            <label>Senha:</label>
            <input type="password" id ="senha" name="senha" required>
            <input type="submit" value="Atualizar">
        </form> 
        <% } else {
        %>
        <script>
            redirecionar('http://localhost:8080/redirecionarMenu.jsp');
        </script>

        <%}%>

    </body>
</html>
