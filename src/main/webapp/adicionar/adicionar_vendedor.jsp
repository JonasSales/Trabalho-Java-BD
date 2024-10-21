<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trabalhe conosco</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraCPF } from 'http://localhost:8080/utils.js';
            window.mascaraCPF = mascaraCPF;
        </script>
    </head>
    <body>
            <form action="http://localhost:8080/CadastrarVendedorServlet" method="post">
            <h2>Insira os dados abaixo</h2>
            <label>Nome:</label>
            <input type="text" id="nome" name="nome" required>
            <label>CPF: </label>
            <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required>
            <label>Email:</label>
            <input type="email" id="email" name="email" required>
            <label>Data de Nascimento:</label>
            <input type="date" id="datadenascimento" name="datadenascimento" required>
            <label>CNPJ: </label>
            <input type="text" id="cnpj" name="cnpj" maxlength="18" pattern=".{18,18}" required>
            <label>Cidade: </label>
            <input type="text" id="cidade" name="cidade" maxlength="30"  required>
            <label>Estado: </label>
            <input type="text" id="estado" name="estado" maxlength="2" pattern=".{2,2}" required>
            <label>Senha:</label>
            <input type="password" id="senha" name="senha" required>
            <input type="submit" value="Cadastrar">
            </form>
    </body>
</html>
