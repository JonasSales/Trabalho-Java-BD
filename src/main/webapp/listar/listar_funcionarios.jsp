<%@page import="bancodedados.Funcionario"%>
<%@page import="bancodedados.Usuario"%>
<%@ page import="dao.FuncionarioDAO"%>
<%@ page import="java.util.ArrayList"%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listar Clientes</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesTabelas.css"/>
        <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
    </head>
    <body>
        <h1>Lista de seus funcionários</h1>
        <%
            Usuario usuarioLogado = (Usuario) session.getAttribute("vendedor") != null
                        ? (Usuario) session.getAttribute("vendedor")
                        : (Usuario) session.getAttribute("admin");
            boolean verificadorUm = usuarioLogado.getTipodeUsuario().equals("admin");
            boolean verificadorDois = usuarioLogado.getTipodeUsuario().equals("vendedor");
            if (verificadorUm || verificadorDois) {
                ArrayList<Funcionario> funcionario = FuncionarioDAO.buscarFuncionarios(usuarioLogado); %>
        <table>
            <tr><th>ID</th><th>Nome</th><th>Salario</th><th>Cargo</th></tr>
                    <%for (Funcionario u : funcionario) {
                                out.println("<tr>");
                                out.println("<td>" + u.getId() + "</td>");
                                out.println("<td>" + u.getNome() + "</td>");
                                out.println("<td>" + u.getSalario() + "</td>");
                                out.println("<td>" + u.getCargo() + "</td>");
                                out.println("</tr>");
                            }
                        }%>
        </table>
    </body>
</html>
