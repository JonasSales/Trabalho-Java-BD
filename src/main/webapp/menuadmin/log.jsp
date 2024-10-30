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
            
            out.println("<table>");
            out.println("<tr><th>Data</th><th>Hora</th><th>Ação</th><th>Tabela</th><th>Id de quem alterou</th> <th>Tipo de usuario</th></tr>");
            ArrayList<Log> logs = LogDAO.BuscarLog();
            session.setAttribute("logs", logs);
            
        %>
        
        <form method="post" action="http://localhost:8080/arquivoLog" target="_blank">
                        <input type="submit" value="Baixar logs">
        </form>

        <%for (Log u : logs) {
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
