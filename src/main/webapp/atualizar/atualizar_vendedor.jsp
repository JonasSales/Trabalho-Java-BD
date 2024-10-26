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
        import { mascaraCPF, redirecionar, mascaraData } from 'http://localhost:8080/utils.js';
        window.mascaraCPF = mascaraCPF;
        window.mascaraData = mascaraData;
        window.redirecionar = redirecionar;
    </script>
    <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
</head>
<body>
<%
    Usuario usuarioLogado = session.getAttribute("vendedor") != null
        ? (Vendedor) session.getAttribute("vendedor")
        : (Usuario) session.getAttribute("admin");
    
    boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("cliente");
    boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("admin");
    boolean verificadorTres = usuarioLogado.getTipodeUsuario().equals("vendedor");

    if (verificadorUm || verificadorDois || verificadorTres) {
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
                <input type="text" id="nome" name="nome" required value="<%= vendedor.getEmail()%>">
                <label>CPF: </label>
                <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required
                       value="<%= vendedor.getCpf()%>">
                <label>CNPJ: </label>
                <input type="text" id="cnpj" name="cnpj" maxlength="18" pattern=".{18,18}" required
                       value="<%= vendedor.getCnpj()%>">
                <label>Cidade: </label>
                <input type="text" id="cidade" name="cidade" required
                       value="<%= vendedor.getCidade()%>">
                <label>Estado:
                <select  id="estado" name="estado">
                <option value="Acre">AC</option>
                <option value="Alagoas">AL</option>
                <option value="Amapá">AP</option>
                <option value="Amazonas">AM</option>
                <option value="Bahia">BA</option>
                <option value="Ceará">CE</option>
                <option value="Espírito Santo">ES</option>
                <option value="Goiás">GO</option>
                <option value="Maranhão">MA</option>
                <option value="Mato Grosso">MT</option>
                <option value="Mato Grosso do Sul">MS</option>
                <option value="Minas Gerais">MG</option>
                <option value="Pará">PA</option>
                <option value="Paraíba">PB</option>
                <option value="Paraná">PR</option>
                <option value="Pernambuco">PE</option>
                <option value="Piauí">PI</option>
                <option value="Rio de Janeiro">RJ</option>
                <option value="Rio Grande do Norte">RN</option>
                <option value="Rio Grande do Sul">RS</option>
                <option value="Rondônia">RO</option>
                <option value="Roraima">RR</option>
                <option value="Santa Catarina">SC</option>
                <option value="São Paulo">SP</option>
                <option value="Sergipe">SE</option>
                <option value="Tocantins">TO</option>
                <option value="Distrito Federal">DF</option>
            </select>
            </label>
                <label>Senha:</label>
                <input type="password" id="senha" name="senha" required>
                <input type="hidden" name="id" value="<%= vendedor.getId() %>">
                <input type="submit" value="Atualizar">
            </form>
        <% } else { %>
            <p>Usuário não encontrado.</p>
        <% } %>
    <% } else if (verificadorUm || verificadorTres) {
    Vendedor vendedorLogado = VendedorDAO.buscarVendedor(" ", usuarioLogado.getId());
    %>
        <form action="http://localhost:8080/AtualizarClienteServlet" method="post">
            <label>Nome:</label>
            <input type="text" id="nome" name="nome" required value="<%= vendedorLogado.getNome()%>">
            <label>CPF: </label>
            <input type="text" id="cpf" name="cpf" maxlength="14" pattern=".{14,14}" oninput="mascaraCPF(this)" required
                   value="<%= vendedorLogado.getCpf()%>">
            <label>Email:</label>
            <input type="email" id="email" name="email" required value="<%= vendedorLogado.getEmail()%>">
            <label>Cidade</label>
            <input type="text" id="cidade" name="cidade" required value="<%= vendedorLogado%>">
            <label>CNPJ:</label>
            <input type="email" id="email" name="email" required value="<%= vendedorLogado.getCnpj()%>">
            <label>Email:</label>
            <input type="email" id="email" name="email" required value="<%= vendedorLogado.getEmail()%>">
            <label>Senha:</label>
            <input type="password" id="senha" name="senha" required>
            <input type="hidden" name="id" value="<%= vendedorLogado.getId() %>">
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
