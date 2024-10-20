<%@page import="bancodedados.Usuario"%>
<%@page import="bancodedados.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atualização</title>
        <link rel="stylesheet" href="http://localhost:8080/style/configuracoesCRUD.css"/>
        <script type="module">
            import { mascaraCPF, redirecionar } from 'http://localhost:8080/utils.js';
            window.mascaraCPF = mascaraCPF;
            window.redirecionar = redirecionar;
        </script>
    </head>
    <body>
        <%
                Usuario a = (Usuario) session.getAttribute("usuario");
                String cliente = "cliente";
                String admin = "admin";

                if (a != null && (a.getTipodeUsuario().equals(cliente) || a.getTipodeUsuario().equals(admin))) {
                    out.println("<form action=\"http://localhost:8080/AtualizarClienteServlet\" method=\"post\">");
                    out.println("<h2>Atualização</h2>");

                    if (a.getTipodeUsuario().equals(admin)) {
                        out.println("</form>");
                        out.println("<label>Id do cliente:</label>");
                        out.println("<input type=\"text\" id=\"id_cliente\" name=\"id_cliente\" required>");
                        out.println("<input type=\"submit\" value=\"Buscar\">");

                        out.println("<label>Nome:</label>");
                        out.println("<input type=\"text\" id=\"nome\" name=\"nome\" \" required>");
                        out.println("<label>CPF: </label>");
                        out.println("<input type=\"text\" id=\"cpf\" name=\"cpf\" maxlength=\"14\" pattern=\".{14,14}\" oninput=\"mascaraCPF(this)\" \" required>");
                        out.println("<label>Email:</label>");
                        out.println("<input type=\"email\" id=\"email\" name=\"email\" value=\" \" required>");
                        out.println("<label>Data de Nascimento:</label>");
                        out.println("<input type=\"date\" id=\"datadenascimento\" name=\"datadenascimento\" value=\"\" required>");
                        out.println("<label>Senha:</label>");
                        out.println("<input type=\"password\" id=\"senha\" name=\"senha\" required>");
                        out.println("<input type=\"submit\" value=\"Atualizar\">");
                    
                    }
                }
                out.println("</form>");
            }

            }
        %>
    </body>
</html>
