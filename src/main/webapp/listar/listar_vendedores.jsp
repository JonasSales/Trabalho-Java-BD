<%@ page import="dao.UsuarioDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="bancodedados.Usuario"%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listar Vendedores</title>
    <link rel="stylesheet" href="http://localhost:8080/style/configuracoesTabelas.css"/>
</head>
<body>
    <h1>Lista de vendedores</h1>
    <a href="http://localhost:8080/redirecionarMenu.jsp">Retornar para página principal</a>
    <%
        // Configurações da conexão
        ArrayList<Usuario> vendedores = UsuarioDAO.BuscarClientes("vendedor");
       
        // Criar tabela para exibir os clientes
        out.println("<table>");
        out.println("<tr><th>ID</th><th>Nome</th><th>CPF</th><th>Email</th><th>Data de Nascimento</th></tr>");
        
        for (Usuario u : vendedores) {
            out.println("<tr>");
            out.println("<td>" + u.getId() + "</td>");
            out.println("<td>" + u.getNome() + "</td>");
            out.println("<td>" + u.getCpf() + "</td>");
            out.println("<td>" + u.getEmail() + "</td>");
            out.println("<td>" + u.getDatadenascimento() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    %>
</body>
</html>
