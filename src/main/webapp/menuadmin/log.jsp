<%@ page import="dao.LogDAO" %>
<%@ page import="bancodedados.Log" %>
<%@ page import="java.util.ArrayList"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Logs</title>
     <link rel="stylesheet" href="http://localhost:8080/style/configuracoesTabelas.css"/>
     <link rel="icon" href="http://localhost:8080/lenobrega.jpg" type="image/png">
</head>
<body>
    <h1>Logs</h1>
    <%
        ArrayList<Log> logs = LogDAO.BuscarLog();
       
        // Criar tabela para exibir os logs
        out.println("<table>");
        out.println("<tr><th>Data</th><th>Hora</th><th>Ação</th><th>Tabela</th><th>Id de quem alterou</th> <th>Tipo de usuario</th></tr>");
        
        for (Log u : logs) {
            out.println("<tr>");
            out.println("<td>" + u.getData() + "</td>");
            out.println("<td>" + u.getHora() + "</td>");
            out.println("<td>" + u.getAcao() + "</td>");
            out.println("<td>" + u.getTabela() + "</td>");
            out.println("<td>" + u.getId_usuario() + "</td>");
            out.println("<td>" + u.getTipoUsuario() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    %>
</body>
</html>
