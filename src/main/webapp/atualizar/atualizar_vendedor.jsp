<%@page import="bancodedados.Usuario"%>
<%@page import="bancodedados.Vendedor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atualizar vendedor</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraCPF } from 'http://localhost:8080/utils.js';
            window.mascaraCPF = mascaraCPF;
        </script>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <%
            Vendedor usuarioLogado = (Vendedor) session.getAttribute("vendedor") != null
                        ? (Vendedor) session.getAttribute("vendedor")
                        : (Vendedor) session.getAttribute("admin");
            String vendedor = "vendedor";
            String admin = "admin";
            if (usuarioLogado.getTipodeUsuario().equals(vendedor) || usuarioLogado.getTipodeUsuario().equals(admin)) { %>
        <form action="http://localhost:8080/AtualizarVendedorServlet" method="post">
            <h2>Atualização de dados</h2>
            <label>Nome:</label>
            <input type="text" id="nome" name="nome" required value="<%= usuarioLogado.getNome() %>">
            <label>CPF: </label>
            <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required
                   value="<%= usuarioLogado.getCpf() %>">
            <label>Email:</label>
            <input type="email" id="email" name="email" required value="<%= usuarioLogado.getEmail()%>">
            <label>CNPJ: </label>
            <input type="text" id="cnpj" name="cnpj" maxlength="18" pattern=".{18,18}" required value="<%= usuarioLogado.getCnpj()%>">
            <label>Cidade: </label>
            <input type="text" id="cidade" name="cidade" maxlength="30"  required value="<%= usuarioLogado.getCidade() %>">
            <label>Estado: </label>
            <input type="text" id="estado" name="estado" maxlength="2" pattern=".{2,2}" required value="<%= usuarioLogado.getEstado() %>">
            <label>Senha:</label>
            <input type="password" id="senha" name="senha" required>
            <input type="submit" value="Atualizar">
             
        </form>
       <%}%>
    </body>
</html>
