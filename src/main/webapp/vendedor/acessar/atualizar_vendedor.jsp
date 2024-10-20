<%@page import="bancodedados.Usuario"%>
<%@page import="bancodedados.Funcionario"%>
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
    </head>
    <body>
        <% 
            Usuario a = (Usuario) session.getAttribute("usuario");
            String vendedor = "vendedor";
            String admin = "admin";
            if (a.getTipodeUsuario().equals(vendedor) || a.getTipodeUsuario().equals(admin)) {
                out.println("<form action=\"http://localhost:8080/AtualizarVendedorServlet\" method=\"post\">");
                out.println("<h2>Atualização de dados</h2>");
                if (a.getTipodeUsuario().equals(admin)) {
                        out.println("<label>Id do vendedor</label>");
                        out.println("<input type=\"text\" id=\"id_vendedor\" name=\"id_vendedor\" required>");
                    }
            out.println("<form action=\"http://localhost:8080/AtualizarVendedorServlet\" method=\"post\">");
            out.println("<label>Nome:</label>");
            out.println("<input type=\"text\" id=\"nome\" name=\"nome\" required>");
            out.println("<label>CPF: </label>");
            out.println("<input type=\"text\" id=\"cpf\" name=\"cpf\" maxlength=\"14\" pattern=\".{14,14}\" oninput=\"mascaraCPF(this)\" required>");
            out.println("<label>Email:</label>");
            out.println("<input type=\"email\" id=\"email\" name=\"email\" required>");
            out.println("<label>Data de Nascimento:</label>");
            out.println("<input type=\"date\" id=\"datadenascimento\" name=\"datadenascimento\" required>");
            
            out.println("<label>CNPJ: </label>");
            out.println("<input type=\"text\" id=\"cnpj\" name=\"cnpj\" maxlength=\"18\" pattern=\".{18,18}\" required>");
            
            out.println("<label>Cidade: </label>");
            out.println("<input type=\"text\" id=\"cidade\" name=\"cidade\" maxlength=\"30\"  required>");
            
            out.println("<label>Estado: </label>");
            out.println("<input type=\"text\" id=\"estado\" name=\"estado\" maxlength=\"2\" pattern=\".{2,2}\" required>");
            
            out.println("<label>Senha:</label>");
            out.println("<input type=\"password\" id=\"senha\" name=\"senha\" required>");
            out.println("<input type=\"submit\" value=\"Cadastrar\">");
            out.println("</form>");
            }
        %>
    </body>
</html>
