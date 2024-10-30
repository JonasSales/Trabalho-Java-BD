<%@page import="dao.UsuarioDAO"%>
<%@page import="bancodedados.Vendedor"%>
<%@page import="bancodedados.Usuario"%>
<%@page import="dao.VendedorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Atualização</title>
    <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
    <script type="module">
        import { mascaraCPF, redirecionar, mascaraCNPJ } from 'http://localhost:8080/utils.js';
        window.mascaraCPF = mascaraCPF;
        window.redirecionar = redirecionar;
        window.mascaraCNPJ = mascaraCNPJ;
    </script>
    <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
</head>
<body>
<%
    Usuario usuarioLogado = session.getAttribute("vendedor") != null
    ? (Vendedor) session.getAttribute("vendedor")
    : session.getAttribute("funcionario") != null
        ? (Usuario) session.getAttribute("funcionario")
        : (Usuario) session.getAttribute("admin");
    
    boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("funcionario");
    boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
    boolean verificadorTres = usuarioLogado.getTipodeUsuario().equals("vendedor");

    if ( verificadorUm||verificadorDois || verificadorTres) {
%>
    <h2>Atualização</h2>
    <% if (verificadorDois) { %>
        <form method="GET" action="">
            <label for="id">Pesquisar por ID:</label>
            <input type="number" id="id" name="id" required>
            <input type="submit" value="Pesquisar">
        </form>
        <%
            String idFuncionarioStr = request.getParameter("id");
            Vendedor vendedor = null;

            if (idFuncionarioStr != null && !idFuncionarioStr.isEmpty()) {
            
                vendedor = VendedorDAO.buscarVendedor(" ", Integer.parseInt(idFuncionarioStr));
            }
            if (vendedor != null) {
        %>
            <form action="http://localhost:8080/AtualizarClienteServlet" method="post">
                <label>Nome:</label>
                <input type="text" id="nome" name="nome" required value="<%= vendedor.getNome()%>">
                <label>Email:</label>
                <input type="email" id="email" name="email" required value="<%= vendedor.getEmail()%>">
                <label>CPF: </label>
                <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required
                       value="<%= vendedor.getCpf()%>">
                <label>Senha:</label>
                <input type="password" id="senha" name="senha" required>
                <input type="hidden" name="id" value="<%= vendedor.getId() %>">
                <input type="submit" value="Atualizar">
            </form>
        <% } else { %>
            <p>Usuário não encontrado.</p>
        <% } %>
    <% } else if (verificadorUm || verificadorTres) {
    Usuario funcionarioLogado = UsuarioDAO.buscarUsuario(" ", usuarioLogado.getId());
    %>
        <form action="http://localhost:8080/AtualizarClienteServlet" method="post">
            <label>Nome:</label>
            <input type="text" id="nome" name="nome" required value="<%= funcionarioLogado.getNome()%>">
            <label>CPF: </label>
            <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required
                   value="<%= funcionarioLogado.getCpf()%>">
            <label>Email:</label>
            <input type="email" id="email" name="email" required value="<%= funcionarioLogado.getEmail()%>">
            <label>Senha:</label>
            <input type="password" id="senha" name="senha" required>
            <input type="hidden" name="id" value="<%= funcionarioLogado.getId() %>">
            <input type="submit" value="Atualizar">
        </form>
    <% } %>
<% } else { %>
    <div>
        Você não tem permissão para acessar esta página. Por favor, entre como cliente.
    </div>
    <script>
        setTimeout(function () {
            window.location.href = 'http://localhost:8080/redirecionarMenu.jsp'; // Redireciona após 5 segundos
        }, 1000);
    </script>
<% } %>
</body>
</html>
