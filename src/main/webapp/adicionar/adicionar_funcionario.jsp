<%@page import="bancodedados.Vendedor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atualizar Funcionario</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraCPF, redirecionar, mascaraSalario} from 'http://localhost:8080/utils.js';
            window.mascaraCPF = mascaraCPF;
            window.redirecionar = redirecionar;
            window.mascaraSalario = mascaraSalario;
        </script>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <%
            Vendedor usuarioLogado = (Vendedor) session.getAttribute("vendedor");
            boolean verificador = usuarioLogado.getTipodeUsuario().equals("vendedor");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
            if (verificador || verificadorDois) {%>
        <form action="http://localhost:8080/CadastrarFuncionarioServlet" method="post">
            <h2>Cadastrar Funcionario</h2>
            <label>Nome:</label>
            <input type="text" id="nome" name="nome" required> 
            <label>CPF: </label>
            <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required>
            <label>Email:</label>
            <input type="email" id="email" name="email" required>
            <label>Salario: </label>
            <input type="text" id="salario" name="salario" required oninput="mascaraSalario(this)">
            <label>Cargo:</label>
            <input type="text" id="cargo" name="cargo" required>
            <label>Senha:</label>
            <input type="password" id ="senha" name="senha" >
            <input type="submit" value="Cadastrar">
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
