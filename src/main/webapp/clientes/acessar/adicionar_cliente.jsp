<%@page import="bancodedados.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% String erro = (String)request.getAttribute("erro"); %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastrar</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraCPF } from 'http://localhost:8080/utils.js';
            window.mascaraCPF = mascaraCPF;
        </script>
    </head>
    <body>

            <form action="http://localhost:8080/CadastrarClienteServlet" method="post">
            <h2>Cadastrar</h2>
            <label>Nome:</label>
            <input type="text" id="nome" name="nome" required>
            <label>CPF: </label>
            <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required>
            <label>Email:</label>
            <input type="email" id="email" name="email" required>
            <label>Data de Nascimento:</label>
            <input type="date" id="datadenascimento" name="datadenascimento" required>
            <label>Senha:</label>
            <input type= "password" id="senha" name="senha" required>
            <input type="submit" value="Cadastrar">
            </form>
        
            <%if (erro != null) {
                    out.print(erro);
                }
            %>

    </body>
</html>
