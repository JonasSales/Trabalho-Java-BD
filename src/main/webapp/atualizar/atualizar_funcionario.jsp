<%@page import="bancodedados.Funcionario"%>
<%@page import="bancodedados.Vendedor"%>
<%@page import="java.sql.*" %>
<%@page import="dao.FuncionarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Atualizar Funcionário</title>
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
        if (usuarioLogado != null &&
             usuarioLogado.getTipodeUsuario().equals("admin") || 
             usuarioLogado.getTipodeUsuario().equals("vendedor")) {
    %>

    <form method="GET" action="">
        <label for="idFuncionario">Pesquisar por ID:</label>
        <input type="number" id="idFuncionario" name="idFuncionario" required>
        <input type="submit" value="Pesquisar">
    </form>

    <% 
        String idFuncionarioStr = request.getParameter("idFuncionario");
        Funcionario funcionario = null;
        
        if (idFuncionarioStr != null && !idFuncionarioStr.isEmpty()) {
            funcionario = FuncionarioDAO.buscarFuncionario(" ", Integer.parseInt(idFuncionarioStr));
        }
        if (funcionario != null) {
    %>
    <form action="http://localhost:8080/AtualizarFuncionarioServlet" method="post">
        <h2>Atualizar dados do Funcionário</h2>
        <input type="hidden" name="id" value="<%= funcionario.getId() %>">
        <label>Nome:</label>
        <input type="text" id="nome" name="nome" value="<%= funcionario.getNome() %>" required> 
        <label>CPF:</label>
        <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" value="<%= funcionario.getCpf() %>" oninput="mascaraCPF(this)" required>
        <label>Email:</label>
        <input type="email" id="email" name="email" value="<%= funcionario.getEmail() %>" required>
        <label>Salário:</label>
        <input type="text" id="salario" name="salario" value="<%= funcionario.getSalario() %>" required>
        <label>Cargo:</label>
        <input type="text" id="cargo" name="cargo" value="<%= funcionario.getCargo() %>" required>
        <label>Senha:</label>
        <input type="password" id="senha" name="senha" required>
        <input type="hidden" name="idFuncionario" value="<%= funcionario.getId() %>">
        <input type="submit" value="Atualizar">
    </form>
    <% 
        } else {
            out.println("<p>Funcionário não encontrado.</p>");
        }
    } else {
    %>
    <script>
        redirecionar('http://localhost:8080/redirecionarMenu.jsp');
    </script>
    <% } %>
</body>
</html>
